footer = footer or {}
footer.container = {}
footer.rail = {}
footer.gauge = {}
footer.col = {}
footer.railMargin = 10
footer.height = 90
footer.color = "#1D1D1D"
footer.gaugeOrder = {
	"hp",
	"fatigue",
	"panic",
  	"improve",
	"stuffed",
	"soaked",
  	"encumberance",
  	"mana",
	"intox",
	"headache",
}
footer.gaugeData = {
	["hp"] = {
		["name"] = "Kondycja",
		["max"] = 6,
		["range"] = {"r", "r", "y", "y", "g", "g"},
	},
	["fatigue"] = {
		["name"] = "Zmeczenie",
		["max"] = 9,
		["range"] = {"r", "r", "r", "y", "y", "g", "g", "g", "g"},
	},
	["panic"] = {
		["name"] = "Panika",
		["max"] = 4,
		["range"] = {"g", "y", "r", "r"},
	},
	["improve"] = {
		["name"] = "Postepy",
		["max"] = 24,
		["range"] = {"g", "g", "g", "g", "g", "g", "g", "g", "g", "g", "y", "y", "y", "y", "y", "y", "y", "y", "r", "r", "r", "r", "r", "r"},
	},
	["stuffed"] = {
		["name"] = "Glod",
		["max"] = 3,
		["range"] = {"r", "y", "g"},
	},
	["soaked"] = {
		["name"] = "Pragnienie",
		["max"] = 3,
		["range"] = {"r", "y", "g"},
	},
	["encumberance"] = {
		["name"] = "Obciazenie",
		["max"] = 6,
		["range"] = {"g", "y", "y", "r", "r", "r"},
	},
	["mana"] = {
		["name"] = "Mana",
		["max"] = 8,
		["range"] = {"r", "r", "r", "y", "y", "y", "g", "g"},
	},
	["intox"] = {
		["name"] = "Upicie",
		["max"] = 5,
		["range"] = {"g", "y", "y", "r", "r"},
	},
	["headache"] = {
		["name"] = "Kac",
		["max"] = 5,
		["range"] = {"g", "y", "y", "r", "r"},
	},
}

footer.gaugeColor = {
	["g"] = [[
		background-color: green;
		margin: 0 0 ]]..footer.railMargin.." "..footer.railMargin..[[;
	]],
	["y"] = [[
		background-color: yellow;
		margin: 0 0 ]]..footer.railMargin.." "..footer.railMargin..[[;
	]],
	["r"] = [[
		background-color: red;
		margin: 0 0 ]]..footer.railMargin.." "..footer.railMargin..[[;
	]],
	["background"] = [[
		background-color: #47474B;
		margin: 0 0 ]]..footer.railMargin.." "..footer.railMargin..[[;
	]]
}

function footer:gmcpCharState()
	return function()
		for k, v in pairs(gmcp.Char.State) do
			self:set(k, v)
		end
	end
end

function footer:init()
	self:createUI()
	-- event rejestrowany w tym miejscu ze wzgledu na odpalenie klasy przed skryptami
	scripts.events["gmcpCharState"] = registerAnonymousEventHandler("gmcp.Char.State", self:gmcpCharState())
end

function footer:createUI()
	setBorderBottom(self.height)
	self.container = Geyser.Label:new({
		name = "footer.container",
		x = 0, y = -self.height,
		width = "100%", height = self.height,
		fgColor = "black",
		color = self.color
	})
	self.rail = Geyser.HBox:new({
		name = "footer.rail",
		x = 0, y = self.railMargin,
		width = "50%", height = self.height-self.railMargin
	}, self.container)
	for i=1, 5 do
		self.col[i] = Geyser.VBox:new({
			name = "footer.rail.col."..i
		}, self.rail)
	end
	local col = 1
	for i=1, #self.gaugeOrder do
		self:createGauge(self.gaugeOrder[i], self.col[col])
		if i % 2 == 0 then
			col = col +1
		end
	end
end

function footer:createGauge(name, parent)
	self.gauge[name] = nil
	self.gauge[name] = Geyser.Gauge:new({
		name = "gauge."..name,
		width = "100%",
        h_policy = Geyser.Fixed,
	}, parent)
	self.gauge[name].front:echo([[<font color="black">]]..self.gaugeData[name].name..[[</font>]])
	self.gauge[name].front:setFontSize(14)
	self.gauge[name].back:echo([[<font color="black">]]..self.gaugeData[name].name..[[</font>]])
	self.gauge[name].back:setFontSize(14)
	self.gauge[name].front:setStyleSheet(self.gaugeColor.g)
	self.gauge[name].back:setStyleSheet(self.gaugeColor.background)
	self.gauge[name]:setValue(0, self.gaugeData[name].max)
end

function footer:set(name, value)
	local color = "g"
	if self.gaugeData[name].range[value] then
		color = self.gaugeData[name].range[value]
	end
	self.gauge[name].front:setStyleSheet(self.gaugeColor[color])
	self.gauge[name]:setValue(value, self.gaugeData[name].max)
end
