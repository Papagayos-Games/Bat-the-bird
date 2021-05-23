
local UIclase = {}

UIclase["instantiate"] = function (params, entity)
    --p = JSON:decode(params)
    local self = {}
    self.entity = entity
    return self
end

UIclase["start"] = function (_self, lua)
    _self.button = lua:getUIButton(_self.entity)
end

UIclase["update"] = function (_self, lua)
    if _self.button:getButtonPressed() == true then
        lua:closeApp()
        --_self.button:buttonNotPressed()
    end


end

return UIclase