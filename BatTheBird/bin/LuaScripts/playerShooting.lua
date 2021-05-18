local playerShooting = {}

playerShooting["instantiate"] = function(params, entity)
    print("Instantiate: PlayerShooting")

    -- p = JSON:decode(params)
    local self = {}
    self.entity = entity

    -- Por defecto, 1000 iteraciones hasta que se haga el GetTicks
    ---if p.shootBulletTime ~= nil then
    -- self.shootBulletTime = p.speed
    -- else
    --Segundos que tarda en instanciar una bala nueva
    self.shootBulletTime = 1.5
    -- end

    -- Por defecto prefab bala
    -- if p.object ~= nil then
    -- self.object = p.object
    -- else
    self.object = "bullet"
    -- end

    return self
end

playerShooting["start"] = function(_self, lua)
    _self.time = lua:getInputManager():getTicks()
    -- print(_self.time)
    print("Start: PlayerShooting")

end

playerShooting["update"] = function(_self, lua)
    -- print("Update: PlayerShooting")


    if (lua:getInputManager():getTicks() - _self.time)/1000  >= _self.shootBulletTime then
        print("Disparo xD")
        local bala = lua:instantiate(_self.object)
        local pos = lua:getTransform(_self.entity):getPosition()

        lua:getTransform(bala):setPosition(Vector3(pos.x, pos.y, pos.z - 100))
        bala:start()

        _self.time = lua:getInputManager():getTicks()
    end 

end

return playerShooting
