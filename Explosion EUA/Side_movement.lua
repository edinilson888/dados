local Side_movement = {}
Side_movement.__index = Side_movement

function newSide_movement(g, vInit, xInit, yInit, yFloor, timeInterval, length)
  
  local a = {}
  
  a.g = g
  a.vInit = vInit
  a.xInit = xInit
  a.yInit = yInit
  a.v = vInit
  a.x = xInit
  a.y = yInit
  a.yFloor = yFloor
  a.timeInterval = timeInterval
  a.length = length
  a.time = 0
  a.ending = false
  
  return setmetatable(a, Side_movement)
  
end 

function Side_movement:update()
  self.time = self.time + self.timeInterval
  
  if (self.y < self.yFloor - self.length) then
    self.v = self.v + self.g * self.time
    self.y = self.y + self.v
    if (self.y > self.yFloor - self.length) then
        self.y = self.yFloor - self.length  
    end
  else
    self.ending = true
  end
  
end

function Side_movement:reInit()
  self.v = self.vInit
  self.x = self.xInit
  self.y = self.yInit
  self.time = 0
end

function Side_movement:getX()
  return self.x
end

function Side_movement:getY()
  return self.y
end

function Side_movement:isEnding()
  return self.ending
end
