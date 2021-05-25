local pelotaRebote = {}

pelotaRebote["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity

    return self
end

-- Si el ave colisiona con el cohete recibe un impulso
pelotaRebote["onCollisionEnter"] = function(_self, lua, other)
    if other:getName() == "Bird" then
        local batcomponent = lua:getLuaSelf(other, "batBehaviour")
        batcomponent.escudo = true
    end
end

return pelotaRebote
