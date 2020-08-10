bow = bow or {}
bow.active = false
bow.target = "jaszczura"
bow.dir = nil

function bow:wield()
	if self.active then
		send("opusc bronie; dobadz luku; dobadz kuszy", false)
		send("strzel w "..self.target.." na "..self.dir)
	end
end

function bow:miss()
	if self.active then
		mapper:move(self.dir)
	end
end

function bow:arrows()
	if self.active then
		send("wyrwij strzaly z ciala; odloz zlamane strzaly; wloz strzaly do kolczanu")
	end
end

function bow:set(target)
	if self.active then
		self.target = target
		printer:one("Luk", "Ustawiam cel na "..target)
	end
end

function bow:move()
	return function(e, dir)
		if self.active then
			self.dir = dir
			send("strzel w "..self.target.." na "..dir)
		end
	end
end

scripts.events["modMoveBow"] = registerAnonymousEventHandler("modMove", bow:move())
