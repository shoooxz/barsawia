wood = wood or {}
wood.cutting = false
wood.hewing = false
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
