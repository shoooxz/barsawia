function mapperBind()
	local arr = mapper:getBind()
	for i, command in pairs(arr) do
		send(command)
	end
end

function fightSupport()
	send("wesprzyj")
end
