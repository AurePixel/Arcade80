local time = {}

time.timer = 0
local tempo = 5--60*5 --5 minute (60s*5)
local dt = 1/60

function time.UpdateTimer()
  time.timer = time.timer + dt
  if time.timer >= tempo then
    time.timer = 0
    return true
  else 
    return false
  end
end

return time