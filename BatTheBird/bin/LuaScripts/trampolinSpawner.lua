local JSON = assert(loadfile "LuaScripts/json.lua")()
local trampolinSpawner = {}

trampolinSpawner["instantiate"] = function(params, entity)
    p = JSON:decode(params)
    local self = {}
    self.entity = entity
    -- Objeto a spawnear
    self.spawnObject = "Trampolin"

    -- Cada cuantos segundos spawnea
    self.timeToSpawn = 4

    -- Velocidad del mundo en X tras el bateo (se aplica desde el bateo)
    self.xSpeed = 100

    -- Rango de alturas entre las que se puede spawnear
    -- el objeto respecto a la altura del jugador
    self.spawnRange = 100

    -- Deceleracion de los objetos spawneados en X
    self.slowAcc = 4.5

    -- Posicion del pajaro
    self.birdPos = nil

    -- Velocidad a la que se dejara de spawnear objetos
    self.speedLimit = 0.0

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

        -- Rango de generacion de Y respecto al jugador
        if p.spawnRange ~= nil then
            self.spawnRange = p.spawnRange
        end

        -- Deceleracion de los objetos spawneados en X
        if p.slowAcc ~= nil then
            self.slowAcc = p.slowAcc
        end

        -- Velocidad a la que se dejara de spawnear objetos
        if p.speedLimit ~= nil then
            self.speedLimit = p.speedLimit
        end


    end

    self.changeTimeToSpawn = function(x, time)
        self.timeToSpawn = x
    end

    -- Funcion para modificar el spawneo y la velocidad
    -- de los objetos spawneados
    self.modSpawning = function(s, xSpeed)
        self.spawning = s
        self.xSpeed = xSpeed
    end

    -- Modifica la velocidad de los objetos spawneados
    self.modSpeed = function(speed)
        self.xSpeed =  self.xSpeed + speed
    end
    return self
end

trampolinSpawner["start"] = function(_self, lua)
    -- Seteamos la posicion del trampolinSpawner para generar los
    -- objetos fuera de la pantalla
    lua:getTransform(_self.entity):setPosition(Vector3(lua:getOgreContext():getWindowWidth(), 0, 0))
    _self.timeSinceSpawn = lua:getInputManager():getTicks()

end

trampolinSpawner["update"] = function(_self, lua, deltaTime)

    if _self.spawning == true then
        -- Actualizacion de la velocidad
        if _self.xSpeed > _self.speedLimit then
            _self.xSpeed = _self.xSpeed - _self.slowAcc * deltaTime
        else
            _self.spawning = false
        end

        if (lua:getInputManager():getTicks() - _self.timeSinceSpawn) / 1000 >= _self.timeToSpawn then
            local objectSpawned = lua:instantiate(_self.spawnObject)
            objectSpawned:start()
            lua:getRigidbody(objectSpawned):setPosition(Vector3(200, 110, 0)) --Fuera de la pantalla y a la altura del suelo
            lua:getRigidbody(objectSpawned):setLinearVelocity(Vector3(-_self.xSpeed, 0, 0))
            _self.timeSinceSpawn = lua:getInputManager():getTicks()
        end

    end

end

return trampolinSpawner
