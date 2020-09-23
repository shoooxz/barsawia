inventory.repair = inventory.repair or {}
inventory.repair.count = 1
inventory.repair.going = false
inventory.repair.how = nil
inventory.repair.what = nil
inventory.repair.step = 1
inventory.repair.short2long = {
    "pierwsza",
    "druga",
    "trzecia",
    "czwarta",
    "piata",
    "szosta",
    "siodma",
    "osma",
    "dziewiata",
    "dziesiata",
    "jedenasta",
    "dwunasta",
    "trzynasta",
    "czternasta",
    "pietnasta",
}

function inventory.repair:go()
	self.going = true
	self.count = 1
	self.how = "naostrz"
	self.what = "bron"
	self.step = 1
    send("zdejmij wszystkie zbroje")
	self:send()
end

function inventory.repair:send()
	send(self.how.." "..self.short2long[self.count].." "..self.what, false)
end

function inventory.repair:armor()
	if self.going then
		self.count = 1
		self.how = "napraw"
		self.what = "zbroje"
		self.step = 2
		self:send()
	end
end

function inventory.repair:next()
	if self.going then
    	self.count = self.count+1
		self:send()
	end
end

function inventory.repair:shield()
	if self.going then
		self.count = 1
		self.how = "napraw"
		self.what = "tarcze"
		self.step = 3
		self:send()
	end
end

function inventory.repair:stop()
	if self.going then
		if self.step == 2 then
			self:shield()
		else
			self.going = false
			send("zaloz wszystkie zbroje; zaloz tarcze; dobadz wszystkich broni", false)
		end
	end
end
