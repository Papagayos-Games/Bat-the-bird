local JSON = assert(loadfile "LuaScripts/json.lua")()

local burbuja = {}

burbuja["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity
    self.friction = 1.28
    if p.friction ~= nil then
        self.friction = p.friction
    end

    return self
end

-- Si el ave colisiona con el cohete recibe un impulso
burbuja["onCollisionEnter"] = function(_self, lua, other)
    if other:getName() == "Bird" then
        print("Burbuja")
        -- Set friction no esta funcionando
        -- lua:getRigidbody(other):setFriction(_self.friction)
        -- print("Burbuja2")
        lua:getCurrentScene():destroyEntity(_self.entity)
        print("Burbuja3")

    end
end

return burbuja
