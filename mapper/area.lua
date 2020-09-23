function mapper:getAreaTable()
	local out = {}
	for name, id in pairs(getAreaTable()) do
		if id > 0 then
			table.insert(out, {
				id,
				name
			})
		end
	end
	printer:areas(out)
end

function mapper:deleteArea(idname)
	local res = deleteArea(idname)
	if res then
		printer:success("Usuniecie obszaru",
			"Usunieto obszar "..idname
		)
	else
		printer:error("Usuniecie obszaru",
			{
				"Wystapil blad, nie usunieto obszaru",
				"Prawdopodobnie obszar o tej nazwie/id nie istnieje"
			}
		)
	end
end

function mapper:setAreaName(id, name)
	setAreaName(tonumber(id), name)
	printer:success("Obszary",
		{
			"Zmieniono nazwe dla obszaru "..id,
			name,
		}
	)
end

function mapper:addAreaName(v)
	local areaID, err = addAreaName(v)
	if areaID == nil or areaID < 1 or err then
		printer:error("Dodanie obszaru",
			{
				"Wystapil blad, nie dodano obszaru",
				"Prawdopodobnie obszar o takiej nazwie istnieje lub podana zla nazwe",
				"Sprawdz obszary za pomoca komendy /obszary"
			}
		)
	else
		printer:success("Dodanie obszaru",
			{
				"Dodano obszar o nazwie "..v.." (ID: "..areaID..")",
			}
		)
	end
end

function mapper:getArea(areaID)
	local list = getAreaTable()
	local returnid, fullareaname
	for area, id in pairs(list) do
		if id == areaID then
			returnid = id; fullareaname = area
		end
	end
	return returnid, fullareaname
end
