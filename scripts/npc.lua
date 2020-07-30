npc = npc or {}
npc.db = db:create("npc", {
    npc = {
        name = "",
        room = 0,
        _index = { "name" },
		_violations = "IGNORE",
    }
})

function npc:search(name)
    local res = db:fetch(self.db.npc, {db:like(self.db.npc.name, "%"..name.."%")})
    -- TODO polaczyc z walkerem kordelem walkerem
    display(res)
    gotoRoom(res[1].room)
end

function npc:auto(name)
    if self:exists(name, mapper.room.id) then
        --printer:one("NPC",  utils:truncate(name, 40).." jest juz polaczony z "..mapper.room.id)
    else
        printer:one("NPC",  utils:truncate(name, 40).." polaczony z lokacja "..mapper.room.id)
        db:add(self.db.npc, {name = name, room = mapper.room.id})
    end
end

function npc:exists(name, room)
    return next(db:fetch(self.db.npc, {db:eq(self.db.npc.name, name), db:eq(self.db.npc.room, room)}))
end
