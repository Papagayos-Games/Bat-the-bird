local burbuja = {}

burbuja["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity

    if p ~= nil then
        self.friction = p.friction
    else
        self.friction = 1.28
    end

    return self
end

-- Si el ave colisiona con el cohete recibe un impulso
burbuja["onCollisionEnter"] = function(_self, lua, other)
    if other:getName() == "Bird" then
        lua:getRigidbody(other):setFriction(_self.friction)
    end
end

return burbuja
