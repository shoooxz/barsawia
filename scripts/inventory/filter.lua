inventory.filter = inventory.filter or {}
inventory.filter.unknown = "Nieznany"
inventory.filter.skip = {}
inventory.filter.weapons = {
	["1"] = "Miecze",
	["2"] = "Topory",
	["3"] = "Sztylety",
	["4"] = "Mloty",
	["5"] = "Maczugi",
	["6"] = "Drzewce",
}
inventory.filter.patterns = {
  ["Kamienie"] = {
    -- pierwsza forma TODO kamienie ?
	--[[
    "agaty?o?w?",
    "apatyty?o?w?",
    "azuryty?o?w?",
    "bursztyny?o?w?",
    "celestyny?o?w?",
    "chryzoprazy?o?w?",
    "cyrkony?o?w?",
    "cytryny?o?w?",
    "diamenty?o?w?",
    "diopsydy?o?w?",
    "fluoryty?o?w?",
    "gagaty?o?w?",
    "granaty?o?w?",
    "heliodory?o?w?",
    "hematyty?o?w?",
    "jaspisy?o?w?",
    "labradory?o?w?",
    "lazuryty?o?w?",
    "malachity?o?w?",
    "nefryty?o?w?",
    "obsydiany?o?w?",
    "onyksy?o?w?",
    "ortoklazy?o?w?",
    "rodochrozyty?o?w?",
    "rubiny?o?w?",
    "serpentyny?o?w?",
    "szafiry?o?w?",
    "szmaragdy?o?w?",
    "topazy?o?w?",
    "turkusy?o?w?",
    "turmaliny?o?w?",
    "tytanity?o?w?",
    "zoisyty?o?w?",
    "awenturyny?o?w?",
    "iolity?o?w?",
    "aleksandryty?o?w?",
    "kyanity?o?w?",
    "almandyny?o?w?",
    "piryty?o?w?",
    "rodolity?o?w?",
    "monacyty?o?w?",
    "oliwiny?o?w?",
    -- druga forma
    "karneole?i?",
    "opale?i?",
    "spinele?i?",
    "chryzoberyle?i?",
    -- trzecia forma
    "kwarce?o?w?",
    -- unikalne
    "perle",
    "perly",
    "perel",
    "gorski krysztal",
    "gorskie krysztaly",
    "gorskich krysztalow",
	]]--
  },
  ["Monety"] = {
    "monety?e?"
  },
  ["Tarcze"] = {
    "tarcza?e?",
    "paweze?y?",
  },
  ["Topory"] = {
	"siekiery?e?",
    "topory?o?w?",
    "czekany?o?w?",
    "topor bojowy",
    "topory bojowe",
    "toporow bojowych",
    "topor bitewny",
    "topory bitewne",
    "toporow bitewnych",
    "toporek",
    "toporki",
    "toporkow",
	"tasaki?o?w?",
  },
  ["Sztylety"] = {
  	"sztylety?o?w?",
    "parazony?",
    "parazonia",
    "lewaki?o?w?",
    "stiletto?a?",
    "puginaly?o?w?",
    "navaje?",
    "noze?o?w?",
    "kindzaly?o?w?",
    "katary?o?w?",
    "noz bojowy",
    "noze bojowe",
    "nozy bojowych"
  },
  ["Miecze"] = {
    "mieczy?e?",
    "szabla?e?i?",
    "espadony?o?w?",
    "multony?o?w?",
    "bastardy?o?w?",
    "talwary?o?w?",
    "sihille?o?w?",
    "flambergi?o?w?",
    "poltoraki?o?w?",
    "katzbalgery?o?w?",
    "schiavony?",
    "estoki?o?w?",
    "jatagany?o?w?",
    "gladiusy?o?w?",
    "miecz dwureczny",
    "miecze dwureczne",
    "mieczow dwurecznych",
    "kordy?o?w?",
    "palasze?y?",
    "szamsziry?o?w?",
    "chepesz?e?o?w?"
  },
  ["Mloty"] = {
    "mloty?o?w?",
    "nadziaki?o?w?",
    "kilofy?o?w?",
    "mlot bojowy",
    "mloty bojowe",
    "mlotow bojowych",
    "mlot rycerski",
    "mloty rycerskie",
    "mlotow rycerskich",
    "obuszek",
    "obuszki",
    "obuszkow",
    "mlot wojenny",
    "mloty wojenne",
    "mlotow wojennych",
    "mloty dwureczne",
    "mlot dwureczny",
    "mlotow dwurecznych",
    "mlot poltorareczny",
    "mloty poltorareczne",
    "mlotow poltorarecznych",
  },
  ["Maczugi"] = {
    "maczuge?i?",
    "bulawe?y?",
    "wekiere?y?",
    "morgensterny?o?w?",
    "nasieki?e?",
    "kostury?o?w?",
    "biczy?o?w?",
    "paly",
    "%spale",
    "%spal",
	"%spalki",
	"%spalke",
	"%spalek",
    "lancuchy?o?w?",
    "buzdygany?o?w?",
    "kropacze?y?",
    "korbacze?y?",
    "kotwica?e?",
    "maczuge rycerska",
    "maczugi rycerskie",
    "maczug rycerskich",
    "kosci?",
    "baty?o?w?"
  },
  ["Drzewce"] = {
    "kose?y?",
    "halabarde?y?",
    "trojzab",
    "trojzeby",
    "trojzebow",
    "partyzane?y?",
    "naginate?y?",
    "rohatyne?y?",
    "spise?y?",
    "wlocznia?e?",
    "darde?y?",
    "cepy?o?w?",
    "szpontony?o?w?",
    "glewia?e?",
    "dzide?y?",
    "korseke?i?",
	"kiscieni?e?",
    "harpuny?o?w?",
    "kose bojowa",
    "kosy bojowe",
    "kos bojowych",
    "berdysze?y?",
    "gizarme?y?",
	"pike?i?",
    "wlocznie z proporcem",
    "wloczni z proporcem",
  },
  ["Karaceny"] = {
    "karacene?y?",
    "anime",
    "animy",
    "anim"
  },
  ["Pancerze"] = {
    "pancerze?y?",
    "pancerz.*",
    "zbroje.*",
    "zbroi"
  },
  ["Helmy"] = {
    "przylbice?",
    "helm.*",
    "salade?y?",
    "morion.*",
    "korone?y?",
    "basinety?o?w?",
    "szyszaki?o?w?",
    "barbute?y?"
  },
  ["Naramienniki"] = {
    "naramiennik.*",
    "nareczak.*",
    "nalokietnik.*",
    "karwasze",
    "karwaszy"
  },
  ["Nagolenniki"] = {
    "nagolennik.*",
    "naudziak.*",
    "bigwant.*",
    "spodnic.*",
    "nabiodrk.*",
	"nogawi.*"
  },
  ["Bizuteria"] = {
    "amulet.*",
    "pierscien",
    "pierscienie",
    "pierscieni",
    "diadem.*",
    "bransolet.*",
    "opask.*",
    "pasy?"
  },
  ["Plaszcze"] = {
    "plaszcz.*",
  },
  ["Napiersniki"] = {
    "napiersnik.*",
    "nabrzusznik.*",
    "kirys?y?o?w?",
    "chalkochidony?o?w?",
  },
  ["Kolczugi"] = {
    "kolczug.*",
    "brygantyn.*",
    "kaftan.*",
    "tunik.*"
  },
  ["Zbroje plytowe"] = {
    "zbroje plytow.*",
    "zbroi plytowych.*"
  },
  ["Rekawice"] = {
    "rekawic.*"
  }
}

