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

function printer:title(str)
	local len = string.len(str)
	local left = string.rep("-", self.length-len-4-self.titleMargin) -- -4 dwie spacje i nawias
	local right = string.rep("-", self.titleMargin)
	cecho("\n<"..self.borderColor..">+"..left.."( <"..self.titleColor..">"..str.." <"..self.borderColor..">)"..right.."+\n")
	self:space()
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

function printer:bottom()
	self:space()
	cecho("<"..self.borderColor..">+"..string.rep("-", self.length).."+\n\n")
end

function printer:dumpArray(arr, firstColLength, header)
	if header then
		self:renderArrayRow(header[1], header[2], firstColLength, "orange")
		self:hr()
	end
	for k, v in pairs(arr) do
		if k ~= "Default Area" then
			self:renderArrayRow(k, v, firstColLength)
		end
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
	local leftLen = firstColLength-string.len(left)-self.tabLength
	local rightLen = self.length-firstColLength-1-self.tabLength-string.len(right)
	cecho(
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength)..
		"<"..textColor..">"..left..string.rep(" ", leftLen)..
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength)..
		"<"..textColor..">"..right..string.rep(" ", rightLen)..
		"<"..self.borderColor..">|\n"
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
	cecho(
		"<"..self.borderColor..">|"..string.rep(" ", self.tabLength)..
		"<"..color..">"..msg..string.rep(" ", len)..
		"<"..self.borderColor..">|\n"
	)
end
