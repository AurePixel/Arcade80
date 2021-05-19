local game = {}

local width, height = 240,136

local playerOne = {}
playerOne.x = 10
playerOne.width= 50
playerOne.height= 8
playerOne.y= 136-playerOne.height
playerOne.speed = 2

local IA = {}
IA.x = 10
IA.width= 50
IA.height= 8
IA.y= IA.height
IA.speed = 2
IA.speedX = 2

local ball = {}
ball.x = 10
ball.y = 50
ball.width = 10
ball.height = 10
ball.vitesse_x = 1
ball.vitesse_y = 1

function game.Load()
  trace("game Load !")
end

function game.Update()
  
  --gestion input
  if btn(2) then -- gauche
    playerOne.x =playerOne.x- playerOne.speed 
  end

  if btn(3) then -- droite
    playerOne.x =playerOne.x+ playerOne.speed 
  end

  --gestion IA
  local difficulte = 5 -- plus la var est grande plus l'IA est fort

  if (ball.x > IA.x + ball.width / 2 and math.random(0, difficulte) == 1) then
    IA.speedX = 2
  elseif (ball.x < IA.x + ball.width / 2 and math.random(0, difficulte) == 1) then
    IA.speedX = -2
  end
  IA.x = IA.x + IA.speedX

  --gestion balle
  ball.x = ball.x + ball.vitesse_x
  ball.y = ball.y + ball.vitesse_y

  if ball.x < 0 then
    ball.vitesse_x = ball.vitesse_x * -1
  end

  if ball.y < 0 then
    ball.vitesse_y = ball.vitesse_y * -1
  end
  if ball.x > width - ball.width then
    ball.vitesse_x = ball.vitesse_x * -1
  end
  if ball.y > height - ball.height then
    ball.vitesse_y = ball.vitesse_y * -1
  end
  
  --gestion de la collision
  --avec le playerOne
  if ball.y == playerOne.y - ball.height/2 then
    if ball.x > playerOne.x and ball.x < playerOne.x + playerOne.width then
      ball.vitesse_y = ball.vitesse_y * -1
    end
  end
  --avec l'IA
  if ball.y == IA.y + ball.height then
    if ball.x > IA.x and ball.x < IA.x + playerOne.width then
      ball.vitesse_y = ball.vitesse_y * -1
    end
  end

end

function game.Draw()

  rect(playerOne.x, playerOne.y,playerOne.width, playerOne.height, 1) -- playerOne
  rect(IA.x, IA.y,IA.width, IA.height, 1) --IA
  circ(ball.x, ball.y, ball.width/2, 1) -- ball
end

return game