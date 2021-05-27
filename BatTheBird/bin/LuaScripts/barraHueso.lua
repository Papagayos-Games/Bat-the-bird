local JSON = assert(loadfile "LuaScripts/JSON.lua")()

local barraHueso = {}

barraHueso["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity
    self.active = true
    self.texture = "TaharezLook/BarraHueso"
    if p ~= nil then
        if p.active ~= nil then
            self.active = p.active
        end
        if p.texture ~= nil then
            self.texture = p.texture
        end
    end

    return self
end

barraHueso["start"] = function(_self, lua)
    -- Cogemos la imagen de la barra
    _self.image = lua:getUIImage(_self.entity)
    -- Referencia al pajaro para calcular la posicion de la barra en base a sus parametros
    _self.batBehaviour = lua:getLuaSelf(lua:getCurrentScene():getEntity("Bird"), "batBehaviour")
    _self.image:setProperty("Image", _self.texture .. "0")
    lua:getUIImage(_self.entity):setActive(_self.active)
end

barraHueso["update"] = function(_self, lua, deltaTime)

    if _self.batBehaviour.batted then
        lua:getUIImage(_self.entity):setActive(true)
        -- Calculamos en que "rango" de % de la barra en el que se encuentra
        local operacion = _self.batBehaviour.strength * (_self.batBehaviour.time / _self.batBehaviour.boneRecharge)
        local maxStrenght = _self.batBehaviour.strength * _self.batBehaviour.range

        if operacion <= maxStrenght * 0.25 then
            _self.image:setProperty("Image", _self.texture .. "25")
        elseif operacion <= maxStrenght * 0.5 then
            _self.image:setProperty("Image", _self.texture .. "50")
        elseif operacion <= maxStrenght * 0.75 then
            _self.image:setProperty("Image", _self.texture .. "75")
        elseif operacion <= maxStrenght * 0.9 then
            _self.image:setProperty("Image", _self.texture .. "100")
        end
    else
        lua:getUIImage(_self.entity):setActive(false)

    end

end

return barraHueso
