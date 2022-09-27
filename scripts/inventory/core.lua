inventory = inventory or {}
inventory.bag = {}
inventory.case = {}
inventory.weapon = {
    "miecz",
    "topor",
    "sztylet",
    "mlot",
    "maczuge",
    "bron drzewcowa",
}
inventory.wieldWhat = {
    "miecza",
    "topora",
    "sztyletu",
    "mlota",
    "maczugi",
    "broni drzewcowej",
}
inventory.bag.openWhat = {
    "plecak",
	"sakwe",
    "torbe",
	"sakiewke",
}
inventory.bag.getFrom = {
    "plecaka",
	"sakwy",
    "torby",
	"sakiewki",
}
inventory.case.put = {
    "wloz %s do pokrowca",
    "wloz %s do drugiego pokrowca",
    "otworz %s;wloz tarcze do %s",
}
inventory.case.get = {
    "dobadz %s z pokrowca",
    "dobadz %s z drugiego pokrowca",
    "otworz %s;wez tarcze z %s;zaloz tarcze",
}
inventory.count2short = {
    ["dwa"] = 2,
    ["dwie"] = 2,
    ["dwoje"] = 2,
    ["trzy"] = 3,
    ["troje"] = 3,
    ["cztery"] = 4,
    ["czworo"] = 4,
    ["piec"] = 5,
    ["szesc"] = 6,
    ["siedem"] = 7,
    ["osiem"] = 8,
    ["dziewiec"] = 9,
    ["dziesiec"] = 10,
    ["jedenascie"] = 11,
    ["dwanascie"] = 12,
    ["trzynascie"] = 13,
    ["czternascie"] = 14,
    ["pietnascie"] = 15,
    ["szesnascie"] = 16,
    ["siedemnascie"] = 17,
    ["osiemnascie"] = 18,
    ["dziewietnascie"] = 19,
    ["dwadziescia"] = 20,
    ["dwadziescia jeden"] = 21,
    ["dwadziescia dwa"] = 22,
    ["dwadziescia trzy"] = 23,
    ["dwadziescia cztery"] = 24,
    ["dwadziescia piec"] = 25,
    ["dwadziescia szesc"] = 26,
    ["dwadziescia siedem"] = 27,
    ["dwadziescia osiem"] = 28,
    ["dwadziescia dziewiec"] = 29,
    ["trzydziesci"] = 30,
    ["trzydziesci jeden"] = 31,
    ["trzydziesci dwa"] = 32,
    ["trzydziesci trzy"] = 33,
    ["trzydziesci cztery"] = 34,
    ["trzydziesci piec"] = 35,
    ["trzydziesci szesc"] = 36,
    ["trzydziesci siedem"] = 37,
    ["trzydziesci osiem"] = 38,
    ["trzydziesci dziewiec"] = 39,
    ["czterdziesci"] = 40,
}

function inventory:unique()
-- Barbarzynska mityczna tunika kolcza
end

function inventory:moneyPut(ret)
	local cmd = "otworz "..self.bag.openWhat[profile:get("bag")]..";wloz monety do "..self.bag.getFrom[profile:get("bag")]..";zamknij "..self.bag.openWhat[profile:get("bag")]
	if ret then return cmd end
	send(cmd)
end

function inventory:moneyGet(ret)
	local cmd = "otworz "..self.bag.openWhat[profile:get("bag")]..";wez monety z "..self.bag.getFrom[profile:get("bag")]
	if ret then return cmd end
	send(cmd)
end

function inventory:getWeaponsFromProfile(type)
    local weapon = inventory.weapon[profile:get("weapon")]
    if type == "get" then
        weapon = inventory.wieldWhat[profile:get("weapon")]
    end
    return {
        string.format(self.case[type][1], weapon),
        string.format(self.case[type][2], weapon),
        string.format(self.case[type][3], inventory.bag.openWhat[profile:get("bag")], inventory.bag.getFrom[profile:get("bag")]),
    }
end

function inventory:weaponPut(ret)
    local arr = self:getWeaponsFromProfile("put")
    local cmd = ""
    local style = profile:get("style")
    for i=1, style do
        if i == 2 and style == 3 then else -- jesli tarcza, pomin opuszczanie drugiej broni
            cmd = cmd .. arr[i] .. ";"
        end
    end
	if ret then return cmd end
	send(cmd)
end

function inventory:weaponGet(ret)
    local arr = self:getWeaponsFromProfile("get")
    local cmd = ""
    local style = profile:get("style")
    for i=1, style do
        if i == 2 and style == 3 then else -- jesli tarcza, pomin dobywanie drugiej broni
            cmd = cmd .. arr[i] .. ";"
        end
    end
	if ret then return cmd end
	send(cmd)
end

function inventory:deposit(what)
    send("otworz "..what.."; ob "..what)
end

function inventory:bagExists(id)
	return (self.bag.openWhat[id] and self.bag.getFrom[id])
end

function inventory:styleExists(id)
	return (self.case.put[id])
end

function inventory:weaponExists(id)
	return (self.weapon[id])
end
