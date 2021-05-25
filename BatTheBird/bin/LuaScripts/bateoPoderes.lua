local bateoPoderes = {}

burbuja["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.entity = entity

    if p ~= nil then
        self.friction = p.friction
    else
        self.friction = 1.28
    end

    return self
end

function pordos()
    local score = lua:getLuaSelf(lua:getEntity("GameManager"), "Score")
    score.doble = true;
    -- score.setdoble(true)
end

function abandonaNido()
    local bat = lua:getLuaSelf(lua:getEntity("Bird"), "batBehaviour")
    bat.strength = bat.strength * 2;
    -- bat.setstrength(2)
end

-- function megaGarrote()
--  lua:getTransform("Bate"):setsca
-- bat.strength = bat.strength * 2;
-- bat.setstrength(2)
-- end

return burbuja
