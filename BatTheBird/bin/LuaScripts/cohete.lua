local JSON = assert(loadfile "LuaScripts/json.lua")()

local cohete = {}

cohete["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity
    self.strength = 12
    if p.strength ~= nil then
        self.strength = p.strength
    end
    return self
end

-- Si el ave colisiona con el cohete recibe un impulso
cohete["onCollisionEnter"] = function(_self, lua, other)
    if other:getName() == "Bird" then
        lua:playSound("Assets/Music/PowerUp1.wav")
        lua:getRigidbody(other):addForce1(Vector3(0, _self.strength, 0), Vector3(0, 0, 0), 1)
        lua:getLuaSelf(lua:getEntity("gameManager"), "gameManager").modSpawnersSpeed(_self.strength)
        lua:getCurrentScene():destroyEntity(_self.entity)
    end
end

return cohete
