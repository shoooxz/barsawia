loaded = loaded or false
function loadObjects(force)
    if not force and loaded then
        return
    end
    local obj = {
        "scripts/printer/core",
        "scripts/printer/help",
        "scripts/printer/notice",
        "scripts/utils",
        "scripts/settings",
        "scripts/footer",
        "scripts/mode",
        "scripts/core",
        "scripts/wood",
        "scripts/keybind/callback",
        "scripts/keybind/core",
        "scripts/keybind/trigger",
        "scripts/profile",
        "scripts/inventory/core",
        "scripts/inventory/filter",
        "scripts/inventory/rating",
        "scripts/inventory/repair",
        "scripts/character/core",
        "scripts/character/tables",
        "scripts/bow",
        "scripts/npc",
        "scripts/gag",
        "scripts/box",
        "scripts/miner",
        "scripts/updater",
        "mapper/core",
        "mapper/liaj",
        "mapper/area",
        "mapper/helper",
        "mapper/move",
        "mapper/draw",
        "mapper/events",
        "mapper/bind",
        "mapper/walker",
        "mapper/gps",
    }
    for i = 1, #obj do
        package.loaded[obj[i]] = nil
        require(obj[i])
    end
    loaded = true
    printer:success("Skrypty Barsawii", "Zaladowane!")
end
function reloadObjects()
    package.loaded.init = nil
    require("init")
    loadObjects(true)
    profile:loadLast()
    mapper:centerGMCP()
    local updateFooter = footer:gmcpCharState()
    updateFooter()
end
loadObjects(false)
