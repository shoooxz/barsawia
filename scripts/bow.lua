bow = bow or {}
bow.active = false
bow.target = "pajaka"
bow.dir = nil
bow.switch = true
bow.trigger = nil

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
				send("przestan celowac;opusc luk;"..inventory:weaponGet(true))
				self.switch = false
			else
				send(inventory:weaponPut(true).."dobadz luku")
				self.switch = true
			end
		end
	end
end

function bow:slash()
	return function()
		if self.active then
			if self.trigger then killTrigger(self.trigger) end
			self.trigger = tempRegexTrigger("^.*Doliczyl.s sie ([a-z]+) sztuki?\.$", function()
				for i=1, scripts.count2int[matches[2]] do
					send("wyrwij strzaly z "..scripts.int2which[i].." ciala", false);
				end
				send("odloz zlamane strzaly")
			end)
			send("policz ciala")
		end
	end
end

scripts.events["modMoveBow"] = registerAnonymousEventHandler("modMove", bow:move())
scripts.events["bowNum5"] = registerAnonymousEventHandler("num5", bow:num5())
scripts.events["bowSlash"] = registerAnonymousEventHandler("slash", bow:slash())
