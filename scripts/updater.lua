updater = updater or {}
updater.version = nil

function updater:checkVersion()
  local dir = getMudletHomeDir()
  local release_src = "https://api.github.com/repos/shoooxz/barsawia/releases/latest"
  local release_dst = dir.."/release.json"
  local downloadHandler, errorHandler = nil
  lfs.chdir(dir)
  if downloadHandler then killAnonymousEventHandler(downloadHandler) end
  downloadHandler = registerAnonymousEventHandler(
    "sysDownloadDone",
    function(_, filename)
      if filename ~= release_dst then
        return true
      end
      local file = io.open(release_dst, "rb")
      if file then
        -- pobierz z latest name
        local obj = yajl.to_value(file:read("*a"))
        file:close()
        os.remove(release_dst)
        updater.version = obj.name
        if updater:updateIsAvailable() then
          printer:updater(obj.name)
        end
      end
    end,
    true
  )
  if errordHandler then killAnonymousEventHandler(errorHandler) end
  errorHandler = registerAnonymousEventHandler(
    "sysDownloadError",
    function(_, error)
      printer:error("Aktualizacja", "Problem z polaczeniem z githubem.")
    end,
    true
  )
  tempTimer(1, function ()
    downloadFile(release_dst, release_src)
  end)
end

function updater:updateIsAvailable()
    if scripts.version == self.version then return false end
    local current = utils:split(scripts.version, "\\.")
    local repository = utils:split(self.version, "\\.")
    for i = 1, math.max(table.size(current), table.size(repository)) do
      if tonumber(current[i] or "0") > tonumber(repository[i] or "0") then
        return false
      elseif tonumber(current[i] or "0") < tonumber(repository[i] or "0") then
        return true
      end
    end
    return false
end

function updater:update(map)
  if self:updateIsAvailable() then
    local dir = getMudletHomeDir()
    local scripts_dst = dir.."/barsawia/"
    local package_src = "https://codeload.github.com/shoooxz/barsawia/zip/"
    local package_dst = dir.."/package.zip"
    local downloadHandler, errorHandler, unzipDoneHandler, unzipErrorHandler = nil
    if downloadHandler then killAnonymousEventHandler(downloadHandler) end
    downloadHandler = registerAnonymousEventHandler(
      "sysDownloadDone",
      function(_, filename)
        if filename ~= package_dst then
          return true
        end
        local unzip = function(res, ...)
          if res == "sysUnzipDone" then
            utils:deleteDir(scripts_dst)
            os.remove(package_dst)
            uninstallPackage("barsawia")
            uninstallPackage("generic_mapper")
            os.rename(dir.."/barsawia-"..updater.version.."/", scripts_dst) -- zmien sciagnieta paczke na docelowa nazwe
            if map then
              os.remove(dir.."/barsawia_mapa.dat")
              os.rename(scripts_dst.."barsawia_mapa.dat", dir.."/barsawia_mapa.dat")
            end
            ---os.remove(dir.."/Database_gps.db")
            ---os.remove(dir.."/Database_npc.db")
            ---os.rename(scripts_dst.."Database_gps.db", dir.."/Database_gps.db")
            --os.rename(scripts_dst.."Database_npc.db", dir.."/Database_npc.db")
            installPackage(scripts_dst.."barsawia.trigger")
            printer:success("Aktualizacja", "Barsawia skrypty zaktualizowane poprawnie!")
          elseif res == "sysUnzipError" then
            printer:error("Aktualizacja", "Blad podczas unzipa!")
          end
        end
        if unzipDoneHandler then killAnonymousEventHandler(unzipDoneHandler) end
        unzipDoneHandler = registerAnonymousEventHandler("sysUnzipDone", unzip, true)
        if unzipErrorHandler then killAnonymousEventHandler(unzipErrorHandler) end
        unzipErrorHandler = registerAnonymousEventHandler("sysUnzipError", unzip, true)
        unzipAsync(package_dst, dir)
      end,
      true
    )
    if errordHandler then killAnonymousEventHandler(errorHandler) end
    errorHandler = registerAnonymousEventHandler(
      "sysDownloadError",
      function(_, error)
        printer:error("Aktualizacja", error)
      end,
      true
    )
    downloadFile(package_dst, package_src..updater.version)
  end
end
