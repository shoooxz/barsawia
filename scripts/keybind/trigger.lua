-- TRIGER BIND
function keybind:job(who, type)
	if string.match(who, "krasnoludka") then
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
	elseif string.match(who, "mezczyzna") or string.match(who, "kobieta") or string.match(who, "czlowiek") then
		self.triggerCommand = "zapytaj czlowieka o "..type
	end
	if self.triggerCommand then
		printer:bind(self.conf.keybindTrigger.modifier, self.conf.keybindTrigger.key, self.triggerCommand)
	end
end

function keybind:shipEnter()
	self.triggerCommand = inventory:moneyOut(true)..";kup bilet;wejdz na statek"
	printer:bind(self.conf.keybindTrigger.modifier, self.conf.keybindTrigger.key, self.triggerCommand)
end

function keybind:shipLeave()
	self.triggerCommand = "zejdz ze statku"
	mapper.gmcpNextLocation = true
	printer:bind(self.conf.keybindTrigger.modifier, self.conf.keybindTrigger.key, self.triggerCommand)
end

-- ROOM BIND
function keybind:room(command)
	self.roomCommand = command
	printer:bind(self.conf.keybindRoom.modifier, self.conf.keybindRoom.key, command)
end

-- GATE BIND
function keybind:gate(str)
	local gate2command = {
		["Wschodnia brama jest zamknieta."] = "zastukaj we wschodnie wrota",
		["Zachodnia brama jest zamknieta."] = "zastukaj w zachodnie wrota",
	}
	local command = "zastukaj we wrota;otworz brame"
	if gate2command[str] then
		command = gate2command[str]
	end
	self.gateCommand = command
	printer:bind(self.conf.keybindGate.modifier, self.conf.keybindGate.key, command)
end
