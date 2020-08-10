function mapper:roomLoaded()
	return function()
		local gmcpID = gmcp.Room.Info.id
		-- connect na wejsciu na lokacje dla wszystkich modow
		if self.drawing and self.draw and self.draw.connect then
			local to = nil
			if self.mode == 4 then
				to = gmcpID
			else
				to = self.draw.to
			end
			self:connectRooms(self.draw.from, to, self.draw.dir)
			-- obustronnie
			if self.mode == 2 then
				self:connectRooms(to, self.draw.from, self.shortMirror[self.draw.dir])
			end
			-- centruj bez gmcp
			if self.mode == 3 then
				self:center(self.draw.to)
			end
		end
		-- wejdz na lokacje i uzyj gmcp
		if gmcpID ~= 0 then
			if self.drawing then
				if self.draw then
					if self.draw.special then
						roomID = self:generateRoom(self.draw.from, gmcpID, self.draw.dir, nil)
						-- dodaj wyjscie specjalne
						self:addSpecialExit(self.draw.from, roomID, self.draw.command)
						self:addCustomLine(self.draw.from, roomID, self.draw.command)
					elseif self.draw.new then
						if self.draw.from ~= gmcpID then
							roomID = self:generateRoom(self.draw.from, gmcpID, self.draw.dir, self.draw.command)
							if roomID then
								if self.draw.command == "up" or self.draw.command == "down" then
									local reverse = {
										["up"] = "down",
										["down"] = "up",
									}
									-- dodaj linie
									self:addCustomLine(self.draw.from, roomID, self.draw.command)
									-- polacz w druga strone - w przypadku up/down zawsze wystepuje polaczenie obustronne
									self:connectRooms(roomID, self.draw.from, reverse[self.draw.command])
								elseif self.mode == 2 then
									-- ustaw polaczenie obustronne dla traktow
									self:connectRooms(roomID, self.draw.from, self.shortMirror[self.draw.dir])
								end
							end
						end
					end
					self.draw = nil
				end
				self:centerGMCP()
			end
			self.lastKnownID = gmcpID
			local binded = self:roomBinded()
			if binded then
				keybind:room(binded)
			end
			if self.gmcpNextLocation then
				self:centerGMCP()
				self.gmcpNextLocation = nil
			end
			self:helper()
		else
			self.lastKnownID = self.room.id
			-- wygeneruj room bez gmcp
			if self.drawing and self.draw and self.draw.new and self.mode == 3 then
				local to = createRoomID(self.nogmcp)
				self:generateRoom(self.draw.from, to, self.draw.dir, self.draw.dir)
				setRoomEnv(to, 262) -- TODO SKOMENTOWAC TO
				self:center(to)
			end
		end
	end
end

mapper.events["roomLoaded"] = registerAnonymousEventHandler("gmcp.Room", mapper:roomLoaded())
