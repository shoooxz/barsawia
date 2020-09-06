wood = wood or {}
wood.active = false
wood.roomID = false
wood.hewing = false
wood.capture = false
wood.quest = false
wood.count = 1 -- count dla scinania
wood.step = 1 -- step dla ciosania
wood.switch = true
wood.int2str = {
	"pierwsze",
    "drugie",
    "trzecie",
    "czwarte",
    "piate",
    "szoste",
    "siodme",
    "osme",
    "dziewiate",
    "dziesiate",
}
wood.steps = {
	"odrab konary drzewa",
	"odetnij galezie drzewa",
	"odgarnij kore klody",
	"doczysc klode"
}
wood.list = {
	['srebnolistny dab o krepym pniu'] = 1,
	['lepkolistna lipa o sciemnialej korze'] = 1,
	['snieznokora brzoza o spekanym pniu'] = 1,
	['zielonkawokora wierzba o wiotkich lisciach'] = 1,
	['rdzawokora wykrzywiona sosna'] = 1,
	['srebrzystoigly swierk o brazowej korze'] = 1,
	['pochylona osika o lepkiej korze'] = 1,
	['srzebrzystokory buk o purpurowych lisciach'] = 4,
	['strzelista topola o szarobialej korze'] = 8,
	['szarokory jarzab o rozdwojonym pniu'] = 8,
	['szorstkokora olsza o jajowatych lisciach'] = 8,
	['brunatnokory kasztan o dloniastopierzastych lisciach'] = 8,
	['trojlistkowy strzepistoskory klon'] = 8,
	['pierzastolistny jesion o bruzdowanej korze'] = 12,
	['krotkoigla jodla o szarobialym pniu'] = 13,
	['kolcokory kalopanaks o dloniastych lisciach'] = 18,
	['czerwonokory modrzew o stozkowatej koronie'] = 18,
	['luskoigla tuja o szarobrazowym pniu'] = 22,
	['jajowatolistny wiaz o brazowoszarej korze'] = 24,
	['garbaty grab o jasnobrazowej korze'] = 30,
	['dlugolistna magnolia o spekanej korowinie'] = 30,
	['wzorzystoskory tepoigly cis'] = 37,
	['wlochatolistny hebanowiec o czarnej korze'] = 65,
	['piaskowokory cedr o gestym igliwiu'] = 66,
	['trojkatnolistny xylech o blekitnej korze'] = 75,
	['monumentalna sekwoja o poteznym pniu'] = 87,
}

function wood:detect(str)
	if self.capture then
		local rows = utils:splitcommai(str)
		local out = {}
		local sum = 0
		if next(rows) then
	 		for i = 1, #rows do
				local name = string.lower(rows[i])
				local link = {}
				if self.list[name] then
					sum = sum + self.list[name]
					name = name.." ~ "..self.list[name].." zl"
					link = {
						["label"] = name,
						["command"] = "wood:cutViaID("..i..")",
						["tooltip"] = "Zetnij "..name,
					}
				else
					link = name.." (Brak umiejetnosci)"
				end
				table.insert(out, link)
			end
			self.roomID = mapper.room.id
		end
		printer:wood(out, sum.." zlotych monet", self.quest)
		self.capture = false
		self.hewing = false
	end
end

function wood:cutViaID(id)
	self.count = id
	send("zetnij "..self.int2str[self.count].." drzewo")
end

function wood:cut(next)
	if next then
		self.count = self.count+1
	end
	send("zetnij "..self.int2str[self.count].." drzewo")
end

function wood:hew(next)
	self.hewing = true
	if next then
		self.step = self.step+1
	end
	printer:progress("Drwal", self.step*5, 25)
	tempTimer(math.random(1, 2), function() send(self.steps[self.step]) end)
end

function wood:get()
	scripts:beep()
	self.hewing = false
	self.step = 1
	self.count = 1
	send("wez klody")
end

function wood:done()
	printer:progress("Drwal", 25, 25)
	scripts:beep()
	self.hewing = false
	self.step = 1
	self.count = 1
end

function wood:setQuest(str)
	self.quest = str
end

function wood:num5()
	return function()
		if self.active then
			if self.roomID and self.roomID == mapper.room.id then
				if not self.hewing then
					self:cut()
				else
					self:hew()
				end
			else
				send("zbadaj wyreb")
			end
		end
	end
end

function wood:slash()
	return function()
		if self.active then
			if self.switch then
				send("opusc siekiere;"..inventory:weaponGet(true))
				self.switch = false
			else
				send(inventory:weaponPut(true).."dobadz siekiery")
				self.switch = true
			end
		end
	end
end

scripts.events["woodNum5"] = registerAnonymousEventHandler("num5", wood:num5())
scripts.events["woodSlash"] = registerAnonymousEventHandler("slash", wood:slash())
