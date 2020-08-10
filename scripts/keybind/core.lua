keybind = keybind or {}
keybind.ids = keybind.ids or {}
keybind.triggerCommand = nil
keybind.roomCommand = nil
keybind.gateCommand = nil
keybind.conf = {
	["keybindRoom"] = {
		["modifier"] = {},
		["key"] = "BracketRight",
	},
	["keybindTrigger"] = {
		["modifier"] = {},
		["key"] = "BracketLeft",
	},
	["keybindSupport"] = {
		["modifier"] = {"Control"},
		["key"] = "W",
	},
	["keybindGate"] = {
		["modifier"] = {"Control"},
		["key"] = "2",
	},
	["keybindNum5"] = {
		["modifier"] = {"Keypad"},
		["key"] = "5",
	},
	["keybindN"] = {
		["modifier"] = {"Control", "Keypad"},
		["key"] = "8",
	},
	["keybindS"] = {
		["modifier"] = {"Control", "Keypad"},
		["key"] = "2",
	},
	["keybindW"] = {
		["modifier"] = {"Control", "Keypad"},
		["key"] = "4",
	},
	["keybindE"] = {
		["modifier"] = {"Control", "Keypad"},
		["key"] = "6",
	},
	["keybindNE"] = {
		["modifier"] = {"Control", "Keypad"},
		["key"] = "9",
	},
	["keybindSE"] = {
		["modifier"] = {"Control", "Keypad"},
		["key"] = "3",
	},
	["keybindSW"] = {
		["modifier"] = {"Control", "Keypad"},
		["key"] = "1",
	},
	["keybindNW"] = {
		["modifier"] = {"Control", "Keypad"},
		["key"] = "7",
	},
}

function keybind:init()
	self:unbind()
	for callback, bind in pairs(self.conf) do
		self:create(bind.modifier, bind.key, callback)
	end
end

function keybind:create(modifier, key, callback)
	local mod = 0
	if next(modifier) then
		for i=1, #modifier do
			mod = mod + mudlet.keymodifier[modifier[i]]
		end
	end
	key = mudlet.key[key]
	if key and _G[callback] then
        table.insert(self.ids, tempKey(mod, key, callback .. "()")) -- heh?
    end
end

function keybind:unbind()
	for i = 1, #self.ids do
		killKey(self.ids[i])
	end
    self.ids = {}
end

function keybind:triggerPrint()
	printer:bind(self.conf.keybindTrigger.modifier, self.conf.keybindTrigger.key, self.triggerCommand)
end

keybind:init()
