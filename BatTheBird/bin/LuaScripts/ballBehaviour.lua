local keys = assert(loadfile "LuaScripts/keycode.lua")()
local JSON = assert(loadfile "LuaScripts/JSON.lua")()

local ballBehaviour = {}

ballBehaviour["instantiate"] = function (params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity
    self.rb = nil
    self.iniStrength = p.iniStrength
    self.time = 0
    self.sweetspot = p.sweetspot
    return self
end

ballBehaviour["start"] = function (_self, lua)
    _self.rb = lua:getRigidbody(_self.entity)
    _self.time = lua:getInputManager():getTicks()
end

ballBehaviour["update"] = function (_self, lua)
    local input = lua:getInputManager()
    local dir = (Vector3(0.25, 1, 0))
    dir:multiplyByNumber(_self.iniStrength)

    -- time = time + input:getTicks()

    -- Cambiar la tecla al espacio
    if (input:keyPressed(Keycode.A)) then
        _self.rb:addForce1(dir, Vector3(0,0,0), 1)
        print("aplico la fuerza")
        --rig:addForce1(vec, rel, 1)
    end 
end

return ballBehaviour