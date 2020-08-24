
-- 1 platek 6241 - 7484     blue 6666 7092        labirynt 7035  7154
-- 2 platek 7486 - 8727     blue 7837       diably 8004
-- 3 platek 8750 - 9536
-- 4 platek 9545 - 9982

function mapper:clearLiajPart(current, max, skip)
    while current <= max do
        local exits = getRoomExits(current)
        if exits ~= nil and next(exits) then
            if skip[current] then
                for dir, _ in pairs(exits) do
                    if not utils:inArray(self.en2short[dir], skip[current]) then
                        setExit(current, -1, dir)
                    end
                end
            else
                for dir, id in pairs(exits) do
                    setExit(current, -1, dir)
                end
            end
        end
        ---------------------
        current = current + 1
    end
end

function mapper:isLiajLocation()
    if self.room.id then
        if self.room.id >= 6241 and self.room.id <= 7484 then
            return true
        end
        if self.room.id >= 7486 and self.room.id <= 8727 then
            return true
        end
        if self.room.id >= 8750 and self.room.id <= 9536 then
            return true
        end
        if self.room.id >= 9545 and self.room.id <= 9982 then
            return true
        end
    end
    return false
end

function mapper:clearLiaj()
    -- 1
    mapper:clearLiajPart(6241, 7484, {
        [6247] = {"sw"},
        [6248] = {"w"},
        [6249] = {"nw"},
    })

    -- 2
    mapper:clearLiajPart(7486, 8727, {
        [8004] = {"e"},
    })

    -- 3
    mapper:clearLiajPart(8750, 9536, {
        [9883] = {"w"},
    })

    -- 4
    mapper:clearLiajPart(9545, 9982, {
        [9867] = {"se"},
        [9886] = {"s", "e", "ne"},
        [9885] = {"e", "se"},
        [9884] = {"se"},
        [9903] = {"e", "s"},
        [9902] = {"se"},
        [9918] = {"s", "se"},
        [9932] = {"sw", "s", "e"},
    })
end

-- gorny platek
function mapper:fillCol(curr, x, y, limit)
  local out = {}
  limit = curr + limit
  while curr < limit do
    table.insert(out, curr)
    local roomExists = self:getRoomByCoords(x, y, 0)
	if not roomExists then
		print("create "..curr)
		mapper:addRoom(self.room.area, curr, x, y, 0)
	end
    y = y-2
    curr = curr+1
  end
end

function mapper:getRoomByCoords(x, y, z)
	return select(2, next(getRoomsByPosition(self.room.area, x, y, z)))
end

-- srodkowy platek
function mapper:fillCol2(from, x, to)
    y = 148
    while from < to do
        local roomExists = self:getRoomByCoords(x, y, 0)
        if not roomExists then
            print("create "..from)
            mapper:addRoom(self.room.area, from, x, y, 0)
        end
        y = y-2
        from = from + 1
    end
end

-- poludniowy przedostatni
function mapper:fillCol3(from, x, to)
    y = 108
    while from < to do
        local roomExists = self:getRoomByCoords(x, y, 0)
        if not roomExists then
            print("create "..from)
            mapper:addRoom(self.room.area, from, x, y, 0)
        end
        y = y-2
        from = from + 1
    end
end

-- poludniowy przedostatni PLATEK
--mapper:fillCol(8857, -196, 104, 18)
--mapper:fillCol(8875, -194, 108, 20)
--mapper:fillCol3(8895, -192, 8915)
--mapper:fillCol3(8915, -190, 8935)
--mapper:fillCol3(8935, -188, 8955)
--mapper:fillCol3(8955, -186, 8975)
--mapper:fillCol3(8975, -184, 8995)
--mapper:fillCol3(8995, -182, 9015)
--mapper:fillCol3(9015, -180, 9035)
--mapper:fillCol(9050, -178, 108, 20)
--mapper:fillCol3(9070, -176, 9090)
--mapper:fillCol3(9090, -174, 9110)
--mapper:fillCol3(9110, -172, 9130)
--mapper:fillCol3(9130, -170, 9150)
--mapper:fillCol3(9150, -168, 9170)
--mapper:fillCol3(9170, -166, 9190)
--mapper:fillCol3(9190, -164, 9210)
--mapper:fillCol3(9210, -162, 9230)
--mapper:fillCol3(9230, -160, 9250)
--mapper:fillCol3(9250, -158, 9270)
--mapper:fillCol3(9270, -156, 9290)
--mapper:fillCol3(9290, -154, 9310)
--mapper:fillCol3(9310, -152, 9330)
--mapper:fillCol3(9330, -150, 9350)
--mapper:fillCol3(9350, -148, 9370)
--mapper:fillCol3(9370, -146, 9390)
--mapper:fillCol3(9390, -144, 9410)
--mapper:fillCol3(9410, -142, 9430)
--mapper:fillCol3(9430, -140, 9450)
--mapper:fillCol3(9450, -138, 9470)
--mapper:fillCol3(9470, -136, 9490)
--mapper:fillCol3(9490, -134, 9510)
--mapper:fillCol(9510, -132, 106, 15)

