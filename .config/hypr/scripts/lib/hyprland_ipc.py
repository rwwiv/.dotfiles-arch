from __future__ import annotations
import asyncio
import os
import sys
from collections import defaultdict
from typing import Callable, Awaitable, Optional, List, Dict

# Define the signature for our event handler functions:
# func(ctx: Hyprland, data: str) -> (awaitable) None
EventHandler = Callable[['Hyprland', str], Awaitable[None]]

class Hyprland:
    def __init__(self) -> None:
        self.signature: Optional[str] = os.getenv("HYPRLAND_INSTANCE_SIGNATURE")
        self.runtime_dir: Optional[str] = os.getenv("XDG_RUNTIME_DIR")
        
        # Explicitly type the dictionary mapping events to lists of handlers
        self.handlers: Dict[str, List[EventHandler]] = defaultdict(list)
        
        if not self.signature or not self.runtime_dir:
            raise EnvironmentError("Hyprland environment variables (HYPRLAND_INSTANCE_SIGNATURE, XDG_RUNTIME_DIR) not found.")

        self.event_sock_path: str = f"{self.runtime_dir}/hypr/{self.signature}/.socket2.sock"
        self.cmd_sock_path: str = f"{self.runtime_dir}/hypr/{self.signature}/.socket.sock"

    def on(self, event_name: str) -> Callable[[EventHandler], EventHandler]:
        """
        Decorator to register a handler for a specific event.
        
        Usage:
            @h.on("workspace")
            async def my_handler(ctx: Hyprland, data: str) -> None: ...
        """
        def decorator(func: EventHandler) -> EventHandler:
            self.handlers[event_name].append(func)
            return func
        return decorator

    async def _send(self, message: str) -> Optional[str]:
        """Internal helper to write bytes to the command socket."""
        try:
            reader, writer = await asyncio.open_unix_connection(self.cmd_sock_path)
            writer.write(message.encode())
            await writer.drain()
            
            # Hyprland responses are usually short, 4KB buffer is plenty
            data: bytes = await reader.read(4096)
            
            writer.close()
            await writer.wait_closed()
            return data.decode().strip()
        except Exception as e:
            print(f"[IPC Error] {e}", file=sys.stderr)
            return None

    async def command(self, cmd_string: str) -> Optional[str]:
        """
        Sends a single command. 
        Example: ctx.command('dispatch workspace 2')
        """
        return await self._send(f"/{cmd_string}")

    async def batch(self, commands: List[str]) -> Optional[str]:
        """
        Sends multiple commands in one atomic socket write.
        Example: ctx.batch(["keyword decoration:blur:enabled 0", "exec dunstctl set-paused true"])
        """
        # Hyprland syntax: dispatch batch/cmd1;cmd2;cmd3
        payload: str = ";".join(commands)
        return await self._send(f"/dispatch batch/{payload}")

    async def _listen(self) -> None:
        if not os.path.exists(self.event_sock_path):
            raise FileNotFoundError(f"Socket not found: {self.event_sock_path}")

        reader, _ = await asyncio.open_unix_connection(self.event_sock_path)
        
        while True:
            line: bytes = await reader.readline()
            if not line: 
                break
            
            raw: str = line.decode().strip()
            # Event format: EVENT>>DATA
            if ">>" in raw:
                parts: List[str] = raw.split(">>", 1)
                event: str = parts[0]
                data: str = parts[1]
                
                if event in self.handlers:
                    for func in self.handlers[event]:
                        # Fire concurrent tasks (similar to 'go func()')
                        asyncio.create_task(func(self, data))

    def run(self) -> None:
        """Starts the event loop (blocking)."""
        try:
            asyncio.run(self._listen())
        except KeyboardInterrupt:
            # Clean exit on Ctrl+C
            pass
