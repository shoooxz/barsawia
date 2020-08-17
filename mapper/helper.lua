function mapper:helper()
	local isLiaj = self:isLiajLocation()
	if self.drawing or isLiaj then
		-- porownaj wyjscia z gmcp z wyjsciami z mappera
		if isLiaj then
			self:centerGMCP()
		end
		local diff = utils:arrayDiff(self.gmcp.exits, self:helperGetExitsForComparison())
		if next(diff) then
			if isLiaj  then
				self:connectAutoViaDir(diff)
			else
				tempTimer(0.5, function()
					printer:error("Mapper Pomocnik",
						"Nie zmapowano wyjsc: "..table.concat(diff, ", ")
					)
				end)
			end
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
