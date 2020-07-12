keybind = keybind or {}
keybind.ids = keybind.ids or {}
keybind.conf = {
	{
		["modifier"] = nil,
		["key"] = "BracketRight",
		["callback"] = "mapperBind",
	},
	{
		["modifier"] = "Control",
		["key"] = "W",
		["callback"] = "fightSupport",
	},
}

function keybind:init()
	self:unbind()
	for i, bind in pairs(self.conf) do
		self:create(bind.modifier, bind.key, bind.callback)
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

keybind:init()
