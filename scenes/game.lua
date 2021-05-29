local game = {}
local _util = require("../animus/util")
local _time = require("../animus/time")
local _ball = require("../animus/ball")
local width, height = 240,136
local endOfGame = false
local updateGame = false
local playerOne = _util.Player(8,10,8,50,2) --(X, Y, W, H, Speed)
local IA = _util.Player(width-8,10,8,50,2)
local ball = _ball.Ball(50,50,5,1,1) --(pX, pY, pRadius, vitesse_x, vitesse_y)
local score = {playerOne=0, IA=0}
local txtWinner = ""

function LoadGame()
  score = {playerOne=0, IA=0}
  playerOne = _util.Player(8,10,8,50,2) --(X, Y, W, H, Speed)
  IA = _util.Player(width-8,10,8,50,2)
  ball = _ball.Ball(50,50,5,1,1) --(pX, pY, pRadius, vitesse_x, vitesse_y)
  endOfGame = false
  updateGame = false
end
--gameloop load/update/draw
function game.Load()
  LoadGame()
  trace("game Load !")
end

function game.Update()
  if endOfGame == false then

    --gestion input
    playerOne.y = _util.UpdatePlayerController(playerOne)

    --gestion IA
    IA.y = _util.UpdateIA(ball, IA, 3)

    --gestion balle
    ball.x, ball.y, ball.vitesse_x, ball.vitesse_y, updateGame, score = _ball.UpdateBall(ball, updateGame, "PlayerOne", playerOne, score) --(ball, updateGame, namePlayer, player, score)
    
    --gestion de la collision
    --avec le playerOne
    if _util.CheckCollision(ball.x-ball.radius, ball.y-ball.radius, ball.radius*2, ball.radius*2, playerOne.x, playerOne.y, playerOne.width, playerOne.height) then
      ball.vitesse_x = -ball.vitesse_x 
    end
    --avec l'IA
    if _util.CheckCollision(ball.x-ball.radius, ball.y-ball.radius, ball.radius*2, ball.radius*2, IA.x, IA.y, IA.width, IA.height) then
        ball.vitesse_x = -ball.vitesse_x
    end

    if updateGame then
      --gestion _timer
      endOfGame = _time.UpdateTimer()
    end

    if btn(4)then  --Z
      updateGame = true
    end
  else
      if score.playerOne > score.IA then
          txtWinner = "PlayerOne WIN"
      elseif  score.playerOne < score.IA then
          txtWinner = "IA WIN"
      else
        txtWinner = "Nobody WIN"
      end
      if btn(5) then game.Load() end --X
  end
end

function game.Draw()

  rect(playerOne.x, playerOne.y,playerOne.width, playerOne.height, 1) -- playerOne
  rect(IA.x, IA.y,IA.width, IA.height, 1) --IA
  circ(ball.x, ball.y, ball.radius, 1) -- ball
  print(score.playerOne,0,0,15)
  print(score.IA,width-50,0,15)
  print(math.floor(500-_time.timer), width/2-10, 10, 15)

  if endOfGame then
    print(txtWinner, width/2-10, height/2-10, 15)
    print("Veux tu rejouer ?")
  end
end

return game