local JSON = assert(loadfile "LuaScripts/json.lua")()
local spawner = {}

local function createfunc(_self, lua, object)
    local rndY = math.random() +
                     math.random(math.floor(_self.birdPos.y - _self.spawnRange) + 1,
                         math.floor(_self.birdPos.y + _self.spawnRange) - 1)
    lua:getRigidbody(object):setPosition(Vector3(150, rndY, 0.0))  
    lua:getRigidbody(object):setLinearVelocity(Vector3(-_self.xSpeed, 0, 0))
end

spawner["instantiate"] = function(params, entity)
    p = JSON:decode(params)
    local self = {}
    self.entity = entity
    self.spawnObject = "Cohete"
    self.timeToSpawn = 1.5
    self.xSpeed = 500 
    self.spawnRange = 100
    self.slowAcc = 9.8
    self.previousTime = self.timeToSpawn
    self.time = -1
    self.birdPos = nil
    self.spawning = false
    if p ~= nil then
        -- Objeto a spawnear 
        if p.spawnObject ~= nil then
            self.spawnObject = p.spawnObject
        end

        -- Cada cuantos segundos spawnea
        if p.timeToSpawn ~= nil then
            self.timeToSpawn = p.timeToSpawn
        end

        -- Velocidad en x inicial del golpeo
        if p.xSpeed ~= nil then
            self.xSpeed = p.xSpeed
        end

        -- Rango de generacion de Y por debajo del jugador
        if p.spawnRange ~= nil then
            self.spawnRange = p.spawnRange
        end
    end

    self.changeTimeToSpawn = function(x, time)
        self.previousTime = self.timeToSpawn
        self.timeToSpawn = x
        self.time = time
    end

    self.modSpawning = function (s, xSpeed)
        self.spawning = s
        self.xSpeed = xSpeed
    end
    return self
end

spawner["start"] = function(_self, lua)

    -- Seteamos la posicion del spawner para generar los
    -- objetos fuera de la pantalla
    lua:getTransform(_self.entity):setPosition(Vector3(lua:getOgreContext():getWindowWidth(), 0, 0))

    _self.timeSinceSpawn = lua:getInputManager():getTicks()
    _self.birdPos = lua:getTransform(lua:getEntity("Bird")):getPosition()
end

spawner["update"] = function(_self, lua, deltaTime)

    if _self.spawning == true then

        -- Actualizacion de la velocidad
        if _self.xSpeed > 0 then
            _self.xSpeed = _self.xSpeed - _self.slowAcc * deltaTime
        end

        if (_self.xSpeed > 225) and (lua:getInputManager():getTicks() - _self.timeSinceSpawn) / 1000 >= _self.timeToSpawn then
            --print(_self.spawnObject)
            local objectSpawned = lua:instantiate(_self.spawnObject)
            objectSpawned:start()
            createfunc(_self, lua, objectSpawned)

            _self.timeSinceSpawn = lua:getInputManager():getTicks()
        end

        if _self.time > 0 then
            _self.time = _self.time - deltaTime
        else
            _self.timeToSpawn = _self.previousTime

        end
    end
end

return spawner
