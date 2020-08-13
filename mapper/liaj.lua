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
