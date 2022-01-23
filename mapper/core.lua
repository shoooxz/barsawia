mudlet = mudlet or {}
mudlet.mapper_script = true
mapper = mapper or {}
mapper.events = mapper.events or {}
mapper.gmcp = {}
mapper.step = 2
mapper.mode = 1
mapper.drawing = false
mapper.file = "barsawia_mapa.dat"
mapper.room = {}
mapper.gmcp = {}
mapper.draw = nil
mapper.nogmcp = 150000 -- start nogmcp id: las faktoria
mapper.lastKnownID = nil -- zmeczony, bramy, cofnij
mapper.gmcpNextLocation = nil -- zsiadz ze statku, wyjdz z dylizansu
mapper.short2en = { --> mapper:getRoomViaExit, mapper:connectRooms
	["n"]    = "north",
	["s"]    = "south",
	["w"]    = "west",
	["e"]    = "east",
	["ne"]   = "northeast",
	["nw"]   = "northwest",
	["se"]   = "southeast",
	["sw"]   = "southwest",
	["u"]    = "up",
	["d"]    = "down",
}
mapper.en2short = { --> mapper:helperGetExitsForComparison, mapper:getCommandViaDir
	["north"]     = "n",
	["south"]     = "s",
	["west"]      = "w",
	["east"]      = "e",
	["northeast"] = "ne",
	["northwest"] = "nw",
	["southeast"] = "se",
	["southwest"] = "sw",
	["up"]        = "u",
	["down"]      = "d",
}
mapper.pl2short = { --> mapper:convertExits
	["polnoc"]            = "n",
	["poludnie"]          = "s",
	["wschod"]            = "e",
	["zachod"]            = "w",
	["polnocny-zachod"]   = "nw",
	["polnocny-wschod"]   = "ne",
	["poludniowy-zachod"] = "sw",
	["poludniowy-wschod"] = "se",
	["gora"]              = "u",
	["dol"]               = "d",
}
mapper.shortMirror = { --> events.lua
	["n"]    = "s",
	["s"]    = "n",
	["w"]    = "e",
	["e"]    = "w",
	["ne"]   = "sw",
	["nw"]   = "se",
	["se"]   = "nw",
	["sw"]   = "ne",
	["u"]    = "d",
	["d"]    = "u",
}
mapper.walker = {
	["step"] = 1,
	["going"] = false,
	["delay"] = 1,
	["path"] = {},
}
mapper.moriaExitLocation = 29810
mapper.moriaEnterLocation = 29695
mapper.moriaMode = 0

function mapper:init()
	self:unbindEvents()
	self:ui(settings:get("mapperWidth"))
	self:centerGMCP()
end

function mapper:setGMCP()
	if gmcp.Room then
		self.gmcp.id = gmcp.Room.Info.id
		self.gmcp.exits = self:convertExits(gmcp.Room.Info.exits)
		self.gmcp.short = gmcp.Room.Info.short
		return true
	end
end

function mapper:center(id)
	if roomExists(id) then
		local x, y, z = getRoomCoordinates(id)
		self.room.id = id
		self.room.area = getRoomArea(id)
		self.room.coords = {x = x, y = y, z = z}
		self.room.exits = getRoomExits(self.room.id)
		centerview(id)
	end
end

function mapper:centerGMCP(msg)
	if self:setGMCP() then
		self.lastKnownID = self.gmcp.id
		self:center(self.gmcp.id)
		if msg then
			printer:success("Aktualizacja lokacji",
				"Lokacja ustawiona z GMCP (ID: "..self.gmcp.id..")"
			)
		end
	end
end

function mapper:matchRose(dir)
	if dir == "n" or dir == "s" or dir == "w" or dir == "e" or dir == "nw" or dir == "ne" or dir == "sw" or dir == "se" then
		return true
	end
end

function mapper:matchZ(dir)
	if dir == "u" or dir == "d" then
		return true
	end
end

function mapper:setStep(step)
	step = tonumber(step)
	if step then
		self.step = step
		printer:success("Mapper",
			"Step ustawiony na "..self.step
		)
		self:centerGMCP()
	end
end

function mapper:setMode(mode)
	if not mode then
		printer:success("Mapper",
			"Aktualny tryb: "..self.mode
		)
	end
	if mode == "1" then
		self.mode = 1
		printer:success("Mapper",
			"Mapper ustawiony na jednostronne polaczenia"
		)
		self:centerGMCP()
	end
	if mode == "2" then
		self.mode = 2
		printer:success("Mapper",
			"Mapper ustawiony na obustronne polaczenia (Trakty)"
		)
		self:centerGMCP()
	end
	if mode == "3" then
		self.mode = 3
		printer:success("Mapper",
			"Mapper ustawiony na lokacje bez GMCP"
		)
	end
	if mode == "4" then
		self.mode = 4
		printer:success("Mapper",
			"Mapper ustawiony na laczenie lokacji przez GMCP (Laki)"
		)
	end
