local JSON = assert(loadfile "LuaScripts/json.lua")()

local score = {}

score["instantiate"] = function(params, entity)
    local p = JSON:decode(params)
    local self = {}
    self.scores = {}
    self.actualScore = 0
    self.maxScores = 3
    self.lastScore = 0
    self.fileName = "Scores.txt"
    self.path = "\\Assets\\"

    if p ~= nil then

    if p.fileName ~= nil then self.fileName = p.fileName end

    if p.maxScores ~= nil then self.maxScores = p.maxScores end

    end

    local f = assert(io.popen "cd")
    local current_dir = f:read '*l'
    assert(f:close())

    local path_ = current_dir .. self.path .. self.fileName

    local file = assert(io.open(path_))

    if file == nil then
        print("No se ha podido abrir el archivo " .. self.path .. self.fileName)
        local fileCre = assert(io.open(path_, "w"))
        print("archivo creado" .. self.path .. self.fileName)
        assert(fileCre:close())
        return
    end

    local i = 0
    
    self.lastScore = file:read("*l")

    for line in file:lines() do
        table.insert(self.scores, tonumber(line));
        i = i + 1
        if i >= self.maxScores then break end
    end
    assert(file:close())

    for key, value in pairs(self.scores) do -- actualcode
        print("[" .. key .. "] " .. value)
    end

    self.getActualScore = function()
        return self.actualScore
    end

    self.setActualScore = function(score)
        self.actualScore = score
    end

    self.getLastScore = function()
        return self.lastScore
    end

    self.addScore = function(score)
        self.actualScore = self.actualScore + score
    end

    self.getScores = function()
        return self.scores
    end
    
    self.registerScore = function()
        table.insert(self.scores, tonumber(self.actualScore))
        table.sort(self.scores, function(a, b) return a > b end)
        local count = 0
        for _ in pairs(self.scores) do count = count + 1 end
        if count > self.maxScores then
            table.remove(self.scores, count)
        end

        local f = assert(io.popen "cd")
        local current_dir = f:read '*l'
        assert(f:close())
    
        local path_ = current_dir .. self.path .. self.fileName
    
        local file = assert(io.open(path_, "w"))
        if file == nil then
            print("No se ha podido abrir el archivo " .. self.path .. self.fileName)
            return
        end

        file:write(self.actualScore .. "\n")

        for key, value in pairs(self.scores) do -- actualcode
            file:write(value .. "\n")
        end

        assert(file:close())
    end

    return self
end

score["start"] = function(_self, lua) end

score["update"] = function(_self, lua) end

return score
