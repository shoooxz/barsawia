settings = settings or {}
settings.file = getMudletHomeDir().."/settings.lua"
settings.list = settings.list or {}
settings.func = {
	["szerokosc"] = function(val)
		setMainWindowSize(val, settings:get("mainWindowHeight"))
		settings.list.mainWindowWidth = tonumber(val)
		settings:save()
	end,
	["wysokosc"] = function(val)
		setMainWindowSize(settings:get("mainWindowWidth"), val)
		settings.list.mainWindowHeight = tonumber(val)
		settings:save()
	end,
	["mapper_szerokosc"] = function(val)
		mapper:ui(val)
		settings.list.mapperWidth = tonumber(val)
		settings:save()
	end,
}

function settings:init()
	if io.exists(self.file) then
	 	table.load(self.file, self.list)
	else
		local default = {
			["mainWindowWidth"] = 1920,
			["mainWindowHeight"] = 980,
			["mapperWidth"] = 700
		}
		self:save(default)
		self.list = default
	end
end

function settings:get(name)
	if self.list[name] then
		return self.list[name]
	end
end

function settings:change(match)
	if match then
		local func, arg = match[2], match[3]
		if func and arg then
			if self.func[func] then
				self.func[func](arg)
			end
		end
	end
end

function settings:save(arr)
	if arr then
		table.save(self.file, arr)
	else
		table.save(self.file, self.list)
	end
end
