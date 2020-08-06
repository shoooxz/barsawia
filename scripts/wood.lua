wood = wood or {}
wood.going = false
wood.cutting = false
wood.hewing = false
wood.capture = false
wood.count = 1
wood.int2str = {
	[1] = "pierwsze",
    [2] = "drugie",
    [3] = "trzecie",
    [4] = "czwarte",
    [5] = "piate",
    [6] = "szoste",
    [7] = "siodme",
    [8] = "osme",
    [9] = "dziewiate",
    [10] = "dziesiate",
}
wood.step = 1
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
}

--Niestety, zadne z widocznych tu drzew nie jest godne twojej uwagi.
--Otaczajace cie drzewa sa mlode i watle, wroc, gdy urosna.
--W tej czesci lasu zadne z drzew nie nadaje sie do scinki.

function wood:detect(str)
	if self.capture then
		local rows = utils:splitcommai(str)
		local out = {}
		local sum = 0
		for i = 1, #rows do
			local name = string.lower(rows[i])
			if self.list[name] then
				sum = sum + self.list[name]
				name = name.." ~ "..self.list[name].." zlotych monet"
			else
				name = name.." (Brak umiejetnosci)"
			end
			table.insert(out, {
				i,
				name
			})
		end
		printer:wood(out, sum.." zlotych monet")
		self.capture = false
	end
end

function wood:cut(next)
	if not self.cutting then
		send("zbadaj wyreb")
		self.cutting = true
	else
		if not self.hewing then
			if next then
				self.count = self.count+1
			end
			send("zetnij "..self.int2str[self.count].." drzewo")
		end
	end
end

function wood:hew(next)
	if self.cutting then
		self.hewing = true
		if next then
			self.step = self.step+1
		end
		tempTimer(math.random(1, 2), function() send(self.steps[self.step]) end)
	end
end

function wood:done()
	display('DONE')
	self.cutting = false
	self.hewing = false
	self.step = 1
	self.count = 1
end


--[[

DRZEWO
monumentalne drzewo o poteznym pniu
piaskowokore drzewo o gestym igliwiu
Wlochatolistne drzewo o czarnej korze
trojkatnolistne drzewo o blekitnej korze

]]--
