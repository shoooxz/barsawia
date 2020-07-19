keybind = keybind or {}
keybind.ids = keybind.ids or {}
keybind.triggerCommand = nil
keybind.roomCommand = nil
keybind.gateCommand = nil
keybind.conf = {
	["keybindRoom"] = {
		["modifier"] = nil,
		["key"] = "BracketRight",
	},
	["keybindTrigger"] = {
		["modifier"] = nil,
		["key"] = "BracketLeft",
	},
	["keybindSupport"] = {
		["modifier"] = "Control",
		["key"] = "W",
	},
	["keybindGate"] = {
		["modifier"] = "Control",
		["key"] = "2",
	},
}

function keybind:init()
	self:unbind()
	for callback, bind in pairs(self.conf) do
		self:create(bind.modifier, bind.key, callback)
	end
end

function keybind:create(modifier, key, callback)
	modifier = mudlet.keymodifier[modifier]
	key = mudlet.key[key]
	if key and _G[callback] then
        table.insert(self.ids, tempKey(modifier, key, callback .. "()")) -- heh?
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
