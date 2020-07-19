inventory = inventory or {}
inventory.bag = {}
inventory.bag.openWhat = {
    "plecak",
	"sakwe",
}
inventory.bag.getFrom = {
    "plecaka",
	"sakwy",
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

function inventory:moneyIn(ret)
	local cmd = "otworz "..self.bag.openWhat[profile:get("bag")]..";wloz monety do "..self.bag.getFrom[profile:get("bag")]
	if ret then return cmd end
	send(cmd)
end

function inventory:moneyOut(ret)
	local cmd = "otworz "..self.bag.openWhat[profile:get("bag")]..";wez monety z "..self.bag.getFrom[profile:get("bag")]
	if ret then return cmd end
	send(cmd)
end

function inventory:bagExists(id)
	return (self.bag.openWhat[id] and self.bag.getFrom[id])
end
