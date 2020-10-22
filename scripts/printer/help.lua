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
    self:command("/opcje tryb "..profile:get("mode"), "Wlacz tryb przy ladowaniu profilu")
    self:dumpArray({{0, "brak"}, {1, "lucznik"}, {2, "drwal"}, {3, "gornik"}}, 4, nil, self.infoColor)
    self:command("/opcje gornik "..profile:get("miner"), "Narzedzie gornika do badania scian")
    self:dumpArray({{1, "oskardzik"}, {2, "czekanik"}}, 4, nil, self.infoColor)
    self:command("/opcje pojemnik "..profile:get("bag"), "Pojemnik na monety")
    self:dumpArray({{1, "plecak"}, {2, "sakwa"}, {3, "torba"}}, 4, nil, self.infoColor)
    self:command("/opcje styl "..profile:get("style"), "Uzyte m.in. przy dobywaniu i opuszczaniu broni")
    self:dumpArray({{1, "bron dwureczna"}, {2, "dwie bronie jednoreczne"}, {3, "bron jednoreczna i tarcza"}}, 4, nil, self.infoColor)
    self:command("/opcje bron "..utils:concat(profile:get("weapon"), ","), "Uzyte m.in. przy dobywaniu i opuszczaniu broni")
    self:dumpArray({{1, "miecze"}, {2, "topory"}, {3, "sztylety"}, {4, "mloty"}, {5, "maczugi"}, {6, "drzewce"}}, 4, nil, self.infoColor)
    self:command("/opcje chodzik "..profile:get("bag"), "Opoznienie chodzika 1-5") -- TODO
    self:command("/opcje filtr_bron "..utils:concat(profile:get("filter_weapon"), ","), "Pokazuje w kufrze tylko konkretny rodzaj broni")
    self:info("Mozesz laczyc bronie z ',' np /opcje filtr_bron 6,1,2 pokaze w kufrze")
    self:info("jako ostanie drzewce, miecze i topory (zachowana kolejnosc)")
    self:dumpArray({{0, "wszystko"}, {1, "miecze"}, {2, "topory"}, {3, "sztylety"}, {4, "mloty"}, {5, "maczugi"}, {6, "drzewce"}, {7, "luki"}}, 4, nil, self.infoColor)
    self:bottom()
end

function printer:scripts()
    self:title("Barsawia Skrypty")
    self:command("/liaj_wyczysc", "Wyczysc mape Liaj (zmienia sie co apokalipse)")
    self:info("W przypadku poruszania sie na terenie puszczy Liaj wyjscia")
    self:info("generowane sa automatycznie")
    self:command("/aliasy", "Szybkie aliasy bez slash'a")
    self:command("/zap", "Zapal lampe")
    self:info("Do zapalenia lampy potrzebne sa 2 krzemienie i olej")
    self:command("/medytuj", "Medytuj w gildii podroznikow, zapisz stan cech")
    self:info("Przy kazdym uzyciu medytuj progres cech jest zapisywany w profilu")
    self:info("oraz widoczny po wpisaniu komendy 'cechy'")
    self:command("/napraw", "Napraw bron i zbroje")
    self:space()
    self:section("GPS:")
    self:command("/npc (imie)", "Kieruj sie w strone NPC")
    self:info("Wyszukiwanie dziala na bazie skrotow np: /npc barli /npc elro")
    self:command("/gps", "Lista dostepnych lokacji w GPS dla domeny")
    self:command("/gps (nazwa)", "Kieruj sie w strone lokacji z GPS")
    self:info("Wyszukiwanie dziala na bazie skrotow np: /gps ered /gps mith")
    self:command("/gps_dodaj (nazwa)", "Dodaj aktualna lokacje do bazy GPS")
    self:space()
    self:section("Tryby:")
    self:command("/lucznik", "Opis trybu lucznika")
    self:command("/drwal", "Opis trybu drwala")
    self:command("/gornik", "Opis trybu gornika")
    self:bottom()
end

function printer:bowHelp()
    self:title("Barsawia Lucznik")
    self:info("Lucznik to jeden z trybow dostepny w skryptach. Mozna go wlaczyc")
    self:info("przez szybkie menu oraz ustawic w /opcje aby aktywowal sie na starcie.")
    self:info("W momencie gdy tryb jest aktywny kombinacja klawiszy CTRL + (kierunek)")
    self:info("pozwala na oddanie strzalu w danym kierunku.")
    self:info("'/' na klawiaturze numerycznej wyrywa strzaly ze wszystkich cial")
    self:info("natomiast 'NUM5' zmienia bronie.")
    self:space()
    self:command("/celuj w (cel)", "Ustaw cel")
    self:bottom()
end

function printer:woodHelp()
    self:title("Barsawia Drwal")
    self:info("Drwal to jeden z trybow dostepny w skryptach. Mozna go wlaczyc")
    self:info("przez szybkie menu oraz ustawic w /opcje aby aktywowal sie na starcie.")
    self:info("W momencie gdy tryb jest aktywny '/' na klawiaturze numerycznej")
    self:info("zmienia bronie natomiast 'NUM5' scina drzewa po kolei.")
    self:bottom()
end

function printer:minerHelp()
    self:title("Barsawia Gornik")
    self:section("Podstawowe wyposazenie to oskardzik i kilof z Ered Luin")
    self:info("Gornik to jeden z trybow dostepny w skryptach. Mozna go wlaczyc")
    self:info("przez szybkie menu oraz ustawic w /opcje aby aktywowal sie na starcie.")
    self:info("W momencie gdy tryb jest aktywny kombinacja klawiszy CTRL + (kierunek)")
    self:info("pozwala na kopanie w danym kierunku.")
    self:info("'/' podnosi mineraly")
    self:info("CTRL + 4 napelnia lampe olejem")
    self:bottom()
