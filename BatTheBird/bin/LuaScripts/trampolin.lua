local JSON = assert(loadfile "LuaScripts/json.lua")()

local trampolin = {}

trampolin["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity
    self.strength = 12
    if p ~= nil then 
        if p.strength ~= nil then 
            self.strength = p.strength 
        end
    end
    return self
end

-- Si el ave colisiona con el trampolin recibe un impulso
trampolin["onCollisionEnter"] = function(_self, lua, other)
    print( other:getName())
    if other:getName() == "Bird" then
        lua:getRigidbody(other):addForce1(Vector3(0, _self.strength, 0),
                                          Vector3(0, 0, 0), 1)
 
        lua:getCurrentScene():destroyEntity(_self.entity)
    end
end

return trampolin
