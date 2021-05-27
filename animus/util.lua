local util = {}
local width, height = 240,136

-- poo renvoie l'objet player pour une raquette
function util.Player(pX, pY, pW, pH, pSpeed)
  local player = {}
  player.x = pX
  player.y= pY
  player.width= pW
  player.height= pH
  player.speedY = pSpeed
  return player
end

-- collision carré
function util.CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

-- Update la position de la balle sur les bords de l'écran
function util.UpdateBall(ball)
  ball.x = ball.x + ball.vitesse_x
  ball.y = ball.y + ball.vitesse_y

  if ball.x < 0 then
    ball.x = 0
    ball.vitesse_x = ball.vitesse_x * -1
  end
  if ball.y < 0 then
    ball.y = 0
    ball.vitesse_y = ball.vitesse_y * -1
  end
  if ball.x > width - ball.radius*2 then
    ball.x =  width - ball.radius2
    ball.vitesse_x = ball.vitesse_x * -1
  end
  if ball.y > height - ball.radius*2 then
    ball.y = height - ball.radius*2
    ball.vitesse_y = ball.vitesse_y * -1
  end

  return ball.x, ball.y, ball.vitesse_x, ball.vitesse_y
end

--update la position de l'IA
function util.UpdateIA(ball, IA, difficulte)

  if (ball.y > IA.y + ball.radius*2 and math.random(0, difficulte) == 1) then
    IA.speedY = 2
  elseif (ball.y < IA.y + ball.radius*2 and math.random(0, difficulte) == 1) then
    IA.speedY = -2
  end
  IA.y = IA.y + IA.speedY

  return IA.y
end

return util