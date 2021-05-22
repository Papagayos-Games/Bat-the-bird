local JSON = assert(loadfile "LuaScripts/json.lua")()

local UIclase = {}

UIclase["instantiate"] = function (params, entity)
    p = JSON:decode(params)
    local self = {}
    self.entity = entity
    
    if p.scene ~= nil then
        self.scene = p.scene
    else
        self.scene = "testScene"
    end
    
    return self
end

UIclase["start"] = function (_self, lua)
    _self.button = lua:getUIButton(_self.entity)
end

UIclase["update"] = function (_self, lua)
    if _self.button:getButtonPressed() == true then
        lua:changeScene(_self.scene)
        _self.button:buttonNotPressed()
    end


end

return UIclase