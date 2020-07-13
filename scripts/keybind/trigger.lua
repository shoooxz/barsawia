function keybind:job(who, type)
	if string.match(who, "krasnoludka") then
		self.triggerCommand = "zapytaj krasnoludke o "..type
		printer:bind("[", self.triggerCommand)
	elseif string.match(who, "krasnolud") then
		self.triggerCommand = "zapytaj krasnoluda o "..type
		printer:bind("[", self.triggerCommand)
	elseif string.match(who, "elfka") then
		self.triggerCommand = "zapytaj elfke o "..type
		printer:bind("[", self.triggerCommand)
	elseif string.match(who, "elf") then
		self.triggerCommand = "zapytaj elfa o "..type
		printer:bind("[", self.triggerCommand)
	elseif string.match(who, "hobbitka") then
		self.triggerCommand = "zapytaj hobbitke o "..type
		printer:bind("[", self.triggerCommand)
	elseif string.match(who, "hobbit") then
		self.triggerCommand = "zapytaj hobbita o "..type
		printer:bind("[", self.triggerCommand)
	elseif string.match(who, "mezczyzna") or string.match(who, "kobieta") or string.match(who, "czlowiek") then
		self.triggerCommand = "zapytaj czlowieka o "..type
		printer:bind("[", self.triggerCommand)
	end
end
