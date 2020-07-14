function mapper:addRoom(areaID, roomID, x, y, z)
	addRoom(roomID)
	setRoomCoordinates(roomID, x, y, z)
	setRoomArea(roomID, areaID)
	return roomID
end

function mapper:connectRooms(from, to, dir)
	if self.short2en[dir] then
		dir = self.short2en[dir]
	end
	setExit(from, to, dir)
end

function mapper:addLine(dir)
	if self.drawing and self:matchRose(dir) then
		local command, roomID = self:getCommandViaDir(dir)
		if command then
			self:addCustomLine(self.room.id, roomID, command)
		end
	end
end

function mapper:addCustomLine(from, to, command)
	addCustomLine(from, to, command, "dot line", {220, 220, 220}, false)
end

function mapper:generateRoom(from, to, dir, command)
	local coords = self:convertCoords(dir)
	local roomID = self:addRoom(self.room.area, to, coords.x, coords.y, coords.z)
	if roomID and command then
		self:connectRooms(from, roomID, command)
	end
	return roomID
end

function mapper:addSpecialExitAndRoom(dir, command)
	display(command)
	if self.drawing and (self:matchRose(dir) or self:matchZ(dir)) then
		roomID = self:getRoomViaCoords(dir)
		if roomID then
			self:addSpecialExit(self.room.id, roomID, command)
			printer:success("Specjalne przejscie",
				"Polaczono lokacje specjalnym przejsciem '"..command.."' na "..dir.." !"
			)
		else
			self.draw = {}
			self.draw.from = self.room.id
			self.draw.dir = dir
			self.draw.command = command
			self.draw.special = true
			send(command)
		end
	end
end

function mapper:addSpecialExit(from, to, command)
	addSpecialExit(from, to, command)
end

function mapper:generateRoomUp(dir)
	if self.drawing and self:matchRose(dir) then
		local roomID = self:getRoomViaCoords(dir)
		if roomID then
			self:connectRooms(self.room.id, roomID, "up")
		else
			self.draw = {}
			self.draw.from = self.room.id
			self.draw.dir = dir
			self.draw.command = "up"
		end
		send("u")
	end
end

function mapper:generateRoomDown(dir)
	if self.drawing and self:matchRose(dir) then
		local roomID = self:getRoomViaCoords(dir)
		if roomID then
			self:connectRooms(self.room.id, roomID, "down")
		else
			self.draw = {}
			self.draw.from = self.room.id
			self.draw.dir = dir
			self.draw.command = "down"
		end
		send("d")
	end
end

function mapper:emptyRoom(dir, roomID)
	if self.drawing and self:matchRose(dir) then
		local coords = self:convertCoords(dir)
		self:addRoom(self.room.area, roomID, coords.x, coords.y, coords.z)
	end
end

function mapper:label(dir, text)
	if self.drawing and self:matchRose(dir) then
		local fr, fg, fb = 255, 255, 255
		local br, bg, bb = 0, 0, 0
		local coords = self:convertCoords(dir)
		createMapLabel(
			self.room.area,
			text,
			coords.x, coords.y, coords.z,
			fr, fg, fb,
			br, bg, bb,
			0,
			20,
			true,
			true
		)
	end
end

function mapper:colorRoom(color)
	if self.drawing then
		local arr = {
			["poi"] = 267,
			["chata"] = 259,
			["las"] = 258,
			["gory"] = 263,
			["droga"] = 257,
			["woda"] = 268,
			["agro"] = 261,
			["?"] = 270
		}
		if arr[color] then
			setRoomEnv(self.room.id, arr[color])
		end
	end
	--rounded rooms
	--local r,g,b = unpack(color_table[color])
	--highlightRoom(self.currentRoomID, r,g,b, r, g, b, 0, 255, 255)
end
