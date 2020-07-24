printer = printer or {}
printer.length = 80
printer.titleColor = "green"
printer.titleMargin = 4
printer.borderColor = "white"
printer.tabLength = 1
printer.commandColor = "orange"
printer.descriptionColor = "white"
printer.textColor = "white"
printer.sectionColor = "yellow"
printer.errorColor = "red"
printer.infoColor = "DeepSkyBlue"
printer.successColor = "green"
printer.keyColor = "red"
printer.key2short = {
	["Control"] = "CTRL",
	["Alt"] = "ALT",
	["Shift"] = "SHIFT",
	["Keypad"] = "Keypad",
	["GroupSwitch"] = "GroupSwitch",
	["Equal"] = "=",
	["Plus"] = "+",
	["Minus"] = "-",
	["Asterisk"] = "*",
	["Ampersand"] = "&",
	["AsciiCircum"] = "^",
	["AsciiTilde"] = "~",
	["BracketLeft"] = "[",
	["BracketRight"] = "]",
	["BraceLeft"] = "{",
	["BraceRight"] = "}",
	["ParenLeft"] = "(",
	["ParenRight"] = ")",
	["QuoteLeft"] = "`",
	["QuoteDbl"] = "\"",
	["Apostrophe"] = "'",
	["Less"] = "<",
	["Greater"] = ">",
	["Slash"] = "/",
	["Backslash"] = "\\",
	["Underscore"] = "_",
	["Comma"] = ",",
	["Period"] = ".",
	["Colon"] = ":",
	["Semicolon"] = ";",
	["Bar"] = "|",
}
function printer:title(str, nospace, nomargin)
	local len = string.len(str)
	local left = string.rep("-", self.length-len-4-self.titleMargin) -- -4 dwie spacje i nawias
	local right = string.rep("-", self.titleMargin)
	local margin = "\n"
	if nomargin then margin = "" end
	cecho(margin.."<"..self.borderColor..">+"..left.."( <"..self.titleColor..">"..str.." <"..self.borderColor..">)"..right.."+\n")
	if not nospace then self:space() end
end

function printer:one(left, right)
	local len = self.length-string.len(left)-string.len(right)-self.tabLength-2  -- 2 : i spacja
	self:top(true)
	cecho(
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength)..
		"<"..self.sectionColor..">"..left..": "..
		"<"..self.textColor..">"..right..string.rep(" ", len)..
		"<"..self.borderColor..">|\n"
	)
	self:bottom(true)
end

function printer:bind(modifier, key, right)
	local left = self.key2short[key]
	if not left then
		left = key
	end
	if modifier then
		left = self.key2short[modifier].." + "..left
	end
	local len = self.length-string.len(left)-string.len(right)-self.tabLength-17  -- 17 Bind: Wcisnij ``
	self:top(true)
	cecho(
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength)..
		"<"..self.sectionColor..">BIND: "..
		"<"..self.textColor..">Wcisnij "..
		"<"..self.keyColor..">"..left.." "..
		"<"..self.textColor..">`"..right.."`"..string.rep(" ", len)..
		"<"..self.borderColor..">|\n"
	)
	self:bottom(true)
end

function printer:section(name)
	local len = self.length-string.len(name)-self.tabLength
	cecho(
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength)..
		"<"..self.sectionColor..">"..name..string.rep(" ", len)..
		"<"..self.borderColor..">|\n"
	)
	self:space()
end

function printer:command(name, desc)
	local len = self.length-string.len(name)-string.len(desc)-3-self.tabLength -- -3  2 spacje i myslnik
	cecho(
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength)..
		"<"..self.commandColor..">"..name..
		"<"..self.descriptionColor.."> - "..desc..string.rep(" ", len)..
		"<"..self.borderColor..">|\n"
	)
end

function printer:desc(name, desc)
	local len = self.length-string.len(name)-string.len(desc)-3-self.tabLength*2 -- -3  2 spacje i myslnik
	cecho(
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength*2)..
		"<"..self.commandColor..">"..name..
		"<"..self.descriptionColor.."> - "..desc..string.rep(" ", len)..
		"<"..self.borderColor..">|\n"
	)
end

function printer:info(desc)
	local len = self.length-string.len(desc)-self.tabLength*2
	cecho(
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength*2)..
		"<"..self.infoColor..">"..desc..string.rep(" ", len)..
		"<"..self.borderColor..">|\n"
	)
end

function printer:space()
 	cecho("<"..self.borderColor..">|"..string.rep(" ", self.length).."|\n")
end

function printer:top(nospace)
	cecho("\n<"..self.borderColor..">+"..string.rep("-", self.length).."+\n")
	if not nospace then self:space() end
end

function printer:bottom(nospace, nomargin)
	local margin = "\n\n"
	if not nospace then self:space() end
	if nomargin then margin = "" end
	cecho("<"..self.borderColor..">+"..string.rep("-", self.length).."+"..margin)
end

function printer:dumpArray(arr, firstColLength, header, color)
	if header then
		self:renderArrayRow(header[1], header[2], firstColLength, "orange")
		self:hr()
	end
	for k, v in pairs(arr) do
		self:renderArrayRow(v[1], v[2], firstColLength, color)
	end
end

function printer:renderArrayRow(left, right, firstColLength, color)
	local textColor = self.textColor
	if color then
		textColor = color
	end
	if type(right) == "table" then
		right = table.concat(right, ", ")
	end
	-- w przypadku tylko lewej strony
	local fillLeft = self.length-self.tabLength-1-string.len(left) -- -1 for 1 space
	local rightSide = ""
	-- w przypadku lewej i prawej strony
	if right then
		local fillRight = self.length-self.tabLength-1-firstColLength-string.len(right) -- -1 for | przedzialek
		fillLeft = firstColLength-self.tabLength-1-string.len(left) -- -1 for 1 space
		rightSide =
			"<"..self.borderColor..">|"..string.rep(" ", self.tabLength)..
			"<"..textColor..">"..right..string.rep(" ", fillRight)
	end
	local leftSide =
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength)..
		"<"..textColor.."> "..left..string.rep(" ", fillLeft)

	cecho(
		leftSide..rightSide.."<"..self.borderColor..">|\n"
	)
end

function printer:hr()
	local len = self.length-self.tabLength*2
	cecho(
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength)..string.rep("-", len)..string.rep(" ", self.tabLength)..
		"<"..self.borderColor..">|\n"
	)
end

function printer:errorLine(msg)
 	self:line(msg, self.errorColor)
end

function printer:successLine(msg)
 	self:line(msg, self.successColor)
end

function printer:line(msg, color)
	local len = self.length-string.len(msg)-self.tabLength
	if not color then
		color = self.textColor
	end
	cecho(
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength)..
		"<"..color..">"..msg..string.rep(" ", len)..
		"<"..self.borderColor..">|\n"
	)
end
