miner = miner or {}
miner.active = false
miner.switch = true
miner.dir = nil

function miner:pick()
	send("sp")
	send("opusc oskardzik;dobadz ostrego kilofa;napelnij lampe olejem")
	send("kuj "..self.dir.." sciane")
end

function miner:slash()
	return function()
		if self.active then
			send("wez wszystko;odloz pomaranczowe kamienie;odloz granity;odloz popielate kamienie")
		end
	end
end

function miner:num5()
	return function()
		if self.active then
			if self.switch then -- TODO ZMIENIC na bron i kilof ??
				send("opusc ostry kilof;dobadz oskardzika")
				self.switch = false
			else
				send("opusc oskardzik;dobadz ostrego kilofa")
				self.switch = true
			end
		end
	end
end

function miner:move()
	return function(e, dir)
		if self.active then
			self.dir = dir
			send("opusc kilof;dobadz oskardzika")
			send("zbadaj "..dir.." sciane")
			--send("zbliz krysztal do "..dir.." sciany")
		end
	end
end

scripts.events["minerModMove"] = registerAnonymousEventHandler("modMove", miner:move())
scripts.events["minerNum5"] = registerAnonymousEventHandler("num5", miner:num5())
scripts.events["minerSlash"] = registerAnonymousEventHandler("slash", miner:slash())


--[[
[ 2] Jasnoczerwona brylka                                      1    1    7 |
| [ 1] Srebrzystobiala brylka                                    1    8    1 |
| [ 1] Blekitnosrebrzysta brylka                              3306    8    2 |
| [ 2] Perlowostalowy mrocznolsniacy sauronit                  325    8    9 |
| [37] Zielony szmaragd                                        143    7    7 |
| [83] Niebieskawy akwamaryn                                   330    6    7 |
| [13] Rudoblekitny pietersyt                                    7    6    6 |
| [66] Dymny krysztal                                           46    7    4 |
| [15] Rozowy krysztal                                          62    2    9 |
| [28] Gorski krysztal                                          38    3    4 |
| [20] Ciemnobrazowy nefryt                                    105    7    8 |
| [47] Zielonobialy jadeit                                      25    3    9 |
| [84] Blekitny agat                                            47    9    2 |
| [99] Pomaranczowy kamien                                            3    1 |
| [28] Ciemnozielony labrador                                   25    7    1 |
| [11] Jasnozielony topaz                                      402    5    7 |
| [101] Jasnofioletowy ametyst                                   74    7    6 |
| [100] Zoltawa brylka                                            2         4 |
| [122] Czarna brylka                                                  1    8 |
| [15] Smolistoczarny onyks                                     82    8      |
| [23] Pasiasty jaspis                                          11    1    7 |
| [ 8] Niebieski opal                                          503    2      |
| [31] Wielobarwny frazyt                                       15    9    7 |
| [39] Zielonkawy hanisyt                                      159    7    5 |
| [ 4] Zlocisty heliodor                                        95    8    5 |
| [18] Brazowy karneol                                          22    8    3 |
| [ 3] Niebieskoczarny turkus                                   29    8    6 |
| [ 1] Zoltoniebieski balinit                                   25    8    7 |

]]--