end

function mapper:getRoomInfo()
	-- TODO rozwinac ta funkcje, zastanowic sie nad exits
	local info = {
		{
			'ID gmcp',
			self.gmcp.id
		},
		{
			"Opis gmcp",
			self.gmcp.short
		},
		{
			"Wyjscia gmcp",
			self.gmcp.exits
		}
	}
	if next(self.room) then
		local areaID, areaName = self:getArea(self.room.area)
		table.insert(info, {
			'Obszar',
			areaName.." ("..areaID..")"
		})
		table.insert(info, {
			'Koordynaty',
			"("..self.room.coords.x..", "..self.room.coords.y..", "..self.room.coords.z..")"
		})
	else
		printer:error("Aktualna lokacja", "Nie mozna odnalezc lokacji na mapie!")
	end
	printer:roomInfo(info)
end

function mapper:convertExits(arr)
	--[[
		"polnoc",
		"poludnie",
		"gora",
		"kuznia"
	]]--
	local output = {}
	for i = 1, #arr do
		if self.pl2short[arr[i]] then
			output[i] = self.pl2short[arr[i]]
		else
			output[i] = arr[i]
		end
	end
	return output
end

function mapper:start()
	if self.drawing == false then
		self.walker.going = false
		self.drawing = true
		printer:success("Mapowanie", "Maper wlaczony, pomocnik wlaczony")
	end
end

function mapper:stop()
	if self.drawing then
		self.drawing = false
		printer:error("Mapowanie", "Maper wylaczony, pomocnik wylaczony")
	end
end

function mapper:save()
	local file = getMudletHomeDir().."/"..self.file
	local savedok = saveMap(file)
	if not savedok then
		printer:error("Zapisanie mapy", "Wystapil blad, nie udalo sie zapisac mapy")
	else
		self:reload()
		printer:success("Zapisanie mapy",
			{
				"Mapa zapisana poprawnie!",
				file
			}
		)
	end
end

function mapper:reload()
	self:load()
	mapper:center(self.room.id)
end

function mapper:load()
	local res = loadMap(getMudletHomeDir().."/"..self.file)
	if res then
		printer:success("Ladowanie mapy",
			{
				"Mapa zaladowana poprawnie!",
				file
			}
		)
	else
		printer:error("Ladowanie mapy",
			{
				"Blad przy ladowaniu mapy!",
				"Sprawdz uprawnienia pliku"
			}
		)
	end
end

function mapper:ui(mapperWidth)
	setBorderRight(mapperWidth)
	self.mapperContainer = nil
	self.mapperContainer = Geyser.Container:new({
		x = -mapperWidth,
		y = 0,
		width = mapperWidth,
		height = "100%",
		name = "mapperContainer"
	})
	self.window = nil
	self.window = Geyser.Mapper:new({
		name = "mapper",
		x = 0,
		y = 0,
		width = "100%",
		height = -footer.height
	}, self.mapperContainer)
end

function mapper:unbindEvents()
	for name, id in pairs(self.events) do
		if id then
			killAnonymousEventHandler(id)
		end
	end
end

function mapper:colorExits(pre, exits)
	selectCaptureGroup(1)
  creplace("<white>"..pre.." <orange>"..exits.."<reset>.")
end

function mapper:moria(line1, line2)
	--`echo Posrod oblewajacego cie ze wszystkich stron mrocznego calunu ciemnosci dostrzegasz: wschod i zachod.
	if self.moriaMode == 1 then
		-- if moria
		local stringExits = {}
		local gmcpExits = {}
		local exits = string.match(line2, "Posrod oblewajacego cie ze wszystkich stron mrocznego calunu ciemnosci dostrzegasz.*: (.*).")
		if exits then
			stringExits = utils:splitcommai(exits)
		end

		--utils:dump(stringExits)

		-- jesli gmcp jest na lokacji, dodaj brakujace wyjscia, ktorych nie ma w stringExits
		local isGmcp = ""
		if gmcp.Room then
			if tonumber(gmcp.Room.Info.id) > 0 then
				isGmcp = "<grey>[gmcp]<reset>"
			end
			gmcpExits = gmcp.Room.Info.exits
			local diff = utils:arrayDiff(gmcpExits, stringExits)
			for _, exit in pairs(diff) do
				table.insert(stringExits, exit)
			end
		end

		-- listuj polaczone wyjscia ze stringu + gmcp
		local temp = ""
		for _, exit in pairs(stringExits) do
			temp = temp..exit..", "
		end
		if temp == "" then
			cecho("\n<white>Wyjscia: <red>Brak<white>."..isGmcp.." \n")
		else
			temp = utils:rtrim(temp, ", ")
			cecho("\n<white>Wyjscia: <orange>"..temp.."<white>."..isGmcp.."\n")
		end

	end -- end if moria
end

mapper:init()
