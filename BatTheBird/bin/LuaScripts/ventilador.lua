local JSON = assert(loadfile "LuaScripts/json.lua")()

local burbuja = {}

burbuja["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity

    -- Fuerza que se aplica mientras este el jugador 
    -- con en contacto con el ventilador
    self.strength = 5.0
    self.time = 0
    self.timeLimit = 100
    if p ~= nil then
        if p.friction ~= nil then
            self.friction = p.friction
        end
    end
    return self
end

-- Si el ave colisiona con el ventilador, le aplica una fuerza
-- hacia arriba hasta que se rompa
burbuja["onCollisionStay"] = function(_self, lua, other)
    if other:getName() == "Bird" then
        print("Burbuja")
        lua:getRigidbody(other):addForce1(Vector3(0, _self.strength, 0), Vector3(0, 0, 0), 0)
        _self.time = _self.time + 1
        if _self.time >= _self.timeLimit then
            lua:getCurrentScene():destroyEntity(_self.entity)
        end
        
    end
end

return burbuja
