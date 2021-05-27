local pelotaRebote = {}

pelotaRebote["instantiate"] = function(params, entity)
    local self = {}
    self.entity = entity
    return self
end

-- Si el ave colisiona adquiere el escudo
-- El escudo  da mas fuerza al 
pelotaRebote["onCollisionEnter"] = function(_self, lua, other)
    if other:getName() == "Bird" then
        lua:playSound("Assets/Music/PowerUp2.wav")
        local batcomponent = lua:getLuaSelf(other, "batBehaviour")
        batcomponent.escudo = true
        lua:getCurrentScene():destroyEntity(_self.entity)
    end
end

return pelotaRebote
