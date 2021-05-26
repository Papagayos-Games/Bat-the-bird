local destroyAtPos = {}

destroyAtPos["instantiate"] = function(params, entity)
    local self = {}
    self.entity = entity
    self.limitX = -220
    if p.limitX ~= nil then
        self.limitX = p.limitX
    end
    return self
end

destroyAtPos["start"] = function(_self, lua)
   --_self.limitX = (lua:getOgreContext():getWindowWidth()/2)
   _self.position = lua:getTransform(_self.entity):getPosition()
end

-- Si llega a la posicion en limitX se destruye
destroyAtPos["update"] = function(_self, lua, deltaTime)
    if _self.position.x < _self.limitX then
        lua:getCurrentScene():destroyEntity(_self.entity)
    end
end

return destroyAtPos
