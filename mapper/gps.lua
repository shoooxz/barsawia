function mapper:isME()
	if self.room.area then
		local me = {
			8,
			2,
			10,
			3,
			5,
			6,
			9,
			4,
			7,
			15,
			16,
		}
		return utils:inArray(self.room.area, me)
	end
	return false
end

function mapper:isED()
	if self.room.area then
		local ed = {
			11,
			12,
			14,
		}
		return utils:inArray(self.room.area, ed)
	end
	return false
end

mapper.gps = db:create("gps", {
    gps = {
        name = "",
        room = 0,
		domain = 0,
        _index = { "name" },
		_violations = "IGNORE",
    }
})

function mapper:gpsInit(str)
	if str then
		local res = db:fetch(self.gps.gps, {db:like(self.gps.gps.name, str.."%")})
	    self:gpsGo(res[1].room, res[1].name)
	else
		self:gpsList()
	end
end

function mapper:gpsList()
	if self:isME() then
		self:gpsRender(1)
	elseif self:isED() then
		self:gpsRender(2)
	else
		printer:error("GPS", {"Obszar, w ktorym sie znajdujesz "..self.room.area.." nie zostal dodany do GPS", "barsawia/mapper/gps.lua"})
	end
end

function mapper:gpsRender(domain)
	local res = db:fetch(self.gps.gps, db:eq(self.gps.gps.domain, domain), {self.gps.gps.name})
	local out = {}
	for i=1, #res do
		table.insert(out,
			{
				["label"] = res[i].name,
				["command"] = "mapper:gpsGo("..res[i].room..", \""..res[i].name.."\")",
				["tooltip"] = "Kieruj sie do "..res[i].name,
			}
		)
	end
	printer:gps(out)
end

function mapper:gpsGo(roomID, name)
	printer:success("GPS", "Podazam w strone "..name)
	gotoRoom(roomID)
end

function mapper:gpsAdd(name)
	if self.room.id and name ~= " " then
		if self:isME() then
			db:add(self.gps.gps, {name = name, room = self.room.id, domain = 1})
			printer:success("GPS", "Dodano punkt "..name.." do GPS w ME")
		elseif self:isED() then
			db:add(self.gps.gps, {name = name, room = self.room.id, domain = 2})
			printer:success("GPS", "Dodano punkt "..name.." do GPS w ED")
		else
			printer:error("GPS", {"Obszar, w ktorym sie znajdujesz "..self.room.area.." nie zostal dodany do GPS", "barsawia/mapper/gps.lua"})
		end
	else
		printer:error("GPS", "Nie moge odnalezc ID lokacji lub nazwy punktu GPS")
	end
end
