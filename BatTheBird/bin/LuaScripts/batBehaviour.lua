local keys = assert(loadfile "LuaScripts/keycode.lua")()
local JSON = assert(loadfile "LuaScripts/JSON.lua")()
local batBehaviour = {}

batBehaviour["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}

    -- Referencias a componentes
    self.entity = entity
    self.transform = nil
    self.rb = nil

    -- Posicion inicial para resetar el turno
    self.startPos = nil

    -- Contador del tiempo desde que cae el pajaro
    self.time = 0

    -- Contador del tiempo que pasa desde que se puede batear hasta que no
    self.batTime = 0

    -- Variable que indica si el jugador ha bateado
    self.batted = false

    -- Variable que representa si el jugador tiene un escudo obtenido por un PelotaRebote
    self.escudo = false

    -- Fuerza aplicada al pajaro en Y
    self.strength = 20.0

    -- Multiplicador a la fuerza en X respecto a la fuerza en Y
    self.xFactor = 10.0

    -- Tiempo desde que cae el pajaro en el que la fuerza sera maxima
    self.sweetspot = 3.0

    -- Contador de rebotes 
    self.bounces = 0
    self.maxBounces = 2
    
    -- Factor para reducir la recuperacion de hueso
    self.boneFactor = 0.2

    -- Segundos en los que se recargara el hueso
    self.boneRecharge = 5.0

    -- Para impedir el hueso antes de batear
    self.allowBone = false

    -- Parametros personalizados desde json
    if p ~=nil then
        if p.strength ~= nil then
            self.strength = p.strength
        end
        if p.xFactor ~= nil then
            self.xFactor = p.xFactor
        end
        if p.sweetspot ~= nil then
            self.sweetspot = p.sweetspot
        end
        if p.boneFactor ~= nil then
            self.boneFactor = p.boneFactor
        end
        if p.boneRecharge ~= nil then
            self.boneRecharge = p.boneRecharge
        end
    end
        
    -- Variable que indica el rango de tiemo en el que se podrá batear
    -- margen de tiempo de 2 segundos para batear
    self.range = 1.0

    -- Auxiliar para comprobar si pasamos el sweetspot de golpeo
    self.passHighestStrenght = false;

    -- Variables para limitar los tiempos entre los que se puede batear
    self.topLimit = self.sweetspot - self.range
    self.botLimit = self.sweetspot + self.range

    return self
end

batBehaviour["start"] = function(_self, lua)
    _self.transform = lua:getTransform(_self.entity)
    local aux = _self.transform:getPosition()
    _self.startPos = Vector3(aux.x, aux.y, aux.z)
    _self.rb = lua:getRigidbody(_self.entity)
end

batBehaviour["update"] = function(_self, lua, deltaTime)
    local input = lua:getInputManager()

    if input:mouseButtonPressed() == 1 then
        -- Controla el bateo dentro del rango de tiempo y su fuerza segun como de cerca se encuentre el golpeo del sweetspot
        if not _self.batted and (_self.time < _self.botLimit and _self.time > _self.topLimit) then

            -- Se calcula y se aplica la fuerza en el pajaro y los objetos spawneados
            local strength = _self.strength * _self.batTime
            _self.rb:addForce1(Vector3(0, strength, 0), Vector3(0, 0, 0), 1)          
            lua:getLuaSelf(lua:getEntity("gameManager"), "gameManager").modSpawners(true, _self.xFactor * strength) --velocidad en x inicial de los spawners
            
            -- La camara pasa a seguir al pajaro
            local cameraFollow = lua:getLuaSelf(lua:getEntity("defaultCamera"), "followTarget")
            cameraFollow.setFollow(true)

            --Añadimos scroll a la textura del skyplane para simular desplazamiento en z
            lua:getOgreContext():changeMaterialScroll("SkyPlaneMat2", -0.1, 0)
            lua:getOgreContext():changeMaterialScroll("cesped_MAT", -0.1, 0)

            lua:playSound("Assets/Music/Impact.wav")

            _self.batted = true
            _self.allowBone = true
            _self.time =  0

        -- Controla el uso del hueso de la suerte siempre que tenga carga
        else
            if _self.allowBone and _self.time > 0 then
                _self.rb:addForce1(Vector3(0, _self.strength * _self.boneFactor, 0),
                                   Vector3(0, 0, 0), 0)
                _self.time = _self.time - deltaTime
            end
        end
    else
        -- Ajuste del tiempo de bateo para usar la fuerza maxima en el sweetspot
        if not _self.batted then
            _self.time = _self.time + deltaTime
            if _self.time < _self.botLimit and _self.time > _self.topLimit then
                
                if _self.passHighestStrenght then
                    _self.batTime =  _self.batTime - deltaTime
                else
                    _self.batTime =  _self.batTime + deltaTime
                    _self.passHighestStrenght = _self.batTime >= _self.range  
                end
            
            end
        -- Recarga del hueso de la suerte cuando no se usa
        elseif _self.time < _self.boneRecharge then
            _self.time = _self.time + deltaTime
            --print(_self.time)
        end
    end
end

-- Si toca el suelo no puede batear mas y se cambiara el turno
batBehaviour["onCollisionEnter"] = function(_self, lua, other)
    if other:getName() == "floor" then
        if _self.escudo == true then
            lua:getRigidbody(other):addForce1(Vector3(0, _self.strength, 0), Vector3(0, 0, 0), 1)
            _self.escudo = false
        end
        
        _self.bounces = _self.bounces + 1
        if(_self.bounces >= _self.maxBounces) then
            lua:playSound("Assets/Music/WinTheme.wav")
            lua:changeScene("gameOver")
            lua:getLuaSelf(lua:getEntity("gameManager"), "score").registerScore()
        end
        _self.batted = true
    end
end

return batBehaviour