-- OSTATNI PLATEK
--mapper:fillCol(9579, -182, 68, 11)
--mapper:fillCol(9590, -180, 68, 12)
--mapper:fillCol(9602, -178, 68, 13)
--mapper:fillCol(9615, -176, 68, 14)
--mapper:fillCol(9629, -174, 68, 14)
--mapper:fillCol(9643, -172, 68, 15)
--mapper:fillCol(9658, -170, 68, 16)
--mapper:fillCol(9674, -168, 68, 16)
--mapper:fillCol(9690, -166, 68, 16)
--mapper:fillCol(9706, -164, 68, 16)
--mapper:fillCol(9722, -162, 68, 17)
--mapper:fillCol(9739, -160, 68, 18)
--mapper:fillCol(9757, -158, 68, 18)
--mapper:fillCol(9775, -156, 68, 18)
--mapper:fillCol(9793, -154, 68, 18)
--mapper:fillCol(9811, -152, 68, 19)
--mapper:fillCol(9830, -150, 68, 19)
--mapper:fillCol(9849, -148, 68, 19)
--mapper:fillCol(9868, -146, 68, 19)
--mapper:fillCol(9887, -144, 68, 17)
--mapper:fillCol(9904, -142, 68, 14)
--mapper:fillCol(9919, -140, 68, 13)
--mapper:fillCol(9933, -138, 68, 12)
--mapper:fillCol(9945, -136, 68, 11)
--mapper:fillCol(9956, -134, 68, 10)
--mapper:fillCol(9976, -130, 68, 7)

-- srodkowy platek

--7496, 7508, --niestandardowe
--mapper:fillCol2(7508, -254, 7522)
--mapper:fillCol2(7522, -252, 7537)
--mapper:fillCol2(7537, -250, 7553)
--mapper:fillCol2(7553, -248, 7570)
--mapper:fillCol2(7570, -246, 7588)
--mapper:fillCol2(7588, -244, 7607)
--mapper:fillCol2(7607, -242, 7626)
--mapper:fillCol2(7626, -240, 7646)
--mapper:fillCol2(7646, -238, 7666)
--mapper:fillCol2(7666, -236, 7686)
--mapper:fillCol2(7686, -234, 7706)
--mapper:fillCol2(7706, -232, 7726)
--mapper:fillCol2(7726, -230, 7746)
--mapper:fillCol2(7746, -228, 7766)
--mapper:fillCol2(7766, -226, 7786)
--mapper:fillCol2(7786, -224, 7806)
--mapper:fillCol2(7806, -222, 7826)
--mapper:fillCol2(7826, -220, 7847)
--mapper:fillCol2(7847, -218, 7867)
--mapper:fillCol2(7867, -216, 7887)
--mapper:fillCol2(7887, -214, 7907)
--mapper:fillCol2(7907, -212, 7927)
--mapper:fillCol2(7927, -210, 7947)
--mapper:fillCol2(7947, -208, 7967)
--mapper:fillCol2(7967, -206, 7987)
--mapper:fillCol2(7987, -204, 8007)
--mapper:fillCol2(8007, -202, 8027)
--mapper:fillCol2(8027, -200, 8047)
--mapper:fillCol2(8047, -198, 8067)
--mapper:fillCol2(8067, -196, 8086)
--mapper:fillCol2(8086, -194, 8101)
-- anomalie na -192
-- lewa strona wylomu
--mapper:fillCol(8118, -190, 148, 11) -- chyba 11
--mapper:fillCol(8135, -188, 148, 8)
--mapper:fillCol(8151, -186, 148, 7)
--mapper:fillCol(8187, -182, 148, 6)
-- zniknelo 20 idkow ?
-- prawa strona wylomu
--mapper:fillCol(8158, -186, 130, 11)
--mapper:fillCol(8175, -184, 132, 12)
--mapper:fillCol(8193, -182, 134, 13)
--mapper:fillCol(8208, -180, 134, 13)
--mapper:fillCol(8239, -178, 142, 17)
--mapper:fillCol(8257, -176, 144, 18)
--mapper:fillCol(8275, -174, 144, 18)
-- za wylomem
--mapper:fillCol2(8293, -172, 8313)
--mapper:fillCol2(8313, -170, 8333)
--mapper:fillCol2(8333, -168, 8353)
--mapper:fillCol2(8353, -166, 8373)
--mapper:fillCol2(8373, -164, 8393)
--mapper:fillCol2(8393, -162, 8413)
--mapper:fillCol2(8413, -160, 8433)
--mapper:fillCol2(8433, -158, 8453)
--mapper:fillCol2(8453, -156, 8473)
--mapper:fillCol2(8473, -154, 8493)
--mapper:fillCol2(8493, -152, 8513)
--mapper:fillCol2(8513, -150, 8533)
--mapper:fillCol2(8533, -148, 8553)
--mapper:fillCol2(8553, -146, 8573)
--mapper:fillCol2(8573, -144, 8593)
--mapper:fillCol2(8593, -142, 8613)
--mapper:fillCol2(8613, -140, 8633)
--mapper:fillCol2(8633, -138, 8653)
--mapper:fillCol2(8653, -136, 8673)
-- czas na anomalie z prawej strony
--mapper:fillCol(8673, -134, 148, 13)
--mapper:fillCol(8692, -132, 148, 13)
--mapper:fillCol(8711, -130, 148, 15)


