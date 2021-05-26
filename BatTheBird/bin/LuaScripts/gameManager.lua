local gameManager = {}

gameManager["instantiate"] = function(params, entity)
    local self = {}
    self.entity = entity
    self.turnos = 3

    self.pasaTurno = function (lua)
        -- Acumular la puntuacion
        -- Apuntar el turno en un archivo externo
        self.turnos = self.turnos - 1
        print(self.turnos)
        -- local camera = lua:getEntity("defaultCamera")        
        -- -- Resetea la posicion de la camara 
        -- lua:getTransform(camera):setPosition(Vector3(0, 80, 300))
        -- -- La camara deja de seguir al pajaro
        -- lua:getLuaSelf(lua:getEntity("defaultCamera"), "followTarget").setFollow(false)        
        -- self.modSpawners(false, 0)

        if self.turnos <= 0 then
            lua:changeScene("gameOver")
        else
            lua:changeScene("batTheBird")
        end
    end
    return self
end

gameManager["start"] = function(_self, lua)
    -- Aplica otro skyplane
    local ogreContext = lua:getOgreContext()
    ogreContext:setSkyPlane("SkyPlaneMat2", -70, 10,10,0.0)
    lua:getOgreContext():changeMaterialScroll("SkyPlaneMat2", 0, 0)

    -- Tabla con los spawners para activarlos y desactivarlos tras el bateo
    _self.spawners = {}
    table.insert(_self.spawners, lua:getLuaSelf(lua:getEntity("coheteSpawner"), "spawner"))
    table.insert(_self.spawners, lua:getLuaSelf(lua:getEntity("burbujaSpawner"), "spawner"))
    table.insert(_self.spawners, lua:getLuaSelf(lua:getEntity("reboteSpawner"), "spawner"))

    -- Funcion que se llama desde el bateo para ajustar la velocidad en X 
    -- segun la fuerza de bateo y comenzar a spawnear powerups
    _self.modSpawners = function (spawn, xSpeed)
        for key, value in pairs(_self.spawners) do -- actualcode
            value.modSpawning(spawn, xSpeed)
        end
    end

    -- Funcion para aumentar la velocidad de los objetos
    -- spawneados (para simular el impulso en x al pillar un cohete)
    _self.modSpawnersSpeed = function (speed)
        for key, value in pairs(_self.spawners) do -- actualcode
            value.modSpeed(speed)
        end
    end
end

return gameManager

