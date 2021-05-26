local keys = assert(loadfile "LuaScripts/keycode.lua")()
local JSON = assert(loadfile "LuaScripts/JSON.lua")()
local batBehaviour = {}

batBehaviour["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity
    self.transform = nil
    self.rb = nil
    self.startPos = nil
    self.time = 0
    self.prevTime = 0
    self.batted = false
    self.escudo = false
    self.strength = 20.0
    self.sweetspot = 3.0
    if p ~=nil then
        if p.strength ~= nil then
            self.strength = p.strength
        end
        if p.sweetspot ~= nil then
            self.sweetspot = p.sweetspot
        end
    end
    -- margen de tiempo de 2 segundos para batear
    -- 
    self.topLimit = self.sweetspot - 1.0
    self.botLimit = self.sweetspot + 1.0

    return self
end

batBehaviour["start"] = function(_self, lua)
    _self.transform = lua:getTransform(_self.entity)
    local aux = _self.transform:getPosition()
    _self.startPos = Vector3(aux.x, aux.y, aux.z)
    _self.rb = lua:getRigidbody(_self.entity)
    _self.prevTime = lua:getInputManager():getTicks()
end

batBehaviour["update"] = function(_self, lua, deltaTime)
    local input = lua:getInputManager()

    if input:mouseButtonPressed() == 1 then
        if not _self.batted and (_self.time < _self.botLimit and _self.time > _self.topLimit) then
            local strength = _self.strength *
                                 (_self.sweetspot -
                                     (math.abs(_self.sweetspot - _self.time)))
            _self.rb:addForce1(Vector3(0, strength, 0), Vector3(0, 0, 0), 1)
            local cameraFollow = lua:getLuaSelf(lua:getEntity("defaultCamera"),
                                                "followTarget")
            cameraFollow.setFollow(true)
            _self.batted = true
            _self.time =  0
            print(_self.strength)
            lua:getLuaSelf(lua:getEntity("gameManager"), "gameManager").modSpawners(true, 15 * strength) --velocidad en x inicial de los spawners
        else
            if _self.time > 0 then
                _self.rb:addForce1(Vector3(0, _self.strength, 0),
                                   Vector3(0, 0, 0), 0)
                _self.time = _self.time - deltaTime
            end
        end
    else
        if not _self.batted then
            _self.time = _self.time + deltaTime
            if _self.time < _self.botLimit and _self.time > _self.topLimit then
                --print("puedo batiar")
            end
        elseif _self.time < 5 then
            _self.time = _self.time + deltaTime / 2
        end
    end
    -- Para debuggear resetea la posicion si se hace click derecho
    if input:mouseButtonPressed() == 2 then
        _self.rb:setLinearVelocity(Vector3(0, 0, 0))
        _self.rb:setPosition(Vector3(_self.startPos.x, _self.startPos.y,
                                     _self.startPos.z))
        _self.time = 0;
        _self.batted = false
        local cameraTransform = lua:getTransform(lua:getEntity("defaultCamera"))
        cameraTransform:setPosition(Vector3(0, 80, 300))
        local cameraFollow = lua:getLuaSelf(lua:getEntity("defaultCamera"),
                                            "followTarget")
        cameraFollow.setFollow(false)
        lua:getLuaSelf(lua:getEntity("gameManager"), "gameManager").modSpawners(false, 0)
    end
end

-- Si toca el suelo no puede batear mas
batBehaviour["onCollisionEnter"] = function(_self, lua, other)
    if other:getName() == "floor" then
        if _self.escudo == true then
            lua:getRigidbody(other):addForce1(Vector3(0, _self.strength, 0),
                                              Vector3(0, 0, 0), 1)
            _self.escudo = false
        end
        _self.batted = true
    end
end

return batBehaviour
