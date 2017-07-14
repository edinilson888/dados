require("balls")

local lose = false
local nextLevel = 10
local points = 0
local balls = nil
local music = nil
local background = nil


function love.load()
  love.window.setTitle("Explosion EUA")
  math.randomseed(os.time())
  balls = newBalls(3, 30)
  balls:initAllBalls()
  
  
  background = love.graphics.newImage("imgs/fundo.png")
  
  music = love.audio.newSource("sound/blast_off.mp3", "stream")
  music:setLooping(true)
  love.audio.play(music)
end

function love.update(dt)
  lose = balls:updateBalls(dt)
end

function love.mousepressed(x, y, button, istouch)
  points = points + balls:checkClickBalls(x, y)
  
  if (points >= nextLevel) then
    balls:IncNumBalls()
    nextLevel = nextLevel + 10
  end
  
  if (lose == true) then
    balls:reinit()
    lose = false
    points = 0
    nextLevel = 10
  end
  
end

function love.draw()
  
  love.graphics.draw(background, 0, 0)
  
  if (lose == false) then
    balls:drawBalls()
  else
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print("FIM DE JOGO", 350, 300)
  end
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.print("PONTOS: " .. points, 700, 400)
  love.graphics.setColor(255, 255, 255, 255)
end