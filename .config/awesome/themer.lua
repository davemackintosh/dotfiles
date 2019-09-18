local JSON = require "cjson"
local awesomePath = os.getenv("HOME") .. "/.config/awesome"

local function getJSON(filename)
  local file = io.open(awesomePath .. filename, "r")
  return JSON.decode(file:read("*a"))
end

local function setBackground(value)
  if string.sub(vars.wallpaper, 1, 1) == "#" then
  end
end

local function Promise(callback)

end

return {
  awesomePath = awesomePath,
  getJSON = getJSON,
}
