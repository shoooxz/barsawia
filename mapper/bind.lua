function mapper:setBoxBind()
	if self.room.id then
		setRoomUserData(self.room.id, "box", 1)
		printer:success("Mapper Bindy",
			"Bind `przeczytaj plakat` dodany do lokacji!"
		)
	end
end

function mapper:setBind(str)
	if self.room.id and str then
		setRoomUserData(self.room.id, "bind", str)
		printer:success("Mapper Bindy",
			"Bind `"..str.."` dodany do lokacji!"
		)
	else
		printer:error("Mapper Bindy",
			"Nie moge odnalezc ID lokacji, sprobuj /zlok"
		)
	end
end

function mapper:getBind()
	if self.room.id then
		local data = getRoomUserData(self.room.id, "bind")
		if data ~= "" then
			local arr = utils:split(data, '#')
			return arr
		end
	end
end

function mapper:removeBinds()
	if self.room.id then
		clearRoomUserData(self.room.id)
		printer:success("Mapper Bindy",
			"Bindy usuniete z lokacji!"
		)
	end
end

function mapper:roomBinded()
	if self.room.id then
		local data = getAllRoomUserData(self.room.id)
		local out = ""
		if next(data) then
			for key, val in pairs(data) do
				if key == "box" then val = "przeczytaj plakat" end
				out = out .. val .. ";"
			end
			if out then
				return out
			end
		end
		return false
	end
end
