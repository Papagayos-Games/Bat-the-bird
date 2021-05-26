local destroyAtPos = {}

destroyAtPos["instantiate"] = function(params, entity)
    local self = {}
    self.entity = entity
    self.limitX = -200
    if p.limitX ~= nil then
        self.limitX = p.limitX
    end
    return self
end

destroyAtPos["start"] = function(_self, lua)
   --_self.limitX = (lua:getOgreContext():getWindowWidth()/2)
end

-- Si el ave colisiona con el cohete recibe un impulso
destroyAtPos["onCollisionEnter"] = function(_self, lua, other)
    lua:getCurrentScene():destroyEntity(_self.entity)
end

return destroyAtPos
