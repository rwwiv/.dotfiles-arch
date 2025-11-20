-- ~/.local/share/wireplumber/scripts/dnd-mode.lua

local roles_to_mute = { "Notification", "Alert", "Event" }

print("DND script loading...")

local function should_mute_role(role)
	for _, r in ipairs(roles_to_mute) do
		if r == role then
			return true
		end
	end
	return false
end

-- Track DND state
local dnd_enabled = false

-- Read initial metadata state on startup
local metadata_om = ObjectManager({
	Interest({
		type = "metadata",
		Constraint({ "metadata.name", "=", "default" }),
	}),
})

metadata_om:connect("object-added", function(om, metadata)
	local value = metadata:find(0, "dnd-mode")
	if value == "true" then
		dnd_enabled = true
	else
		dnd_enabled = false
	end
	print("Initial DND state: " .. tostring(dnd_enabled))
end)

metadata_om:activate()

-- Watch for metadata changes
SimpleEventHook({
	name = "dnd/metadata-changed",
	interests = {
		EventInterest({
			Constraint({ "event.type", "=", "metadata-changed" }),
			Constraint({ "metadata.name", "=", "default" }),
		}),
	},
	execute = function(event)
		local properties = event:get_properties()
		local key = properties["event.subject.key"]
		local value = properties["event.subject.value"]

		if key == "dnd-mode" then
			if value == "true" then
				dnd_enabled = true
			else
				dnd_enabled = false
			end
			print("DND mode changed: " .. tostring(dnd_enabled))
		end
	end,
}):register()

SimpleEventHook({
	name = "dnd/mute-notifications",
	interests = {
		EventInterest({
			Constraint({ "event.type", "=", "node-added" }),
			Constraint({ "media.class", "=", "Stream/Output/Audio" }),
		}),
	},
	execute = function(event)
		local node = event:get_subject()
		local props = node.properties
		local role = props["media.role"]
		local app_name = props["application.name"] or "unknown"

		if role and should_mute_role(role) then
			local pod = Pod.Object({
				"Spa:Pod:Object:Param:Props",
				"Props",
				mute = dnd_enabled,
			})
			node:set_param("Props", pod)
			print("Node: " .. app_name .. ", role: " .. role .. ", mute: " .. tostring(dnd_enabled))
		end
	end,
}):register()

print("DND script loaded")
