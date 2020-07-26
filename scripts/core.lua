scripts = scripts or {}

function scripts:init()
	if mudletOlderThan(4, 8) then
		printer:error("Stara wersja mudleta",
			{
			  "Zaktualizuj Mudlet!",
			  "Wymagana wersja Mudleta 4.8+"
			}
		)
	end
	settings:init()
	setMainWindowSize(settings:get("mainWindowWidth"), settings:get("mainWindowHeight"))
end

function scripts:loaded()
	send('opcje szerokosc 0', false)
end

function scripts:beep()
	playSoundFile(getMudletHomeDir().. [[/barsawia/beep.wav]])
end

scripts:init()
