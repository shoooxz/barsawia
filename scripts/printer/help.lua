function printer:help()
    self:title("Barsawia Pomoc")
    self:command("/opcje", "Ustawienia ui, mappera i skryptow")
    self:info("Ustawienia sa zapisane do pliku settings.lua w twoim katalogu profilu")
    self:command("/mapper", "Komendy do mappera")
    self:command("/skrypty", "Dostepne skrypty")
    self:bottom()
end

function printer:settings()
    self:title("Barsawia Ustawienia")
    self:command("/opcje szerokosc "..settings:get("mainWindowWidth"), "Szerokosc glownego okna w Mudlecie")
    self:command("/opcje wysokosc "..settings:get("mainWindowHeight"), "Wysokosc glownego okna w Mudlecie")
    self:command("/opcje mapper_szerokosc "..settings:get("mapperWidth"), "Szerokosc okna mappera")
    self:command("/opcje pojemnik "..profile:get("bag"), "Pojemnik na monety")
    self:dumpArray({{1, "plecak"}, {2, "sakwa"}, {3, "torba"}}, 4, nil, self.infoColor)
    self:command("/opcje chodzik "..profile:get("bag"), "Opoznienie chodzika 1-5")
    self:command("/opcje filtr_bron "..utils:concat(profile:get("filter_weapon"), ","), "Pokazuje w kufrze tylko konkretny rodzaj broni")
    self:info("Mozesz laczyc bronie z ',' np /opcje filtr_bron 6,1,2 pokaze w kufrze")
    self:info("jako ostanie drzewce, miecze i topory (zachowana kolejnosc)")
    self:dumpArray({{0, "wszystko"}, {1, "miecze"}, {2, "topory"}, {3, "sztylety"}, {4, "mloty"}, {5, "maczugi"}, {6, "drzewce"}, {7, "luki"}}, 4, nil, self.infoColor)
    self:bottom()
end

function printer:scripts()
    self:title("Barsawia Skrypty")
    self:command("/zetnij_drzewo", "Sciecie drzewa")
    self:command("/ociosaj_drzewo", "Ociosanie drzewa")
    self:command("/zap", "Zapal lampe")
    self:info("Do zapalenia lampy potrzebne sa 2 krzemienie i olej")
    self:command("/medytuj", "Medytuj w gildii podroznikow, zapisz stan cech")
    self:info("Przy kazdym uzyciu medytuj progres cech jest zapisywany w profilu")
    self:info("oraz widoczny po wpisaniu komendy 'cechy'")
    self:command("/npc", "Szukaj NPC w bazie")
    self:bottom()
end

function printer:binds()
    self:title("Barsawia Bindy")
    self:command("/bind (komendy)", "Dodanie binda do aktualnej lokacji")
    self:info("Komendy powinny byc oddzielone hashem '#'")
    self:info("np. napij sie wody z fontanny#usmiechnij sie")
    self:info("Bind uaktywni na lokacji informcje o wcisnieciu klawisza")
    self:command("/usun_bindy", "Usuniecie z aktualnej lokacji binda")
    self:bottom()
end

