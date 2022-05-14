character = character or {}
character.statmax = 10
character.index2stat = {
	"str",
	"dex",
	"vit",
	"int",
	"wis",
	"bra"
}
character.what2stat = {
	["sile"] = 1,
	["zrecznosc"] = 2,
	["wytrzymalosc"] = 3,
	["inteligencje"] = 4,
	["madrosc"] = 5,
	["odwage"] = 6,
}
character.stats = character.stats or  {
	0, 0, 0, 0, 0, 0
}

character.statsProgress = character.statsProgress or {
	0, 0, 0, 0, 0, 0
}
character.capturing = false

-- TODO zrobic porownanie czy cecha wzrosla

function character:prepareCapture()
	self.capturing = true
	send("cechy;medytuj;ocen wszystko")
end

function character:captureStats(stats)
	local stored = true
	local temp = profile:get("stats_progress")
	if temp == 0 then
		stored = false
	else
		self.statsProgress = temp
	end
	local improve = "Postepy "..gmcp.Char.State.improve.."/"..gmcp.Char.Statemax.improve
	local arr = {}
	local progress = 0
	local progressLabel = ""
	local combat = 0
	local noncombat = 0
	local info = nil
	for i = 1, #stats do
		if stored then
			progress = self.statsProgress[i]
			self.stats[i] = self[self.index2stat[i]][stats[i]]
			if i == 1  or i == 2 or i == 3 then
				combat = combat + self.stats[i]*5+progress
			else
				noncombat = noncombat + self.stats[i]*5+progress
			end
			progressLabel = " ("..self.progress2name[progress]..")"
		end
		table.insert(arr, {
			self.stats[i].."/"..self.statmax,
			utils:ucfirst(stats[i])..progressLabel
		})
	end
	if not stored then
		info = "Uzyj komendy /medytuj w gildii podroznikow aby przechowac progres"
	end

	if not self.capturing then
		deleteLine()
		printer:stats(
			improve,
			arr,
			"Podcechy bojowe/niebojowe: "..combat.."/"..noncombat..". Razem: "..combat+noncombat,
			info
		)
	end
end

function character:captureProgress(stat, progress)
	if self.capturing then
		local statID = self.what2stat[stat]
		self.statsProgress[statID] = self.name2progress[progress]
		deleteLine()
		if statID == 6 then
			self.capturing = false
			profile:set("stats_progress", self.statsProgress)
			printer:one("Profil", "Progres cech uaktualniony!")
			send("powstan;cechy")
		end
	end
end
