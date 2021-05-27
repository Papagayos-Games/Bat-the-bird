local JSON = assert(loadfile "LuaScripts/json.lua")()

local UIScore = {}

UIScore["instantiate"] = function(params, entity)
    p = JSON:decode(params)
    local self = {}
    self.entity = entity

    if p then
        if p.actualScore ~= nil then self.actualScore = p.actualScore end
    end
    
    -- Llamar a esta funcion cuando se destruya un enemigo para sumar el score y
    -- se actualice en pantalla
    self.updateScoreText = function(score)
        self.button:setText(score)
    end

    return self
end

UIScore["start"] = function(_self, lua)
    local ogreContext = lua:getOgreContext()
    ogreContext:setSkyPlane("SkyPlaneMat", -70, 10,10,0.0)

    _self.button = lua:getUIButton(_self.entity)
    local s = lua:getLuaSelf(_self.entity, "score")
    local text = s.getLastScore()
    _self.button:setText(text)
end

UIScore["update"] = function(_self, lua) end

return UIScore
