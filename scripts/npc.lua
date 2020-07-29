npc = npc or {}
npc.db = db:create("npc", {
    npc = {
        name = "",
        room = 0,
        _index = { "name" },
		_unique = { "name" },
		_violations = "IGNORE",
    }
})

function npc:auto(name)
	db:add(self.db.npc, { name = name, room = mapper.room.id })
end
