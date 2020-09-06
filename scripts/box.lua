box = box or {}
box.header = nil
box.reading = false
box.rows = {}
box.header2from = {
	["lokalne"] = "z lokalnych",
	["pozostale"] = "z pozostalych",
	["zamorskie"] = "z zamorskich",
}
-- ?pobieranie  <zwroc>
function box:setHeader(match)
	deleteLine()
	self.header = match
end

function box:setLine(id, name, price)
	deleteLine()
	local header = string.lower(self.header)
	price = tonumber(utils:split(price, " ")[1])
	name = "["..price.." zl] "..utils:truncate(utils:trim(name), 53).." ("..header..")"
	table.insert(self.rows, {
		price,
		name,
		"pobierz paczke "..id.." "..self.header2from[header]
	})
end

function box:render()
	deleteLine()
	local out = {}
	table.sort(self.rows, function(a,b) return a[1] < b[1] end)
	for i=1, #self.rows do
		table.insert(out,
			{
				["label"] = self.rows[i][2],
				["command"] = "send(\""..self.rows[i][3].."\")",
				["tooltip"] = self.rows[i][3],
			}
		)
	end
	printer:box(out)
	self.rows = {}
	self.reading = false
end

function box:deleteLine()
	if self.reading then
		deleteLine()
	end
end

function box:capture()
	deleteLine()
	self.reading = true
end
