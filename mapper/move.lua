function mapper:move(dir)
	-- czy istnieje lokacja w tamta strone w exitach
	local roomID = self:getRoomViaExit(dir)
	if self.drawing then
		-- gdy istnieje wyjscie w gmcp z kolei nie ma takiego wyjscia w exitach
		if self:gmcpExitExists(dir) and not roomID then
			-- czy istnieje lokacja w tamta strone po koordynatach
			roomID = self:getRoomViaCoords(dir)
			if roomID then
				-- jesli istnieje - polacz lokacje
				print("connect")
				self:connectRooms(self.room.id, roomID, dir)
			else
				print('draw')
				-- jesli nie istnieje - wygeneruj nowa lokacje w evencie roomLoaded
				self.draw = {}
				self.draw.from = self.room.id
				self.draw.dir = dir
				self.draw.command = dir
				send(dir)
				return
			end
		end
	end
	-- jesli nie ma standardowego wyjscia
	if not roomID then
		local command = self:getCommandViaDir(dir)
		if command then
			dir = command
		end
	end
	send(dir)
end

function mapper:getCommandViaDir(dir)
	local spe = getSpecialExitsSwap(self.room.id)
    if spe then
        for command, roomID in pairs(spe) do
            local x, y, z = getRoomCoordinates(roomID)
			if self:coordsMatchDirection(dir, x, y, z) then
				return command
			end
        end
    end
	local exits = self.room.exits
	for command, roomID in pairs(exits) do
		if command == "down" or command == "up" then
			local x, y, z = getRoomCoordinates(roomID)
			if self:coordsMatchDirection(dir, x, y, z) then
				return self.dirEngToPl[command]
			end
		end
	end
end

function mapper:addSpecialExitAndRoom(dir, command)
	if self.drawing and self:matchRose(dir) then
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
		self.draw = {}
		self.draw.from = self.room.id
		self.draw.dir = dir
		self.draw.command = 'up'
		send('gora')
	end
end

function mapper:generateRoomDown(dir)
	if self.drawing and self:matchRose(dir) then
		self.draw = {}
		self.draw.from = self.room.id
		self.draw.dir = dir
		self.draw.command = 'down'
		send('dol')
	end
end

function mapper:matchRose(dir)
	if dir == "n" or dir == "s" or dir == "w" or dir == "e" or dir == "nw" or dir == "ne" or dir == "sw" or dir == "se" then
		return true
	end
end

function mapper:connectRooms(from, to, dir)
	setExit(from, to, dir)
end

function mapper:generateRoom(from, to, dir, command)
	local coords = self:convertCoords(dir)
	local roomID = self:addRoom(self.room.area, to, coords.x, coords.y, coords.z)
	if command then
		setExit(from, roomID, command)
	end
	return roomID
end

function mapper:gmcpExitExists(dir)
	for i = 1, #self.gmcp.exits do
		if self.gmcp.exits[i] == dir then
			return true
		end
	end
end

function mapper:getRoomViaExit(dir)
	if self.room.exits and self.room.exits[self.dirToApiExitNaming[dir]] then
		return self.room.exits[self.dirToApiExitNaming[dir]]
	end
end

function mapper:getRoomViaCoords(dir)
	local coords = self:convertCoords(dir)
	local rooms = getRoomsByPosition(self.room.area, coords.x, coords.y, coords.z)
	if rooms[0] then
		return rooms[0]
	end
end

--[[ Pobiera kierunek, zwracajac koordynaty dla danego stepu ]]--
function mapper:convertCoords(dir)
	--( 0,  0) start
	--( 0, +1) -> N
	--( 0, -1) -> S
	--(-1,  0) -> W
	--(+1,  0) -> E
	--(+1, +1) -> NE
	--(+1, -1) -> SE
	--(-1, +1) -> NW
	--(-1, -1) -> SW
	-- TODO Zrobic dol i gore
	local output = {
		["n"] = {
			x = self.room.coords.x,
			y = self.room.coords.y + self.step,
			z = 0
		},
		["s"] = {
			x = self.room.coords.x,
			y = self.room.coords.y - self.step,
			z = 0
		},
		["w"] = {
			x = self.room.coords.x - self.step,
			y = self.room.coords.y,
			z = 0
		},
		["e"] = {
			x = self.room.coords.x + self.step,
			y = self.room.coords.y,
			z = 0
		},
		["ne"] = {
			x = self.room.coords.x + self.step,
			y = self.room.coords.y + self.step,
			z = 0
		},
		["se"] = {
			x = self.room.coords.x + self.step,
			y = self.room.coords.y - self.step,
			z = 0
		},
		["nw"] = {
			x = self.room.coords.x - self.step,
			y = self.room.coords.y + self.step,
			z = 0
		},
		["sw"] = {
			x = self.room.coords.x - self.step,
			y = self.room.coords.y - self.step,
			z = 0
		},
	}
	return output[dir]
end

--[[ Sprawdz czy w tym kierunku, znajduja sie te koordynaty ]]--
function mapper:coordsMatchDirection(dir, x, y, z)
	if dir == "s" and
		x == self.room.coords.x and
		y < self.room.coords.y and
		z == self.room.coords.z then
		return true
	elseif dir == "n" and
		x == self.room.coords.x and
		y > self.room.coords.y and
		z == self.room.coords.z then
		return true
	elseif dir == "e" and
		x > self.room.coords.x and
		y == self.room.coords.y and
		z == self.room.coords.z then
		return true
	elseif dir == "w" and
		x < self.room.coords.x and
		y == self.room.coords.y and
		z == self.room.coords.z then
		return true
	elseif dir == "nw" and
		x < self.room.coords.x and
		y > self.room.coords.y and
		z == self.room.coords.z then
		return true
	elseif dir == "ne" and
		x > self.room.coords.x and
		y > self.room.coords.y and
		z == self.room.coords.z then
		return true
	elseif dir == "sw" and
		x < self.room.coords.x and
		y < self.room.coords.y and
		z == self.room.coords.z then
		return true
	elseif dir == "se" and
		x > self.room.coords.x and
		y < self.room.coords.y and
		z == self.room.coords.z then
		return true
	elseif dir == "d" and
		x == self.room.coords.x and
		y == self.room.coords.y and
		z < self.room.coords.z then
		return true
	elseif dir == "u" and
		x == self.room.coords.x and
		y == self.room.coords.y and
		z > self.room.coords.z then
		return true
	end
end
