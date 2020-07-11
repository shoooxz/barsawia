wood = wood or {}

-- Sposrod otaczajacych cie drzew, nastepujace nadaja sie do scinki:
-- Pochylona osika o lepkiej korze, dlugolistne drzewo o spekanej korowinie i
-- dlugolistne drzewo o spekanej korowinie.

-- Sposrod otaczajacych cie drzew, nastepujace nadaja sie do scinki:
-- Trojlistkowe strzepistoskore drzewo i brunatnokore drzewo o dloniastopierzastych
-- lisciach.

-- Oto drzewa, rosnace na tym wyrebie, ktora nadaja sie do scinki:
-- Snieznokora brzoza o spekanym pniu, trojlistkowe strzepistoskore drzewo i
-- srebnolistny dab o krepym pniu.

-- Snieznokora brzoza o spekanym pniu, trojlistkowe strzepistoskore drzewo i
-- srebnolistny dab o krepym pniu.

-- Dlugolistne drzewo o spekanej korowinie i dlugolistne drzewo o spekanej
-- korowinie.

-- Trojlistkowe strzepistoskore drzewo i brunatnokore drzewo o dloniastopierzastych
-- lisciach.

-- zbadaj wyreb
-- zetnij drzewo
-- odrab konary drzewa;odetnij galezie drzewa;odgarnij kore klody;doczysc klode

-- Niestety, nie posiadasz odpowiedniej wiedzy i umiejetnosci, by sciac to drzewo.

function wood:cut()
	send("zbadaj wyreb; zetnij drzewo; zetnij drugie drzewo; zetnij trzecie drzewo; zetnij czwarte drzewo; zetnij piate drzewo; zetnij szoste drzewo", false)
end

function wood:cut()
	send("zetnij drzewo; zetnij drugie drzewo; zetnij trzecie drzewo; zetnij czwarte drzewo; zetnij piate drzewo; zetnij szoste drzewo", false)
end

function wood:hew()
	send("odrab konary drzewa; odetnij galezie drzewa; odgarnij kore klody; doczysc klode", false)
end
