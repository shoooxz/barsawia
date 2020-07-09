function loadObjects()
    local obj = {
        "scripts/printer/core",
        "scripts/printer/help",
        "scripts/printer/notice",
        "scripts/utils",
        "scripts/settings",
        "scripts/core",
        "mapper/core",
        "mapper/area",
        "mapper/helper",
        "mapper/move",
        "mapper/draw",
        "mapper/events",
    }
    for i = 1, #obj do
        package.loaded[obj[i]] = nil
        require(obj[i])
    end
    printer:success("Skrypty Barsawii", "Zaladowane!")
end
function reloadObjects()
    package.loaded.init = nil
    require("init")
    loadObjects()
end
loadObjects()
