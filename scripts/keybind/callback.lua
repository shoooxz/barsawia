function keybindRoom()
	if keybind.roomCommand then
		local arr = utils:split(keybind.roomCommand, '#')
		if arr then
			for i, command in pairs(arr) do
				send(command)
			end
		end
	end
end

function keybindTrigger()
	if keybind.triggerCommand then
		send(keybind.triggerCommand)
		keybind.triggerCommand = nil
	end
end

function keybindSupport()
	send("wesprzyj")
end

function keybindGate()
	if keybind.gateCommand then
		send(keybind.gateCommand)
		keybind.gateCommand = nil
	end
end
