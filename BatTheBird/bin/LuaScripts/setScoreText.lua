local JSON = assert(loadfile "LuaScripts/json.lua")()

local UIclase = {}

UIclase["instantiate"] = function (params, entity)
    p = JSON:decode(params)
    local self = {}
    self.entity = entity
    return self
end

UIclase["start"] = function (_self, lua)
    _self.button = lua:getUIButton(_self.entity)
    local s = lua:getLuaSelf(lua:getEntity("gameManager"), "score")
    local text = ""
    for key, value in pairs(s.getScores(s)) do -- actualcode
        text = text .. value .. "\n"
    end
    
    _self.button:setText(text)
end

UIclase["update"] = function (_self, lua) end

return UIclase