local game = {}
local util = require("../animus/util")
local width, height = 240,136

local playerOne = util.Player(8,10,8,50,2) --(X, Y, W, H, Speed)
local IA = util.Player(width-8,10,8,50,2)

local ball = {}
ball.x = 50
ball.y = 50
ball.radius = 5
ball.vitesse_x = 1
ball.vitesse_y = 1

function game.Load()
  trace("game Load !")
end

function game.Update()
  
  --gestion input
  if btn(2) then -- gauche
    playerOne.y =playerOne.y- playerOne.speedY
  end

  if btn(3) then -- droite
    playerOne.y =playerOne.y+ playerOne.speedY
  end

  --gestion IA
  IA.y = util.UpdateIA(ball, IA, 3)

  --gestion balle
  ball.x, ball.y, ball.vitesse_x, ball.vitesse_y = util.UpdateBall(ball)
  
  --gestion de la collision
  --avec le playerOne
  if util.CheckCollision(ball.x-ball.radius, ball.y-ball.radius, ball.radius*2, ball.radius*2, playerOne.x, playerOne.y, playerOne.width, playerOne.height)then
    ball.vitesse_x = -ball.vitesse_x 
  end
  --avec l'IA
  if util.CheckCollision(ball.x-ball.radius, ball.y-ball.radius, ball.radius*2, ball.radius*2, IA.x, IA.y, IA.width, IA.height)then
      ball.vitesse_x = -ball.vitesse_x
  end

end

function game.Draw()

  rect(playerOne.x, playerOne.y,playerOne.width, playerOne.height, 1) -- playerOne
  rect(IA.x, IA.y,IA.width, IA.height, 1) --IA
  circ(ball.x, ball.y, ball.radius, 1) -- ball
end

return game