local cohete = {}

cohete["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity

    if p ~= nil then
        self.strength = p.strength
    else
        self.strength = 12
    end

    return self
end

-- Si el ave colisiona con el cohete recibe un impulso
cohete["onCollisionEnter"] = function(_self, lua, other)
    if other:getName() == "Bird" then
        lua:getRigidbody(other):addForce1(Vector3(0, _self.strength, 0),
                                          Vector3(0, 0, 0), 1)
    end
end

return cohete
