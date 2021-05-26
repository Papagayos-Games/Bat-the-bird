local gameManager = {}

gameManager["instantiate"] = function(params, entity)
    local self = {}
    self.entity = entity
    return self
end

gameManager["start"] = function(_self, lua)
    local ogreContext = lua:getOgreContext()
    ogreContext:setSkyPlane("SkyPlaneMat2", -70, 10,10,0.0)
    ogreContext:changeMaterialScroll("SkyPlaneMat2", -0.1, 0)
    _self.spawners = {}

    table.insert(_self.spawners, lua:getLuaSelf(lua:getEntity("coheteSpawner"), "spawner"))
    table.insert(_self.spawners, lua:getLuaSelf(lua:getEntity("burbujaSpawner"), "spawner"))
    table.insert(_self.spawners, lua:getLuaSelf(lua:getEntity("reboteSpawner"), "spawner"))
    _self.modSpawners = function (spawn, xSpeed)
        for key, value in pairs(_self.spawners) do -- actualcode
            value.modSpawning(spawn, xSpeed)
        end
    end
end

-- Si el ave colisiona con el cohete recibe un impulso
gameManager["onCollisionEnter"] = function(_self, lua, other)
    lua:getCurrentScene():destroyEntity(_self.entity)
end

return gameManager

