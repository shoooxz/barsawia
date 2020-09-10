function mapper:setBoxBind()
	if self.room.id then
		setRoomUserData(self.room.id, "box", 1)
		printer:success("Mapper Bindy",
			"Bind `przeczytaj plakat` dodany do lokacji!"
		)
	end
end

function mapper:setDepositBind()
	if self.room.id then
		setRoomUserData(self.room.id, "deposit", 1)
		printer:success("Mapper Bindy",
			"Bind `popros o wydanie schowka` dodany do lokacji!"
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
		if next(data) then
			--display(mudlet.key)
			local room = ""
			if data.bind then
				room = room..data.bind..";"
			end
			if data.box then
				room = room.."przeczytaj plakat"..";"
			end
			if room ~= "" then
				keybind:room(room)
			end
			if data.deposit then
				keybind:deposit()
			end
		end
	end
end
