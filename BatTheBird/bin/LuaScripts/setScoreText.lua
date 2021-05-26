local JSON = assert(loadfile "LuaScripts/json.lua")()

local UIclase = {}

UIclase["instantiate"] = function (params, entity)
    p = JSON:decode(params)
    local self = {}
    self.entity = entity

    if not p then return self end

    if p.fileName ~= nil then self.fileName = p.fileName end

    if p.maxScores ~= nil then self.maxScores = p.maxScores end
    
    return self
end

UIclase["start"] = function (_self, lua)
    _self.button = lua:getUIButton(_self.entity)
    local s = lua:getLuaSelf(lua:getEntity("ScoreBoardPref"), "score")
    local text = ""
    for key, value in pairs(s.getScores(s)) do -- actualcode
        text = text .. value .. "\n"
    end
    
    _self.button:setText(text)
end

UIclase["update"] = function (_self, lua) end

return UIclase