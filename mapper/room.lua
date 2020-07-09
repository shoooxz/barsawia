function mapper:addRoom(areaID, roomID, x, y, z)
	addRoom(roomID)
	setRoomCoordinates(roomID, x, y, z)
	setRoomArea(roomID, areaID)
	return roomID
end

function mapper:getRoomInfo()
	-- TODO rozwinac ta funkcje, zastanowic sie nad exits
	local info = {}
	info.id = self.gmcp.id
	info.short = self.gmcp.short
	info.exits = self.gmcp.exits
	if next(self.room) then
		local areaID, areaName = self:getArea(self.room.area)
		info.area = areaName.."("..areaID..")"
		info.coords = "("..self.room.coords.x..", "..self.room.coords.y..", "..self.room.coords.z..")"
	else
		printer:error("Aktualna lokacja", "Nie mozna odnalezc lokacji na mapie!")
	end
	printer:roomInfo(info)
end

function mapper:colorRoom(color)
	if self.drawing then
		local arr = {
			["poi"] = 266,
			["chata"] = 259,
			["las"] = 258,
			["gory"] = 263,
			["droga"] = 257,
			["woda"] = 268,
			["agro"] = 261,
			["plaza"] = 267,
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
