function printer:error(title, msg)
    if msg then
        self:title(title)
        if type(msg) == "string" then
            self:errorLine(msg)
        else
            for i = 1, #msg do
                self:errorLine(msg[i])
            end
        end
        self:bottom()
    end
end

function printer:success(title, msg)
    if msg then
        self:title(title)
        if type(msg) == "string" then
            self:successLine(msg)
        else
            for i = 1, #msg do
                self:successLine(msg[i])
            end
        end
        self:bottom()
    end
end
