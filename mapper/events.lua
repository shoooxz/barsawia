function roomLoadedCallback()
	if mapper.drawing then
		if mapper.draw then
			--createRoomID(200000)
			if mapper.draw.special then
				roomID = mapper:generateRoom(mapper.draw.from, gmcp.Room.Info.id, mapper.draw.dir, nil)
				-- dodaj wyjscie specjalne
				mapper:addSpecialExit(mapper.draw.from, roomID, mapper.draw.command)
			else
				roomID = mapper:generateRoom(mapper.draw.from, gmcp.Room.Info.id, mapper.draw.dir, mapper.draw.command)
				if mapper.draw.command == "up" or mapper.draw.command == "down" then
					local reverse = {
						["up"] = "down",
						["down"] = "up",
					}
					-- dodaj linie
					mapper:addCustomLine(mapper.draw.from, roomID, mapper.draw.command)
					-- polacz w druga strone
					mapper:connectRooms(roomID, mapper.draw.from, reverse[mapper.draw.command])
				end
			end
			mapper.draw = nil
		end
	end
	mapper:centerGMCP(false)
	mapper:helper()
end

if mapper.events then
	if mapper.events["roomLoaded"] then
    	killAnonymousEventHandler(mapper.events["roomLoaded"])
	end
	mapper.events["roomLoaded"] = registerAnonymousEventHandler("gmcp.Room", roomLoadedCallback)
end
