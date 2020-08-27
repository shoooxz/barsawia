gag = gag or {}
gag.color = {
	["aim"] = "light_sea_green",
	["miss"] = "light_slate_grey",
}
gag.bow = {
	["ociera sie grotem"] = 1,
	["wbija sie plytko"] = 2,
	["uderza"] = 3,
	["mocno uderza"] = 4,
	["wbija sie"] = 5,
	["wbija sie gleboko"] = 6,
	["uderza z mordercza precyzja"] = 7,
}
gag.bowColorRange = {
	"green",
	"green",
	"green",
	"yellow",
	"yellow",
	"red",
	"red",
}
--[[

Nieskoordynowanym pchnieciem swojego czarnego zdobionego kordu ledwie nakluwasz groznego strasznego
upiora, trafiajac go w lewa reke.

Mizernym pchnieciem swojego czarnego zdobionego kordu zadajesz lekkie obrazenia groznemu strasznemu
upiorowi, trafiajac go w glowe.

]]--


function gag:bowAim(who, where)
	local str = "Celujesz w " .. who
	if where then
		str = str .. " na " .. where
	end
	self:replace(str, self.color.aim)
end

function gag:bowMiss(who)
	self:replace("Chybiasz " .. who, self.color.miss)
end

function gag:bowHit(who, hit, where)
	local power = self.bow[hit]
	if power then
		self:replace("["..power.."/7] Strzelasz w " .. who .. ". Strzala "..hit.." w/o "..where, self.bowColorRange[power])
	else
		printer:error("Gagi", "Nie ma takiego opisu strzalu!")
	end
end

function gag:prefix()
	selectCurrentLine()
    local str_replace = "[1/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["moje_ciosy"])
    resetFormat()
end

function gag:replace(str, color)
	selectCurrentLine()
    deleteLine()
    cecho("\n<"..color..">"..str..".\n")
    resetFormat()
end

--[[

Strzala mocno uderza w jego glowe.
Strzala wbija sie plytko w jego glowe.
Strzala wbija sie plytko w jego cialo.
Strzala uderza w jego cialo.
Strzala wbija sie w jego glowe.
Strzala ociera sie grotem o jego cialo.



Puszczasz napieta cieciwe wystrzeliwujac na poludnie jesionowa czerwona strzale w kierunku
ciemnozielonego syczacego weza, lecz chybiasz.
 Strzala uderza z mordercza precyzja w jego cialo.
Strzala mocno uderza w jego cialo.


Puszczasz napieta cieciwe wystrzeliwujac na poludniowy-wschod jesionowa czerwona strzale w kierunku
syczacego ciemnozielonego weza. Strzala uderza z mordercza precyzja w jego cialo.

Puszczasz napieta cieciwe wystrzeliwujac na zachod jesionowa czerwona strzale w kierunku silnego
zwinnego tygrysa, lecz chybiasz.

Puszczasz napieta cieciwe wystrzeliwujac jesionowa czerwona strzale w kierunku silnego zwinnego
tygrysa, lecz chybiasz.

]]--
