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
