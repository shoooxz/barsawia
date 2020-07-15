profile = profile or {}
profile.file = getMudletHomeDir().."/%s.lua"
profile.list = profile.list or {}
profile.func = {
	["pojemnik"] = function(val)
		val = tonumber(val)
		if inventory:bagExists(val) then
			profile.list.bag = val
			profile:save()
		else
			printer:one("Opcje", "ID pojemnika nie istnieje")
		end
	end,
	["filtr_bron"] = function(val)
		if val == "0" then
			profile.list.filter_weapon = 0
			profile:save()
			return
		end
		local arr = utils:split2(val, ",")
		for i=1, #arr do
			if not inventory.filter:weaponExists(arr[i]) then
				printer:one("Opcje", "ID "..arr[i].." filtru broni nie istnieje")
				return
			end
		end
		profile.list.filter_weapon = arr
		profile:save()
	end,
}

function profile:init(name)
	local msg = name..", profil zostal zaladowany, mozesz go modyfikowac w /opcje"
	self.file = string.format(self.file, name)
	self.last = name
	if io.exists(self.file) then
		table.load(self.file, self.list)
	else
		local default = {
			["bag"] = 1,
			["filter_weapon"] = 0,
		}
		self:save(default)
		self.list = default
		msg = name..", utworzono twoj nowy profil, mozesz go modyfikowac w /opcje"
	end
	tempTimer(.3, function ()
		printer:one("Profil", msg)
	end)
end

function profile:get(name)
	if self.list[name] then
		return self.list[name]
	end
end

function profile:change(match)
	if match then
		local func, arg = match[2], match[3]
		if func and arg then
			if self.func[func] then
				self.func[func](arg)
			end
		end
	end
end

function profile:save(arr)
	if arr then
		table.save(self.file, arr)
	else
		table.save(self.file, self.list)
	end
end

function profile:loadLast()
	self:init(self.last)
end
