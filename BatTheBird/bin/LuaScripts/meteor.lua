local meteor = {}

meteor["instantiate"] = function(params, entity)
  print("Instantiate: PlayerShooting")

  local self = {}
  self.shootBulletTime = 100
  self.object = "meteorito"
  self.entity = entity
  return self
end

meteor["start"] = function(_self, lua)
  local z = lua:getTransform(lua:getEntity("testScene2")):getPosition().z
  local v3 = Vector3(math.random(-400, 400), math.random(-300, 300), -50)
  print(v3.x)
  print(v3.y)
  print(v3.z)
  if lua:getEntity("testScene3") == nil then
    print("ayyy es nulo ")
  else
    lua:getRigidbody(lua:getEntity("testScene3")):setPosition(v3)
  end
  
  local v2 = lua:getTransform(lua:getEntity("testScene2")):getPosition()
  local resta = Vector3(v2.x - v3.x, v2.y - v3.y, v2.z - v3.z)
  print(resta.x)
  print(resta.y)
  print(resta.z)
  resta:normalize()
  print(resta.x)
  print(resta.y)
  print(resta.z)
  lua:getRigidbody(lua:getEntity("testScene3")):setLinearVelocity(
    Vector3(resta.x * 1000, resta.y * 1000, resta.z * 10000))

  _self.time = 0
  print(_self.time)
  print("Start: meteorito")

end

meteor["update"] = function(_self, lua)
    --  print(lua:getTransform(lua:getEntity("testScene3")):getPosition().z)
  if lua:getTransform(lua:getEntity("testScene3")):getPosition().z > lua:getTransform(lua:getEntity("testScene2")):getPosition().z then
    print("Destruyeme xD")
    _self.time = 0
  end

end

return meteor