end

function printer:binds()
    self:title("Barsawia Bindy")
    self:command("/bind (komendy)", "Dodanie binda do aktualnej lokacji")
    self:info("Komendy powinny byc oddzielone hashem '#'")
    self:info("np. napij sie wody z fontanny#usmiechnij sie")
    self:info("Bind uaktywni na lokacji informcje o wcisnieciu klawisza")
    self:command("/paczki", "Dodaj na lokacji bind paczkarza 'przeczytaj plakat'")
    self:command("/schowek", "Popros o wydanie schowka na lokacji")
    self:command("/usun_bindy", "Usuniecie z aktualnej lokacji binda")
    self:bottom()
end

function printer:aliases()
    self:title("Barsawia Aliasy")
    self:command("do", "dobadz bron z pokrowca")
    self:command("op", "opusc bron do pokrowca")
    self:command("wem", "wez monety z kontenera")
    self:command("wlm", "wloz monety do kontenera")
    self:info("/opcje aby ustalic styl walki i kontenery")
    self:bottom()
end

function printer:mapper()
    self:title("Barsawia Mapper")
    self:section("Obszary:")
    self:command("/obszary", "Dostepny obszary oraz ich ID")
    self:command("/dodaj_obszar (nazwa)", "Dodanie nowego obszaru oraz lokacji startowej")
    self:info("(Prawczy przycisk myszy na lokacji > Area - aby dodac lokacje do nowego obszaru)")
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
    self:info("(Id 0 wygeneruje losowy numer pomieszczenia)")
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

function printer:wood(arr, sum, quest)
    self:title(sum)
    self:line("Kliknij na drzewo aby je sciac!", self.sectionColor)
    self:space()
    if quest then
        self:line(quest, self.successColor)
        self:space()
    end
    if next(arr) then
        self:dumpArrayLink(arr, "Nazwa")
    else
        self:line("Brak drzew", self.errorColor)
    end
    self:bottom(false, true)
end

function printer:box(arr)
    self:title("Paczki")
    self:line("Kliknij na paczke aby ja pobrac!", self.sectionColor)
    self:space()
    if next(arr) then
        self:dumpArrayLink(arr, "Nazwa")
    end
    self:bottom(false, true)
end

function printer:gps(arr)
    self:title("GPS")
    self:line("Kliknij na lokacje aby dotrzec do niej!", self.sectionColor)
    self:space()
    if next(arr) then
        self:dumpArrayLink(arr, "Nazwa")
    end
    self:bottom(false, true)
end


-- Bree
--  karczma usciskac +
--  srodek bree tajemniczy - mapa u bossa szczurolazow, cmentarz ???
-- biblioteke, muzeum, ratusz i zielarnie
--  pracownik na poczcie listy Paralon Bargins - Igielniczka  +
--  pracownik na poczcie Dunwig - po calym swiecie lata zamglone oczy ?????? skrang ???
-- Stary rumiany olbrzym przedstawia sie jako: Dunwig, olbrzym. lsniace szczyty
-- Dunwig podaza przed siebie i znika ci z pola widzenia.  -- znika kompletnie i spawn gdzie indziej ?
-- Rivendell
--  niespokojny elf - Mandork, hobbit. Bystry Brod, norka w hobbitonie - wilczy leb
-- Hobbiton
--  sheryf - zaatakowac moba i prowadzic go do robina (obrywajac w plecy) +
--  Perin - tukon <> hobbiton +
--  zielarz - stary las ziele ???
-- Michel Delving
--  Colin Manelio - "dwie godziny" - sylaby w slowach 'pustelniku' 'kobiecie' 'mlocie' 'niesmiertelnosci' bez odmiany +
--  Pryszczaty pulchny hobbit - wiezienie > kowal > ratusz > sklepik (zapytaj o noz/burmistrza/czlowieka) > karczma (postaw piwo rainabowi) > Wiesz juz wystarczajo duzo. Opowiedz o tym burmistrzowi. +
-- Mithlond
--  Wrak - Lond Daer > zapytaj karczmarza o statki > biblioteka (przeszukaj rupiecie) > magazyn (przeszukaj papiery) > opowiedz o <nazwa statku> +


-- Ustrekt
-- Listy i questy robic parami List do Draosa/Lustro(klej)    List do Valronda/Urzednik(papier kredowy)
-- Kratas
-- ork z kratas - kapitan > rybak > magazyn > karczma > stajenny > krawiec > skup skor > krawiec > stajenny > karczma > o nagrode kapitana
-- Dorath
-- zielarz - skore triplikatna, pudelko do miecznik vivane
-- wiesniak - przeszukaj siano, wloz slome do otworu, zakrec korba, nakarm kury
-- Vivane
-- gubernator - straznik na polnocnym murze, do celi w wiezieniu z inicjalami sprawcy na scianie, przeszukac prycze, do kanalow przeszukac dziure
-- swiatynia - lustro - 'dziecko' w miescie - mury n przeszukaj kosze - klej kelevine masc -
-- urzednik w ratuszu n - papier kratas sklep, okragle ciastko z s cukierni + sol (wyglada jak cukier) z karczmy n (przeszukaj pudeleczka) "posyp ciastko"
-- szewc - dorath karczma
-- poczta - Velrond, Kratas (/npc Velrond)
