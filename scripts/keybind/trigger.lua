-- TRIGER BIND
function keybind:job(who, type)
	if string.match(who, "ork") then
		self.triggerCommand = "zapytaj orka o "..type
	elseif string.match(who, "obsydianin") then
		self.triggerCommand = "zapytaj obdsydianina o "..type
	elseif string.match(who, "wietrzniaczka") then
		self.triggerCommand = "zapytaj wietrzniaczke o "..type
	elseif string.match(who, "wietrzniak") then
		self.triggerCommand = "zapytaj wietrzniaka o "..type
	elseif string.match(who, "olbrzymka") then
		self.triggerCommand = "zapytaj olbrzymke o "..type
	elseif string.match(who, "olbrzym") then
		self.triggerCommand = "zapytaj olbrzyma o "..type
	elseif string.match(who, "krasnoludka") then
		self.triggerCommand = "zapytaj krasnoludke o "..type
	elseif string.match(who, "krasnolud") then
		self.triggerCommand = "zapytaj krasnoluda o "..type
	elseif string.match(who, "elfka") then
		self.triggerCommand = "zapytaj elfke o "..type
	elseif string.match(who, "elf") then
		self.triggerCommand = "zapytaj elfa o "..type
	elseif string.match(who, "hobbitka") then
		self.triggerCommand = "zapytaj hobbitke o "..type
	elseif string.match(who, "hobbit") then
		self.triggerCommand = "zapytaj hobbita o "..type
	elseif string.match(who, "mezczyzna") then
		self.triggerCommand = "zapytaj mezczyzne o "..type
	elseif string.match(who, "kobieta") then
		self.triggerCommand = "zapytaj kobiete o "..type
	elseif string.match(who, "czlowiek") then
		self.triggerCommand = "zapytaj czlowieka o "..type
	end
	if self.triggerCommand then
		self:triggerPrint()
	end
end

function keybind:shipEnter()
	scripts:beep()
	self.triggerCommand = inventory:moneyGet(true)..";kup bilet;wejdz na statek"
	self:triggerPrint()
end

function keybind:shipLeave()
	scripts:beep()
	self.triggerCommand = "zejdz ze statku"
	mapper.gmcpNextLocation = true
	self:triggerPrint()
end

function keybind:cartEnter(type)
	local type2command = {
		["woz"] = "wejdz na woz",
		["dylizans"] = "wejdz do dylizansu",
	}
	scripts:beep()
	self.triggerCommand = inventory:moneyGet(true)..";"..type2command[type]
	self:triggerPrint()
end

function keybind:cartLeave()
	scripts:beep()
	self.triggerCommand = "wyjscie"
	mapper.gmcpNextLocation = true
	self:triggerPrint()
end

function keybind:pass()
	self.triggerCommand = inventory:moneyGet(true)..";kup przepustke"
	self:triggerPrint()
end

function keybind:pass2()
	self.triggerCommand = inventory:moneyGet(true)..";zaplac za przepustke"
	self:triggerPrint()
end

-- ROOM BIND
function keybind:room(command)
	self.roomCommand = command
	printer:bind(self.conf.keybindRoom.modifier, self.conf.keybindRoom.key, command)
end

-- DEPOSIT BIND
function keybind:deposit()
	printer:bind(self.conf.keybindZero.modifier, self.conf.keybindZero.key, "popros o wydanie depozytu")
end

-- GATE BIND
function keybind:gate(str)
	local gate2command = {
		["Wschodnia brama jest zamknieta."] = "zastukaj we wschodnie wrota",
		["Zachodnia brama jest zamknieta."] = "zastukaj w zachodnie wrota",
		["Brama jest zamknieta, wiec nie uda ci sie przez nia przedostac."] = "uderz w brame",
		["Forsowanie zamknietej bramy nie jest rozsadnym pomyslem..."] = "uderz w brame;uderz w dzwoneczek",
		["Przechodzenie przez zamknieta brame nie jest najlepszym pomyslem."] = "uderz w dzwoneczek",
		["Alez most nie jest opuszczony"] = "uderz w dzwon",
	}
	local command = "zastukaj we wrota;uruchom mechanizm;zastukaj;otworz brame"
	if gate2command[str] then
		command = gate2command[str]
	end
	self.gateCommand = command
	mapper:walkerInterrupted(command)
	printer:bind(self.conf.keybindGate.modifier, self.conf.keybindGate.key, command)
end
