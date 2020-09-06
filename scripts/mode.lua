--  https://github.com/Mudlet/Mudlet/pull/4043
mode = mode or {}
mode.trigger = {}
mode.triggerStyle = {
	["color"] = "#1D1D1D",
	["width"] = 100,
	["height"] = 40,
	["font"] = 18
}
mode.buttonStyle = [[
	border: 1px solid #1D1D1D;
	background-color: #47474B;
]]
mode.buttonStyleActive = [[
	border: 1px solid #1D1D1D;
	background-color: green;
]]
-- nazwa w order odpowiada nazwie klasy
-- kazda z klas powinna posiadac .active = false
-- kazda z klas powinna byc zdeklarowana w order i exec
mode.order = {
	"bow",
	"wood",
	"miner",
}
mode.exec = {
	["bow"] = {
		["name"] = "Lucznik",
		["func"] = function()
			mode:active("bow", "Opis i dostepne komendy /lucznik")
		end,
	},
	["wood"] = {
		["name"] = "Drwal",
		["func"] = function()
			mode:active("wood", "Opis i dostepne komendy /drwal")
		end,
	},
	["miner"] = {
		["name"] = "Gornik",
		["func"] = function()
			mode:active("miner", "Opis i dostepne komendy /gornik")
		end,
	},
}
mode.button = {}

function mode:init()
	self:createUI()
end

function mode:active(name, msg)
	if _G[name].active == false then
		self:reset()
		_G[name].active = true
		self.button[name]:setStyleSheet(self.buttonStyleActive)
		printer:one("Tryb", msg)
	end
end

function mode:reset()
	for i = 1, #self.order do
		local name = self.order[i]
		_G[name].active = false -- ustaw obiekty na nieaktywne
		self.button[name]:hide() -- ukryj buttony
		self.button[name]:setStyleSheet(self.buttonStyle) -- resetuj styl
	end
end

function mode:createUI()
	self.trigger = Geyser.Label:new({
		name = "mode.trigger",
		x = -settings:get("mapperWidth")-self.triggerStyle.width-15, -- -15 for scroll
		y = -footer.height-self.triggerStyle.height, -- TODO profile footer.height ???
		width = self.triggerStyle.width,
		height = self.triggerStyle.height,
		--nestable = true,
		fgColor = "#ffffff",
		color = self.triggerStyle.color,
		nestflyout = true,
		message = "<center>^</center>"
	})
	self.trigger:setFontSize(self.triggerStyle.font)
	for i = 1, #self.order do
		local name = self.order[i]
		self.button[name] = self.trigger:addChild({
			name = "mode.button."..name,
			width = self.triggerStyle.width,
			height = 50,
			layoutDir = "TV",
			flyOut = true,
			message = "<center>"..self.exec[name].name.."</center>"
		})
		self.button[name]:setStyleSheet(self.buttonStyle)
		self.button[name]:setFontSize(self.triggerStyle.font)
		self.button[name]:setClickCallback(self.exec[name].func)
	end
end
