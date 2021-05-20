local keys = assert(loadfile "LuaScripts/keycode.lua")()
local JSON = assert(loadfile "LuaScripts/JSON.lua")()

local batBehaviour = {}

batBehaviour["instantiate"] = function (params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity
    self.transform = nil
    self.rb = nil
    self.startPos = nil
    self.maxStrength = p.maxStrength
    self.time = 0
    self.prevTime = 0
    self.sweetspot = p.sweetspot
    self.batted = false
    return self
end

batBehaviour["start"] = function (_self, lua)
    _self.transform = lua:getTransform(_self.entity)
    local aux = _self.transform:getPosition()
    _self.startPos = Vector3(aux.x, aux.y, aux.z)
    _self.rb = lua:getRigidbody(_self.entity)
    _self.prevTime = lua:getInputManager():getTicks()
end

batBehaviour["update"] = function (_self, lua)
    local input = lua:getInputManager()

    local delta = input:getTicks() - _self.prevTime
    _self.time = _self.time + (delta/1000)
    _self.prevTime = input:getTicks()

    if((not _self.batted) and input:mouseButtonPressed() == 1) then
        local strength = _self.maxStrength * (_self.sweetspot - (math.abs(_self.sweetspot - _self.time)))
        _self.rb:addForce1(Vector3(0, 5 * strength, 0), Vector3(0,0,0), 1)
        _self.batted = true
        print(strength)
    end


    if(_self.transform:getPosition().y < 0.0) then
        _self.rb:setLinearVelocity(Vector3(0,0,0))
        print(_self.startPos.y)
        _self.rb:setPosition(Vector3(_self.startPos.x, _self.startPos.y, _self.startPos.z))
        _self.time = 0;
        _self.batted = false
    end
end

return batBehaviour