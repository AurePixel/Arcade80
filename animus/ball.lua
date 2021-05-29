local ball = {}
local width, height = 240,136

-- poo renvoie l'objet ball pour une balle

function ball.Ball(pX, pY, pRadius, vitesse_x, vitesse_y)
  local ball = {}
  ball.x = 50
  ball.y = 50
  ball.radius = 5
  ball.vitesse_x = 1
  ball.vitesse_y = 1
  return ball
end

-- Update la position de la balle sur les bords de l'écran
function ball.UpdateBall(ball, updateGame, namePlayer, player,score)

  if updateGame == true then
    ball.x = ball.x + ball.vitesse_x
    ball.y = ball.y + ball.vitesse_y

    if ball.x < 0 then
      ball.x = 0
      ball.vitesse_x = ball.vitesse_x * -1
      updateGame = false
      score.IA = score.IA + 1
    end
    if ball.y < 0 then
      ball.y = 0
      ball.vitesse_y = ball.vitesse_y * -1
    end
    if ball.x > width - ball.radius*2 then
      ball.x =  width - ball.radius*2
      ball.vitesse_x = ball.vitesse_x * -1
      updateGame = false
      score.playerOne = score.playerOne + 1
    end
    if ball.y > height - ball.radius*2 then
      ball.y = height - ball.radius*2
      ball.vitesse_y = ball.vitesse_y * -1
    end
  else
      if namePlayer == "PlayerOne" then
        ball.x = player.x + player.width + ball.radius
        ball.y = player.y + player.height/2
      elseif namePlayer == "" then
        
      end
  end

  return ball.x, ball.y, ball.vitesse_x, ball.vitesse_y, updateGame, score
end

return ball