function mapperBind()
	local arr = mapper:getBind()
	if arr then
		for i, command in pairs(arr) do
			send(command)
		end
	end
end

function triggerBind()
	if keybind.triggerCommand then
		send(keybind.triggerCommand)
		keybind.triggerCommand = nil
	end
end

function fightSupport()
	send("wesprzyj")
end

function openGate()
	send(mapper.gateCommand)
	mapper.gateCommand = nil
end
