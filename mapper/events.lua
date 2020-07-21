function roomLoadedCallback()
	local gmcpID = gmcp.Room.Info.id
	if gmcpID ~= 0 then
		if mapper.drawing then
			if mapper.draw then
				--createRoomID(200000)
				if mapper.draw.special then
					roomID = mapper:generateRoom(mapper.draw.from, gmcpID, mapper.draw.dir, nil)
					-- dodaj wyjscie specjalne
					mapper:addSpecialExit(mapper.draw.from, roomID, mapper.draw.command)
					mapper:addCustomLine(mapper.draw.from, roomID, mapper.draw.command)
				else
					if mapper.draw.from ~= gmcpID then
						roomID = mapper:generateRoom(mapper.draw.from, gmcpID, mapper.draw.dir, mapper.draw.command)
						if roomID then
							if mapper.draw.command == "up" or mapper.draw.command == "down" then
								local reverse = {
									["up"] = "down",
									["down"] = "up",
								}
								-- dodaj linie
								mapper:addCustomLine(mapper.draw.from, roomID, mapper.draw.command)
								-- polacz w druga strone - w przypadku up/down zawsze wystepuje polaczenie obustronne
								mapper:connectRooms(roomID, mapper.draw.from, reverse[mapper.draw.command])
							elseif mapper.mode == 2 then
								-- ustaw polaczenie obustronne dla traktow
								mapper:connectRooms(roomID, mapper.draw.from, mapper.shortMirror[mapper.draw.dir])
							end
						end
					end
				end
				mapper.draw = nil
			end
			mapper:centerGMCP()
		end
		mapper.lastKnownID = gmcpID
		local binded = mapper:roomBinded()
		if binded then
			keybind:room(binded)
		end
		if mapper.gmcpNextLocation then
			mapper:centerGMCP()
			mapper.gmcpNextLocation = nil
		end
		mapper:helper()
	end
end

function newLocationCallback(event, arg)
	-- new loc
end

if mapper.events then
	mapper:unbindEvents()
	-- events GMCP
	mapper.events["roomLoaded"] = registerAnonymousEventHandler("gmcp.Room", roomLoadedCallback)
	-- custom events
	mapper.events["newLocation"] = registerAnonymousEventHandler("newLocation", newLocationCallback)
end
