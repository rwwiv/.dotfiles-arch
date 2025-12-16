local hostname = vim.uv.os_gethostname()
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.opt.foldcolumn = "0" -- Disable fold column clicks
vim.opt.updatetime = 250 -- Increase update time
vim.opt.swapfile = true
vim.opt.directory = "/tmp//"
vim.opt.mousescroll = { "ver:1", "hor:1" }
vim.opt.scrolloff = 10

vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.o.shell = "/bin/zsh"

if vim.g.vscode then
	-- 1. Enable the command line area
	vim.opt.cmdheight = 1

	-- 2. Force the standard "-- INSERT --" message to appear
	-- LazyVim disables this by default, which is why you see nothing!
	vim.opt.showmode = true

	-- 3. Kill the TUI statusline completely
	-- LazyVim sets this to 3 (global), which confuses the grid
	vim.opt.laststatus = 0

	-- 4. Disable the ruler (line/col info) to reduce noise
	vim.opt.ruler = false
end

if hostname == "devbox" then
	-- 1. Sync yank to system clipboard registers
	vim.opt.clipboard = "unnamedplus"

	-- 2. define a custom clipboard provider using the built-in osc 52 logic
	if vim.env.ssh_tty then
		vim.g.clipboard = {
			name = "osc 52",
			copy = {
				["+"] = require("vim.ui.clipboard.osc52").copy("+"),
				["*"] = require("vim.ui.clipboard.osc52").copy("*"),
			},
			paste = {
				-- note: reading from local clipboard via osc 52 is usually blocked
				-- by terminals for security. we fallback to internal registers here.
				-- just use cmd+v / ctrl+shift+v to paste from local to remote.
				["+"] = function()
					return { vim.fn.getreg("+"), vim.fn.getregtype("+") }
				end,
				["*"] = function()
					return { vim.fn.getreg("*"), vim.fn.getregtype("*") }
				end,
			},
		}
	end
end
