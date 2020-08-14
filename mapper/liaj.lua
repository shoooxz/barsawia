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

-- poludniowy PLATEK
mapper:fillCol(8774, -206, 100, 11)


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
