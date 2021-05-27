local barraBateo = {}

barraBateo["instantiate"] = function(params, entity)

    local self = {}
    self.entity = entity
    return self
end

barraBateo["start"] = function(_self, lua)
    -- Cogemos la imagen de la barra
    _self.image = lua:getUIImage(_self.entity)
    -- Referencia al pajaro para calcular la posicion de la barra en base a sus parametros
    _self.batBehaviour = lua:getLuaSelf(lua:getCurrentScene():getEntity("Bird"),
                                        "batBehaviour")
    _self.image:setProperty("Image", "TaharezLook/BarraBateo0")
end

barraBateo["update"] = function(_self, lua, deltaTime)

    if _self.batBehaviour.batted == _self.showWhenBatted then
        -- Si el pájaro aun está a rango de ser bateado
        if _self.batBehaviour.time < _self.batBehaviour.botLimit and
            _self.batBehaviour.time > _self.batBehaviour.topLimit then

            -- Calculamos en que "rango" de % de la barra en el que se encuentra
            local operacion = _self.batBehaviour.strength *
                                  _self.batBehaviour.batTime
            local maxStrenght = _self.batBehaviour.strength *
                                    _self.batBehaviour.range

            if operacion <= maxStrenght * 0.25 then
                _self.image:setProperty("Image", "TaharezLook/BarraBateo25")
            elseif operacion <= maxStrenght * 0.5 then
                _self.image:setProperty("Image", "TaharezLook/BarraBateo50")
            elseif operacion <= maxStrenght * 0.75 then
                _self.image:setProperty("Image", "TaharezLook/BarraBateo75")
            elseif operacion <= maxStrenght * 0.9 then
                _self.image:setProperty("Image", "TaharezLook/BarraBateo100")
            end
        else
            -- Si ya no esta a rango, asignamos el minimmo
            _self.image:setProperty("Image", "TaharezLook/BarraBateo0")
        end
    end

end

return barraBateo
