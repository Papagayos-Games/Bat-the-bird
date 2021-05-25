local JSON = assert(loadfile "LuaScripts/json.lua")()

local followTarget = {}

followTarget["instantiate"] = function(params, entity)
    p = JSON:decode(params)
    local self = {}
    self.entity = entity
    if p.target ~= nil then
        self.target = p.target
    else
        self.target = "Bird"
    end

    if p.following ~= nil then
        self.following = p.following
    else
        self.following = false
    end
    self.setFollow = function(_follow) self.following = _follow end
    return self
end

followTarget["start"] = function(_self, lua)
    _self.transform = lua:getTransform(_self.entity)
    _self.position = _self.transform:getPosition()
    _self.targetPosition = lua:getTransform(lua:getEntity(_self.target))
                               :getPosition()
end

followTarget["update"] = function(_self, lua)
    if _self.following and _self.target ~= nil then
        _self.transform:setPosition(Vector3(_self.position.x,
                                            _self.targetPosition.y,
                                            _self.position.z))
    end
end

return followTarget
