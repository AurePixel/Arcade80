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

function util.UpdatePlayerController(player)
  if btn(2) then -- gauche
    player.y =player.y- player.speedY
  end

  if btn(3) then -- droite
    player.y =player.y+ player.speedY
  end
  return player.y
end

return util