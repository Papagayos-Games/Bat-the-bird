local bulletBehaviour = {}

bulletBehaviour["instantiate"] = function (params, entity)
    --p = JSON:decode(params)
    local self = {}
    self.entity =  entity
    
    --En segundos
    self.lifetime = 3
    return self
end

bulletBehaviour["start"] = function (_self, lua)
    _self.startTime = lua:getInputManager():getTicks()
end

bulletBehaviour["update"] = function (_self, lua)

    if (lua:getInputManager():getTicks() - _self.startTime)/1000  >= _self.lifetime then
        lua:getCurrentScene():destroyEntity(_self.entity)
    end 
end

return bulletBehaviour