local destroyOnContact = {}

destroyOnContact["instantiate"] = function(params, entity)
    local self = {}
    self.entity = entity
    return self
end


-- Si el ave colisiona con el cohete recibe un impulso
destroyOnContact["onCollisionEnter"] = function(_self, lua, other)
    lua:getCurrentScene():destroyEntity(_self.entity)
end

return destroyOnContact
