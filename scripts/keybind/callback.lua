function mapperBind()
	local arr = mapper:getBind()
	if arr then
		for i, command in pairs(arr) do
			send(command)
		end
	end
end

function triggerBind()
	send(keybind.triggerCommand)
	keybind.triggerCommand = nil
end

function fightSupport()
	send("wesprzyj")
end

function openGate()
	send(mapper.gateCommand)
	mapper.gateCommand = nil
end
