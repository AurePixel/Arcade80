local gameState = {}

gameState.currentScene = nil

-- Change la scene du jeu 
-- string pScene 
function gameState.ChangeScene(pScene)
  gameState.currentScene = require("scenes/"..pScene)
  gameState.currentScene.Load()
end

return gameState