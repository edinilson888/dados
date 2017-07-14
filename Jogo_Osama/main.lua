require ("AnAL")

local lose = false 
local nextLevel = 10 
local points = 0
local animMAp = {}

local id = 0
local ID_LIMIT = 10

local function getId( ... )
	id = id + 1
	if (ID == ID_LIMIT ) then
		id = 1
	end
	return id
end

function love.load(  )
	love.window.setTitle("EUA DESTROYER")
	explosion = love.graphics.newImage("imgs/explosion.png")
	imginimigo = love.graphics.newImage("imgs/ball1.png")
	background = love.graphics.newImage("imgs/fundo.png")

	posxInimigo = 800
	posyInimigo = 6
	velocidade = 200
	inimigos = {}
	delayinimigo = 0.4
	tempocriainimigo = delayinimigo
end

function love.mousepressed ( x, y, button, istouch )
	
	local newId = getId()

	animMAp[newId] = {}
	animMAp[newId].x = x
	animMAp[newId].y = y

	animMAp[newId].animation = newAnimation (explosion, 64, 64, 0.1, 0)
	animMAp[newId].animation:setMode("once")
end

function love.update( dt )
	inimigo( dt )
	for i = 1, #animMAp do 
		animMAp[i].animation:update(dt)
	end
end

function inimigo( dt )
	 	tempocriainimigo = tempocriainimigo - (1 * dt )

	 	if tempocriainimigo < 0 then
		tempocriainimigo = delayinimigo
	 	numeroaleatorio = math.random(10, love.graphics.getHeight() + ( (imginimigo:getHeight() / 2 ) + 10) )
	 	novoInimigo = { x = posxInimigo, y = numeroaleatorio, img = imginimigo }
	 	table.insert( inimigos, novoInimigo )
	 	end
	 	
	 	for i, inimigo in ipairs ( inimigos ) do
	 		inimigo.x = inimigo.x -(200 * dt) 
	 		if inimigo.x < 0 then
	 			table.remove (inimigo, i)
	 		end
	 	end
end

function love.draw( )
	love.graphics.draw(background, 0, 0)

	for i, inimigo in ipairs ( inimigos ) do
		love.graphics.draw( imginimigo, inimigo.x, inimigo.y )
	end

	for i = 1, #animMAp do
		if (animMAp[i].animation:isPlaying()) then
			animMAp[i].animation:draw( animMAp[i].x, animMAp[i].y )
		end
	end
end