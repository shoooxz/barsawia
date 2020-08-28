function doSpeedWalk()
    --speedWalkDir
    --speedWalkPath
    if not mapper.walker.going then
        mapper.walker.path = speedWalkDir
        mapper.walker.going = true
        mapper:speedwalk()
    end
end

function mapper:speedwalk()
    if self.walker.path[self.walker.step] then
        tempTimer(self.walker.delay, function()
            if self.walker.going then
                self:walkerMove(self.walker.path[self.walker.step])
                self.walker.step = self.walker.step +1
                self:speedwalk()
            end
        end)
    else
        self:walkerStop()
    end
end

function mapper:walkerStop()
    self.walker.going = false
    self.walker.step = 1
end

function mapper:walkerInterrupted(command)
    if self.walker.going then
        self.walker.going = false
        send(command)
        tempTimer(3, function()
            self.walker.step = self.walker.step - 1
            self.walker.going = true
            mapper:speedwalk()
        end)
    end
end

function mapper:walkerMove(dir)
    if self.en2short[dir] then
        dir = self.en2short[dir]
    end
    local roomID = self:getRoomViaExit(dir)
    if not roomID then
        local special = getSpecialExitsSwap(self.room.id)
        if special[dir] then
            roomID = special[dir]
        end
    end
    if roomID then
        send(dir)
        self:center(roomID)
    else
        printer:error("Walker", "Krytyczny blad chodzika!")
    end
end
