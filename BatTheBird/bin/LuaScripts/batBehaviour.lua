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
    self.strength = p.strength
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

batBehaviour["update"] = function (_self, lua, deltaTime)
    local input = lua:getInputManager()

    _self.time = _self.time + deltaTime

    if _self.time > 2.5 and _self.time < 3.5 then
         print("ahora")
    end

    if((not _self.batted) and input:mouseButtonPressed() == 1) then
        local strength = _self.strength * (_self.sweetspot - (math.abs(_self.sweetspot - _self.time)))
        _self.rb:addForce1(Vector3(0, strength, 0), Vector3(0,0,0), 1)
        local cameraFollow = lua:getLuaSelf(lua:getEntity("defaultCamera"), "followTarget")
        cameraFollow.setFollow(true)
        _self.batted = true
    end

    -- Para debuggear resetea la posicion si se hace click derecho
    if(input:mouseButtonPressed() == 2) then
        _self.rb:setLinearVelocity(Vector3(0,0,0))
        _self.rb:setPosition(Vector3(_self.startPos.x, _self.startPos.y, _self.startPos.z))
        _self.time = 0;
        _self.batted = false
        local cameraTransform = lua:getTransform(lua:getEntity("defaultCamera"))
        cameraTransform:setPosition(Vector3(0, 80, 300))
        local cameraFollow = lua:getLuaSelf(lua:getEntity("defaultCamera"), "followTarget")
        cameraFollow.setFollow(false)
    end
end


-- Si toca el suelo no puede batear mas
batBehaviour["onCollisionEnter"] = function(_self, lua, other)
    if other:getName() == "floor" then 
        _self.batted = true
    end
end

return batBehaviour