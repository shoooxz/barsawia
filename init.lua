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
        "scripts/core",
        "scripts/wood",
        "scripts/keybind/callback",
        "scripts/keybind/core",
        "scripts/keybind/trigger",
        "scripts/profile",
        "scripts/inventory/core",
        "scripts/inventory/filter",
        "scripts/inventory/rating",
        "scripts/character/core",
        "scripts/character/tables",
        "mapper/core",
        "mapper/area",
        "mapper/helper",
        "mapper/move",
        "mapper/draw",
        "mapper/events",
        "mapper/bind",
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
end
loadObjects(false)
