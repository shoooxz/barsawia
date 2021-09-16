# barsawia
Skrypty i mapper do Barsawii (Mudlet)

Dostepne komendy:
/skrypty
/mapper
/opcje


Instalacja Szybka

Utworz nowy profil po czym wklej ponizsza linijke:

```
lua function install()local a=getMudletHomeDir()local b="https://api.github.com/repos/shoooxz/barsawia/releases/latest"local c=a.."/release.json"local d=a.."/barsawia/"local e="https://codeload.github.com/shoooxz/barsawia/zip/"local f=a.."/package.zip"local g=""lfs.chdir(a)registerAnonymousEventHandler("sysDownloadDone",function(h,i)if i~=c then return true end local j=io.open(c,"rb")if j then local k=yajl.to_value(j:read("*a"))j:close()os.remove(c)g=a.."/barsawia-"..k.name.."/"tempTimer(0.1,function()pcall(function(l)for m in lfs.dir(l)do local n=l..'/'..m if m~="."and m~=".."then if lfs.attributes(n,'mode')=='file'then os.remove(n)elseif lfs.attributes(n,'mode')=='directory'then deleteDir(n)end end end lfs.rmdir(l)end,d)registerAnonymousEventHandler("sysDownloadDone",function(h,i)if i~=f then return true end local o=function(p,...)if p=="sysUnzipDone"then os.remove(f)uninstallPackage("barsawia")uninstallPackage("generic_mapper")tempTimer(1,function()os.rename(g,d)os.remove(a.."/barsawia_mapa.dat")os.remove(a.."/Database_gps.db")os.remove(a.."/Database_npc.db")os.rename(d.."barsawia_mapa.dat",a.."/barsawia_mapa.dat")os.rename(d.."Database_gps.db",a.."/Database_gps.db")os.rename(d.."Database_npc.db",a.."/Database_npc.db")installPackage(d.."barsawia.trigger")cecho("\n<tomato> Barsawia skrypty zainstalowane poprawnie!\n")cecho("\n<tomato> Zresetuj polaczenie i zaloguj sie do gry aby utworzyc profil!\n")cecho("\n<tomato> /zaladuj_mape aby sie odnalezc /zlok!\n")end)elseif p=="sysUnzipError"then cecho("\n<tomato> Blad podczas unzipa!\n")end end registerAnonymousEventHandler("sysUnzipDone",o,true)registerAnonymousEventHandler("sysUnzipError",o,true)unzipAsync(f,a)end,true)cecho("\n<tomato> Pobieram paczke z github'a "..k.name.."\n")downloadFile(f,e..k.name)end)end end,true)downloadFile(c,b)end install()clearCmdLine()
```

Instalacja Reczna
1. Zakladamy profil w mudlecie.
2. Zakladamy katalog 'barsawia' w profilu. Katalog profilu mozna znalezc wpisujac w mudlecie
lua getMudletHomeDir() bedac aktualnie w swoim profilu.
3. Do katalogu 'barsawia' wrzucamy paczke z githuba
4. Wchodzimy do katalogu 'barsawia' i przenosimy barsawia_mapa.dat, Database_gps.db, Database_npc.db
jeden katalog wyzej (do glownego profilu)
5. W menu mudleta wybieramy Toolbox/Package Manager  > install i wybieramy plik barsawia.trigger  z katalogu
paczki 'barsawia' aby zainstalowac aliasy i triggery
