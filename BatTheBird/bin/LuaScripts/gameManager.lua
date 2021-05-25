local gameManager = {}

gameManager["instantiate"] = function (params, entity)
    --p = JSON:decode(params)
    local self = {}
    return self
end

gameManager["start"] = function (_self, lua)
    local ogreContext = lua:getOgreContext()
    ogreContext:setSkyPlane("SkyPlaneMat", -70, 10,10,0.0)
    ogreContext:changeMaterialScroll("SkyPlaneMat", -0.1, 0)
end

gameManager["update"] = function (_self, lua)
end

return gameManager