-- polnocn platek

--[[
col1 > 6241 - 6254
col2 > 6255 - 6271
col3 > 6272 - 6289
col4 > 6290 - 6308
col5 > 6309 - 6327
col6 > 6328 - 6346
col7 > 6347 - 6366
]]--


--mapper:fillCol(6347, -246, 188, 20)
--mapper:fillCol(6367, -244, 188, 20)
--mapper:fillCol(6387, -242, 188, 20)
--mapper:fillCol(6407, -240, 186, 19)
--mapper:fillCol(6426, -238, 188, 20)
--mapper:fillCol(6446, -236, 188, 20)
--mapper:fillCol(6466, -234, 188, 20)
--mapper:fillCol(6486, -232, 188, 20)
--mapper:fillCol(6506, -230, 188, 20)
--mapper:fillCol(6526, -228, 188, 20)
--mapper:fillCol(6546, -226, 186, 19)
--mapper:fillCol(6565, -224, 186, 19)
--mapper:fillCol(6584, -222, 188, 20)
--mapper:fillCol(6604, -220, 188, 20)
--mapper:fillCol(6624, -218, 188, 20)
--mapper:fillCol(6644, -216, 188, 20)
--mapper:fillCol(6664, -214, 186, 19)
--mapper:fillCol(6683, -212, 188, 20)
--mapper:fillCol(6703, -210, 188, 20)
--mapper:fillCol(6723, -208, 188, 20)
--mapper:fillCol(6743, -206, 188, 20)
--mapper:fillCol(6763, -204, 188, 20)
--mapper:fillCol(6783, -202, 188, 20)
--mapper:fillCol(6803, -200, 188, 20)
--mapper:fillCol(6823, -198, 186, 19)
--mapper:fillCol(6842, -196, 188, 20)
--mapper:fillCol(6862, -194, 188, 20)
--mapper:fillCol(6882, -192, 188, 20)
--mapper:fillCol(6902, -190, 188, 20)
--mapper:fillCol(6922, -188, 188, 20)
--mapper:fillCol(6942, -186, 188, 20)
--mapper:fillCol(6962, -184, 188, 20)
--mapper:fillCol(6982, -182, 188, 20)
--mapper:fillCol(7002, -180, 188, 20)
--mapper:fillCol(7022, -178, 188, 20)
--mapper:fillCol(7042, -176, 188, 20)
--mapper:fillCol(7062, -174, 186, 19)
--mapper:fillCol(7081, -172, 182, 17)
--mapper:fillCol(7098, -170, 188, 20)
--mapper:fillCol(7118, -168, 188, 20)
--mapper:fillCol(7138, -166, 188, 20)
--mapper:fillCol(7158, -164, 188, 20)
--mapper:fillCol(7178, -162, 188, 20)
--mapper:fillCol(7198, -160, 188, 20)
--mapper:fillCol(7218, -158, 188, 20)
--mapper:fillCol(7238, -156, 188, 20)
--mapper:fillCol(7258, -154, 188, 20)
--mapper:fillCol(7278, -152, 188, 20)
--mapper:fillCol(7298, -150, 188, 20)
--mapper:fillCol(7318, -148, 188, 20)
--mapper:fillCol(7338, -146, 188, 20)
--mapper:fillCol(7358, -144, 186, 19)
--mapper:fillCol(7377, -142, 186, 19)
--mapper:fillCol(7396, -140, 184, 18)
--mapper:fillCol(7414, -138, 184, 18)
--mapper:fillCol(7432, -136, 184, 18)
--mapper:fillCol(7450, -134, 182, 6) -- wycieta koncowka

--7486 - nowy platek
