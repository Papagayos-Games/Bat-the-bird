local JSON = assert(loadfile "LuaScripts/json.lua")()

local UIScore = {}

UIScore["instantiate"] = function(params, entity)
    p = JSON:decode(params)
    local self = {}
    self.entity = entity
	--Contador del sistema para sumar puntos en función del tiempo--
	self.ticks = 0
	--Limite de ticks a partir del cual se suma 1 punto--
	self.ticksLimit = 15
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
    _self.button = lua:getUIButton(_self.entity)
    local s = lua:getLuaSelf(lua:getEntity("gameManager"), "score")
    local text = s.getActualScore()
    _self.button:setText(text)
    _self.batBehaviour = lua:getLuaSelf(lua:getEntity("Bird"), "batBehaviour")
end

UIScore["update"] = function(_self, lua)
    if _self.batBehaviour.batted == true then
	    _self.ticks = _self.ticks + 1
        if _self.ticks >= _self.ticksLimit then
            local sc = lua:getLuaSelf(lua:getEntity("gameManager"), "score")
            sc.addScore(1)
            _self.updateScoreText(sc.getActualScore())
            _self.ticks = 0;
        end	
    end

end

return UIScore
