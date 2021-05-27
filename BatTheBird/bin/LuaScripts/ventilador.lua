local JSON = assert(loadfile "LuaScripts/json.lua")()

local ventilador = {}

ventilador["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity

    -- Fuerza que se aplica mientras este el jugador 
    -- con en contacto con el ventilador
    self.strength = 50.0
    self.time = 0
    self.timeLimit = 100

    return self
end

-- Si el ave colisiona con el ventilador, le aplica una fuerza
-- hacia arriba hasta que se rompa
ventilador["onCollisionStay"] = function(_self, lua, other)
    if other:getName() == "Bird" then
        lua:getRigidbody(other):addForce1(Vector3(0, -_self.strength, 0), Vector3(0, 0, 0), 0)
        _self.time = _self.time + 1
        if _self.time >= _self.timeLimit then
            lua:getCurrentScene():destroyEntity(_self.entity)
        end
        
    end
end

--Cuando deje de colisionar con el pajaro, el ventilador se rompe
ventilador["onCollisionExit"] = function(_self, lua, other)
    if other:getName() == "Bird" then
        lua:getCurrentScene():destroyEntity(_self.entity)
    end
end

return ventilador
