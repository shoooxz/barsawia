





--mapper.areaID = 5
--mapper.coords = { x=0, y=0, z=0 }

mapper.exitReverse = {
	["n"] = "s",
	["s"] = "n",
	["w"] = "e",
	["e"] = "w",

	["ne"] = "sw",
	["sw"] = "ne",
	["nw"] = "se",
	["se"] = "nw",
}
mapper.specialReverse = {
	["up"] = "down",
	["down"] = "up",

	["brama"] = "brama",

	["n"] = "s",
	["s"] = "n",
	["w"] = "e",
	["e"] = "w",

	["ne"] = "sw",
	["sw"] = "ne",
	["nw"] = "se",
	["se"] = "nw",
}


function mapper:setDoor(dir, status)
	setDoor(self.currentRoomID, dir, status)
end

function mapper:roomInfo()
	local roomID = getPlayerRoom()
	display(self.areaID)
	display(roomID)
	display(getRoomExits(roomID))
	--display(getSpecialExits(roomID))
	display(getAllRoomUserData(roomID))
	--display(getDoors(roomID))

end

function mapper:clearCurrentRoomData()
	clearRoomUserData(self.currentRoomID)
end
function mapper:setAreaID(v)
	self.areaID = v
end

function mapper:setOnTheFlyExit(from, to, dir, command, removeExit)
	local remove = removeExit or false
	if remove then
		setExit(from, -1, removeExit)
	end
	clearRoomUserData(from)
	setExit(from, to, dir)
	setRoomUserData(
		from,
		dir,
		yajl.to_string({command = command, id = to})
	)
end
function mapper:block(dir)
  setRoomUserData(
  	self.currentRoomID,
  	dir,
  	"block"
  )
end
function mapper:connectSpecialRoomOne(roomID, dir, command, locked)
  setExit(self.currentRoomID, roomID, dir)
  	setRoomUserData(
  		self.currentRoomID,
  		dir,
  		yajl.to_string({command = command, id = roomID, locked = locked})
  	)
end
function mapper:connectSpecialRoom(roomID, dir, command, locked)
  setExit(self.currentRoomID, roomID, dir)
  	setRoomUserData(
  		self.currentRoomID,
  		dir,
  		yajl.to_string({command = command, id = roomID, locked = locked})
  	)
	if self.specialReverse[command] then
		setExit(roomID, self.currentRoomID, self.exitReverse[dir])
		setRoomUserData(
			roomID,
			self.exitReverse[dir],
			yajl.to_string({command = self.specialReverse[command], id = self.currentRoomID, locked = locked})
		)
	else
		-- ustaw default reverse commendy na 'wyjscie'
		setExit(roomID, self.currentRoomID, self.exitReverse[dir])
		setRoomUserData(
			roomID,
			self.exitReverse[dir],
			yajl.to_string({command = "wyjscie", id = self.currentRoomID, locked = locked})
		)
	end
	--addCustomLine(self.currentRoomID, roomID, string.upper(dir), "dot line", {220, 220, 220}, false)
end
function mapper:generateSpecialRoom(dir, step, locked, command)
	local coords = self:convertCoords(dir, step)
	local roomID = self:newRoom(self.areaID, coords.x, coords.y, coords.z)
	self:connectSpecialRoom(roomID, dir, command, locked)
end
function mapper:generateRoom(dir, step)
	local coords = self:convertCoords(dir, step)
	local roomID = self:newRoom(self.areaID, coords.x, coords.y, coords.z)
	setExit(self.currentRoomID, roomID, dir)
	setExit(roomID, self.currentRoomID, self.exitReverse[dir])
	--addCustomLine(self.currentRoomID, roomID, string.upper(dir), "solid line", {220, 220, 220}, false)
	return roomID
end


function mapper:covertDirToSpecial(dir)
	local data = getRoomUserData(self.currentRoomID, dir)
	if data == "" then
		return false
	end
	return yajl.to_value(data)
end
function mapper:move_stare_wyjebac(dir)
	-- TODO naprawic tutaj 100 razy te same funkcje heh
	if self.drawing then
		local roomID = self:getRoomViaDirectory(dir, self.step)
		if roomID == nil then
			roomID = self:generateRoom(dir, self.step)
			cecho("<green:>\nGenerated room!\n\n")
		elseif self:getRoomViaExit(dir) == nil then
			self:connectRooms(roomID, dir)
			cecho("<yellow:>\nRooms connected!\n\n")
		end
	end
	local data = getRoomUserData(self.currentRoomID, dir)
	local roomID
	if data == "" then
		roomID = self:getRoomViaExit(dir)
	else
		if data == "block" then
			cecho("<red:>\nNIEBEZPIECZENSTWO!\n\n")
			return
		end
		data = yajl.to_value(data)
		roomID = data.id
		dir = data.command
		locked = data.locked
		if locked == "1" then
			send("open "..dir)
		end
	end
	if roomID then
		local x,y,z = getRoomCoordinates(roomID)
		self.coords = { x=x, y=y, z=z }
		self:center(roomID)
	end
	send(dir)
end
