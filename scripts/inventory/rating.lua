inventory.rating = inventory.rating or {}
inventory.rating.armorLevels = {
    ["zle"] = 1,
    ["mizernie"] = 2,
    ["niespecjalnie"] = 3,
    ["przecietnie"] = 4,
    ["dosc dobrze"] = 5,
    ["dobrze"] = 6,
    ["bardzo dobrze"] = 7,
    ["perfekcyjnie"] = 8,
    ["genialnie"] = 9,
    ["fantastycznie"] = 10,
}
inventory.rating.effPatterns = {
	["calkowicie nieskuteczna?y?e?"] = 1,
	["malo skuteczna?y?e?"] = 2,
	["niespecjalnie skuteczna?y?e?"] = 3,
	["przecietnie skuteczna?y?e?"] = 4,
	["dosc skuteczna?y?e?"] = 5,
	["skuteczna?y?e?"] = 6,
	["wyjatkowo skuteczna?y?e?"] = 7,
	["nadzwyczaj skuteczna?y?e?"] = 8,
	["fantastycznie skuteczna?y?e?"] = 9,
	["niespotykanie skuteczna?y?e?"] = 10,
}
inventory.rating.balancePatterns = {
	["zle wywazona?y?e?"] = 1,
	["mizernie wywazona?y?e?"] = 2,
	["niespecjalnie wywazona?y?e?"] = 3,
	["przecietnie wywazona?y?e?"] = 4,
	["dosc dobrze wywazona?y?e?"] = 5,
	["dobrze wywazona?y?e?"] = 6,
	["bardzo dobrze wywazona?y?e?"] = 7,
	["perfekcyjnie wywazona?y?e?"] = 8,
	["genialnie wywazona?y?e?"] = 9,
	["fantastycznie wywazona?y?e?"] = 10,
}
inventory.rating.parts = nil
inventory.rating.weight = nil
inventory.rating.wounds = nil
inventory.rating.grip = nil

function inventory.rating:getWeaponEff(str)
	for pattern, level in pairs(self.effPatterns) do
		if string.match(str, pattern) then
			return level
		end
	end
end

function inventory.rating:getWeaponBalance(str)
	for pattern, level in pairs(self.balancePatterns) do
		if string.match(str, pattern) then
			return level
		end
	end
end

function inventory.rating:captureBow(e, size)
	deleteLine()
    local eff = self:getWeaponEff(e)
    printer:rating({
        {
            "Atak",
            e.." ["..eff.."/10]"
        },
        {
            "Rozmiar",
            size
        },
        {
            "Waga",
            self.weight.." gramow"
        },
    }, eff.."/10", true)
end

function inventory.rating:captureGloves(str)
	deleteLine()
    local eff = self:getWeaponEff(str)
    printer:rating({
        {
            "Chwyt",
            str.." ["..eff.."/10]"
        },
        {
            "Waga",
            self.weight.." gramow"
        },
    }, eff.."/10")
end

function inventory.rating:captureWounds(str)
	deleteLine()
	self.wounds = str
end

function inventory.rating:captureGrip(str)
	deleteLine()
	self.grip = str
end

function inventory.rating:captureWeapon(e, b)
	deleteLine()
	local eff = self:getWeaponEff(e)
	local bal = self:getWeaponBalance(b)
	printer:rating({
		{
			"Atak",
			e.." ["..eff.."/10]"
		},
		{
			"Balans",
			b.." ["..bal.."/10]"
		},
		{
			"Chwyt",
			self.grip
		},
		{
			"Rany",
			self.wounds
		},
		{
			"Waga",
			self.weight.." gramow"
		},
	}, (eff+bal).."/20", true)
end

function inventory.rating:captureShield(str)
	deleteLine()
	local eff = self:getWeaponEff(str)
	printer:rating({
		{
			"Obrona",
			str.." ["..eff.."/10]"
		},
		{
			"Waga",
			self.weight.." gramow"
		},
	}, eff.."/10")
end

function inventory.rating:captureWeight(weight)
	--deleteLine()
	self.weight =  weight
end

function inventory.rating:captureBodyParts(parts)
	deleteLine()
	self.parts =  parts
end

function inventory.rating:captureArmor(stab, slash, blunt)
    deleteLine()
    printer:rating({
		{
			"Chroni",
			self.parts
		},
		{
			"Waga",
			self.weight.." gramow"
		},
        {
            "Klute",
            stab.." ["..self.armorLevels[stab].."/10]"
        },
        {
            "Ciete",
            slash.." ["..self.armorLevels[slash].."/10]"
        },
        {
            "Obuchowe",
            blunt.." ["..self.armorLevels[blunt].."/10]"
        }
    }, (self.armorLevels[stab]+self.armorLevels[slash]+self.armorLevels[blunt]).."/30")
end
