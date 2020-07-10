function mapper:helper()
	if self.drawing then
		-- porownaj wyjscia z gmcp z wyjsciami z mappera
		local diff = utils:arrayDiff(self.gmcp.exits, self:helperGetExitsForComparison())
		if next(diff) then
			tempTimer(0.5, function()
				printer:error("Mapper Pomocnik",
					"Nie zmapowano wyjsc: "..table.concat(diff, ", ")
				)
			end)
		end
	end
end

function mapper:helperGetExitsForComparison()
	local exits =  self.room.exits
	local special = getSpecialExitsSwap(self.room.id)
	local output = {}
	for k, v in pairs(exits) do
		table.insert(output, self.en2short[k])
	end
	for k, v in pairs(special) do
		table.insert(output, k)
	end
	return output
end
