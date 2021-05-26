
local barraBateo = {}

barraBateo["instantiate"] = function(params, entity)
    
    local self = {}

    self.entity = entity


    return self
end

barraBateo["start"] = function(_self, lua)
    _self.image = lua:getUIImage(_self.entity)
    _self.batBehaviour = lua:getLuaSelf(lua:getCurrentScene():getEntity("Bird"), "batBehaviour")
end

barraBateo["update"] = function(_self, lua, deltaTime)

    if _self.batBehaviour.time < _self.batBehaviour.botLimit and _self.batBehaviour.time > _self.batBehaviour.topLimit then

        local operacion = _self.batBehaviour.strength * (_self.batBehaviour.sweetspot - (math.abs(_self.batBehaviour.sweetspot - _self.batBehaviour.time)))

        if operacion <= _self.batBehaviour.strength * 0.25 then
            _self.image:setProperty("Image", "TaharezLook/BarraBateo25")
        elseif operacion <= _self.batBehaviour.strength * 0.5 then
            _self.image:setProperty("Image", "TaharezLook/BarraBateo50")
        elseif operacion <= _self.batBehaviour.strength * 0.75 then
            _self.image:setProperty("Image", "TaharezLook/BarraBateo50")  
        elseif operacion <= _self.batBehaviour.strength * 0.9 then
            _self.image:setProperty("Image", "TaharezLook/BarraBateo100")
        end
    else
        _self.image:setProperty("Image", "TaharezLook/BarraBateo0")
    end
end

return barraBateo