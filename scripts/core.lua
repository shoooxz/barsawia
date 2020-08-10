scripts = scripts or {}
scripts.events = scripts.events or {}

function scripts:init()
	if mudletOlderThan(4, 8) then
		printer:error("Stara wersja mudleta",
			{
			  "Zaktualizuj Mudlet!",
			  "Wymagana wersja Mudleta 4.8+"
			}
		)
	end
	self:unbindEvents()
	settings:init()
	footer:init()
	mode:init()
	setMainWindowSize(settings:get("mainWindowWidth"), settings:get("mainWindowHeight"))
end

function scripts:loaded()
	send('opcje szerokosc 0', false)
end

function scripts:dead()
	send("ob cialo")
end

function scripts:beep()
	playSoundFile(getMudletHomeDir().. [[/barsawia/beep.wav]])
end

function scripts:unbindEvents()
	for name, id in pairs(self.events) do
		if id then
			killAnonymousEventHandler(id)
		end
	end
end

scripts:init()
