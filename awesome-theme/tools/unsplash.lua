local spawn = require("awful.spawn")
local UNSPLASH_API_KEY = os.getenv("UNSPLASH_API_KEY")

if type(UNSPLASH_API_KEY) ~= nil then
  local getRandomWallpaperCmd = "curl https://api.unsplash.com/search/photos/?client_id=" .. UNSPLASH_API_KEY .. "&query=80s | jq .results | jq 'map(.urls.full)'"

  print(spawn(getRandomWallpaperCmd))
end
