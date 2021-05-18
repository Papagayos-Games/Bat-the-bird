local JSON = assert(loadfile "LuaScripts/json.lua")()
local keys = assert(loadfile "LuaScripts/keycode.lua")()

--CLASE PLAYERCONTROLLER
local playerController = {}

playerController["instantiate"] = function (params, entity)
    print("Instantiate: playerController")
    p = JSON:decode(params)
    local self = {}
    self.entity = entity

    --Si se olvida asignar la velocidad se pone 1 por defecto
    if p.speed ~= nil then
        self.speed = p.speed
    else
        self.speed = 1
    end
    
    return self
end

playerController["start"] = function (_self, lua)
    print("Start: playerController")

    --Cogemos el transform y el rigidbody del objeto
    _self.transform =  lua:getTransform(_self.entity)
    _self.rigidbody = lua:getRigidbody(_self.entity)
    _self.position = _self.transform:getPosition()

    --Tamaño de la ventana en Y
    _self.limitY = lua:getOgreContext():getWindowHeight()
    print(_self.limitY)

    --Camara principal de la escena
    _self.mainCamera = lua:getCamera(lua:getEntity("defaultCamera"))


    --Posicion del pinguino en el viewport
    _self.screenPosition = _self.mainCamera:getScreenCoordinates(_self.position)
    --print("Start: despues screen coordinates")

    _self.mouseX = lua:getInputManager():getMouseX()
    _self.mouseY = lua:getInputManager():getMouseY()
    --print("Coger Raton")
end

playerController["update"] = function (_self, lua)
    --print("Update: playerController")
    
    --Cogemos la posicion del raton
    _self.mouseX = lua:getInputManager():getMouseX()
    _self.mouseY = lua:getInputManager():getMouseY()
    
    --Cogemos la posicion del jugador
    _self.position = _self.transform:getPosition()

    --La proyectamos sobre el viewport
    _self.screenPosition = _self.mainCamera:getScreenCoordinates(_self.position)

    --Direccion hacia la que tenemos que mover al jugador
    dir =  Vector3( _self.mouseX - _self.screenPosition.x,  (_self.limitY - _self.mouseY) - _self.screenPosition.y, 0)
    mag = dir:normalize()


    --Para que si nos pasamos al ponerle demasiada velocidad no "vibre"
    if mag < 2 then dir = Vector3(0,0,0) end


    --Desplazamos
    _self.rigidbody:setPosition(Vector3(_self.position.x + dir.x * _self.speed, _self.position.y + dir.y * _self.speed  ,_self.position.z))
end

return playerController