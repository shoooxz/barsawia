function install()
	local dir = getMudletHomeDir()
	local release_src = "https://api.github.com/repos/shoooxz/barsawia/releases/latest"
	local release_dst = dir.."/release.json"
	local scripts_dst = dir.."/barsawia/"
	local package_src = "https://codeload.github.com/shoooxz/barsawia/zip/"
	local package_dst = dir.."/package.zip"
	local package_name = ""
	lfs.chdir(dir)
	-- download latest
	registerAnonymousEventHandler(
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
				package_name = dir.."/barsawia-"..obj.name.."/"
				tempTimer(0.1, function()
					-- usun stary katalog skryptow
					pcall(
						function(n)
							for j in lfs.dir(n)do
								local o=n..'/'..j
								if j~="."and j~=".."then
									if lfs.attributes(o,'mode')=='file'then
										os.remove(o)
									elseif lfs.attributes(o,'mode')=='directory'then
										deleteDir(o)
									end
								end
							end
							lfs.rmdir(n)
						end,
						scripts_dst
					)
					-- download package
					registerAnonymousEventHandler(
						"sysDownloadDone",
						function(_, filename)
							if filename ~= package_dst then
								return true
							end
							local unzip = function(res, ...)
								if res == "sysUnzipDone" then
									os.remove(package_dst)
									uninstallPackage("barsawia")
									uninstallPackage("generic_mapper")
									tempTimer(1,function()
										os.rename(package_name, scripts_dst)
										os.remove(dir.."/barsawia_mapa.dat")
										os.remove(dir.."/Database_gps.db")
										os.remove(dir.."/Database_npc.db")
										os.rename(scripts_dst.."barsawia_mapa.dat", dir.."/barsawia_mapa.dat")
										os.rename(scripts_dst.."Database_gps.db", dir.."/Database_gps.db")
										os.rename(scripts_dst.."Database_npc.db", dir.."/Database_npc.db")
										installPackage(scripts_dst.."barsawia.trigger")
										cecho("\n<tomato> Barsawia skrypty zainstalowane poprawnie!\n")
										cecho("\n<tomato> Zresetuj polaczenie i zaloguj sie do gry aby utworzyc profil!\n")
										cecho("\n<tomato> /zaladuj_mape aby sie odnalezc /zlok!\n")
									end)
								elseif res == "sysUnzipError" then
									cecho("\n<tomato> Blad podczas unzipa!\n")
								end
							end
							registerAnonymousEventHandler("sysUnzipDone", unzip, true)
							registerAnonymousEventHandler("sysUnzipError", unzip, true)
							unzipAsync(package_dst, dir)
						end,
						true
					)
					cecho("\n<tomato> Pobieram paczke z github'a "..obj.name.."\n")
					downloadFile(package_dst, package_src..obj.name)
				end)
			end
		end,
		true
	)
	downloadFile(release_dst, release_src)
end
install()
clearCmdLine()