function inventory.filter:show(str, last)
	local out = {
		[self.unknown] = {}
	}
	local list = utils:split2(str..", ", ",%s")
	table.insert(list, last)
	deleteLine()
	--self:setSkip()
	for i = 1, #list do
		local count, name = list[i]:match("(%w+)%s(.*)")
		if inventory.count2short[count] then
			count = inventory.count2short[count]
		else
			count = 1
			name = list[i]
		end
		local type = self:getType(name)
		if type then
			-- skategoryzowane
			if not out[type] then
			 	out[type] = {}
		 	end
			table.insert(out[type], {
				count,
				name
			})
		else
			-- nieznane
			table.insert(out[self.unknown], {
				count,
				name
			})
		end
	end
	printer:filter(out)
end

function inventory.filter:setSkip()
	local arr = utils:arrayDiff(utils:arrayKeys(self.weapons), profile:get("filter_weapon"))
	for i, id in pairs(arr) do
		self.skip[self.weapons[id]] = true
	end
end

function inventory.filter:getType(name)
	local out = nil
	for type, pattern in pairs(self.patterns) do

			for i = 1, #pattern do
				if string.match(name, ".*"..pattern[i].."$") then
					return type
				end
			end
	end

end

function inventory.filter:weaponExists(idToCheck)
	if self.weapons[idToCheck] then
		return true
	end
end