function printer:mapper()
    self:title("Barsawia Mapper")
    self:section("Obszary:")
    self:command("/obszary", "Dostepny obszary oraz ich ID")
    self:command("/dodaj_obszar (nazwa)", "Dodanie nowego obszaru oraz lokacji startowej")
    self:info("(Uwaga! Lokacja startowa utworzy sie za pomoca GMCP w miejscu, w ktorym")
    self:info("aktualnie sie znajdujesz)")
    self:command("/nazwij_obszar (id) (nazwa)", "Nowa nazwa dla obszaru z id")
    self:command("/usun_obszar (nazwa/id)", "Usun obszar")
    self:space()
    self:section("Aktualna lokacja:")
    self:command("/lok", "Informacje o aktualnej lokacji")
    self:command("/zlok", "Wycentruj mape do aktualnej lokacji z GMCP")
    self:space()
    self:section("Mapa:")
    self:command("/zaladuj_mape", "Zaladuj mape")
    self:info("(Uwaga! Okienko mappera musi byc wlaczone, inaczej komenda nie zadziala)")
    self:command("/zapisz_mape", "Zapisz aktualna wersje mapy")
    self:space()
    self:section("Mapowanie:")
    self:command("/mapper_start", "Wlacz mapper i pomocnik")
    self:command("/mapper_stop", "Wylacz mapper i pomocnik")
    self:command("/mode (id)", "Tryb mappera")
    self:info("1 - normalny")
    self:info("2 - lacz lokacje obustronnie (Trakty)")
    self:info("3 - tworz lokacje bez gmcp")
    self:info("4 - lacz lokacje przez gmcp (Laki)")
    self:command("/step (n)", "Odstep pomiedzy dwoma lokacjami, domyslnie 2")
    self:command("/dol (kierunek)", "Stworz lokacje i przejscie na dol w danym kierunku")
    self:command("/gora (kierunek)", "Stworz lokacje i przejscie na gore w danym kierunku")
    self:info("(Dostepne kierunki n w s e nw ne sw se")
    self:info("Mapper w przypadku tych komend tworzy odrazu przejscie odwrotne)")
    self:command("/spe (kierunek) (komenda)", "Specjalne przejscie w danym kierunku")
    self:info("(Dostepne kierunki n w s e nw ne sw se u d")
    self:info("W przypadku braku lokacji w danym kierunku - lokacja zostanie utworzona")
    self:info("Przyklad /spe e poczta /spe n bank)")
    self:command("/c (kolor)", "Kolory: poi, chata, las, gory, droga, woda, agro")
    self:command("/linia (kierunek)", "Polacz przerywana linia z najblizsza lokacja w kierunku")
    self:command("/label (kierunek) (text)", "Etykieta w tym kierunku")
    self:command("/lokacja (kierunek) (id)", "Stworz lokacje w tym kierunku z tym id")
    self:command("/bindy", "Komendy dla bindow do mapy")
    self:command("/polacz (kierunek)", "Polacz obecna lokacje z lokacja w kierunku")
    self:command("/poi (kierunek)", "Dodaj specjalne przejscie z `wyjscie` i kolorem poi")
    self:bottom()
end

function printer:roomInfo(arr)
    self:title("Aktualna lokacja")
    self:dumpArray(arr, 20, {"Nazwa", "Wartosc"})
    self:bottom()
end

function printer:areas(arr)
    self:title("Lista obszarow")
    if utils:objectLength(arr) > 0 then
        self:dumpArray(arr, 4, {"ID", "Nazwa"})
    else
        self:errorLine("Brak obszarow")
    end
    self:bottom()
end

function printer:filter(sort, arr)
    self:title("Kuferek")
    for _, type in pairs(sort) do
        self:dumpArray(arr[type], 4, {type, nil})
        self:space()
    end
    self:line("Komenda /opcje filtr_bron pozwala na filtrowanie broni", self.sectionColor)
    self:bottom(true)
end

function printer:stats(improve, arr, line, info)
    self:title(improve)
    self:dumpArray(arr, 7, {"Cechy", nil})
    self:space()
    if info then
        self:line(info, self.infoColor)
    else
        self:line(line, self.sectionColor)
    end
    self:bottom(false, true)
end

function printer:rating(arr, sum, nomargin)
    self:title(sum, true, nomargin)
    self:dumpArray(arr, 11, {"Typ", "Ocena"})
    self:bottom(true)
end

-- Srodziemie
-- Bree
-- karczma
-- srodek bree tajemniczy
-- pracownik na poczcie listy

-- Ustrekt
-- Kratas
-- ork z kratas - kapitan > rybak > magazyn > karczma > stajenny > krawiec > skup skor > krawiec > stajenny > karczma > o nagrode kapitana
-- Dorath
-- zielarz - skore triplikatna, pudelko do miecznik vivane
-- wiesniak - przeszukaj siano, wloz slome do otworu, zakrec korba, nakarm kury
-- Vivane
-- gubernator - straznik na polnocnym murze,
-- swiatynia - lustro - 'dziecko' w miescie - mury n przeszukaj kosze - klej kelevine masc -
-- urzednik w ratuszu n - papier kratas sklep, ciastko cukiernia s + sol 
-- szewc -
-- poczta - Velrond, Kratas (/npc Velrond)
-- Jerris
-- Laboratorium konstruktora - o maszyne/podroz
