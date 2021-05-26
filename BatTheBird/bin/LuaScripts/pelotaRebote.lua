local pelotaRebote = {}

pelotaRebote["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity
    return self
end

-- Si el ave colisiona adquiere el escudo
-- El escudo  da mas fuerza al 
pelotaRebote["onCollisionEnter"] = function(_self, lua, other)
    if other:getName() == "Bird" then
        --print("PelotaRebote")
        local batcomponent = lua:getLuaSelf(other, "batBehaviour")
        batcomponent.escudo = true
        lua:getCurrentScene():destroyEntity(_self.entity)
    end
end

return pelotaRebote
