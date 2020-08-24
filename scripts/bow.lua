bow = bow or {}
bow.active = false
bow.target = "pajaka"
bow.dir = nil
bow.switch = true

function bow:wield()
	if self.active then
		send("opusc bronie; dobadz luku; dobadz kuszy", false)
		send("strzel w "..self.target.." na "..self.dir)
	end
end

function bow:miss()
	if self.active then
		scripts:beep()
		--mapper:move(self.dir)
	end
end

function bow:arrows()
	if self.active then
		send("wez strzaly;wyrwij strzaly z ciala; odloz zlamane strzaly; wloz strzaly do kolczanu")
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

function bow:num5()
	return function()
		if self.active then
			if self.switch then
				send("opusc luk;"..inventory:weaponOut(true))
				self.switch = false
			else
				send(inventory:weaponIn(true)..";dobadz luku")
				self.switch = true
			end
		end
	end
end


scripts.events["modMoveBow"] = registerAnonymousEventHandler("modMove", bow:move())
scripts.events["bowNum5"] = registerAnonymousEventHandler("num5", bow:num5())
