local gameManager = {}

gameManager["instantiate"] = function(params, entity)
    local self = {}
    self.entity = entity
    return self
end

gameManager["start"] = function(_self, lua)
    -- Aplica otro skyplane
    local ogreContext = lua:getOgreContext()
    ogreContext:setSkyPlane("SkyPlaneMat2", -70, 10,10,0.0)
    lua:getOgreContext():changeMaterialScroll("SkyPlaneMat2", 0, 0)
    lua:getOgreContext():changeMaterialScroll("cesped_MAT", 0, 0)

    -- Tabla con los spawners para activarlos y desactivarlos tras el bateo
    _self.spawners = {}
    table.insert(_self.spawners, lua:getLuaSelf(lua:getEntity("coheteSpawner"), "spawner"))
    table.insert(_self.spawners, lua:getLuaSelf(lua:getEntity("burbujaSpawner"), "spawner"))
    table.insert(_self.spawners, lua:getLuaSelf(lua:getEntity("reboteSpawner"), "spawner"))
    table.insert(_self.spawners, lua:getLuaSelf(lua:getEntity("trampolinSpawner"), "trampolinSpawner"))



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

