bow = bow or {}
bow.target = "jaszczura"
bow.dir = nil

function bow:wield()
	send("opusc bronie;dobadz luku;dobadz kuszy", false)
	send("strzel w "..bow.target.." na "..bow.dir)
end

function bow:miss()
	mapper:move(self.dir)
end

function bow:arrows()

end

function bow:set(target)
	self.target = target
	printer:one("Luk", "Ustawiam cel na "..target)
end

function modMoveBowCallback(e, dir)
	if profile:get("bow") == 1 then
		bow.dir = dir
		send("strzel w "..bow.target.." na "..dir)
	end
end

scripts.events["modMoveBow"] = registerAnonymousEventHandler("modMove", modMoveBowCallback)
