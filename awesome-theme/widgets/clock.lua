local wibox = require("wibox")
local vars = require("vars")
local utils = require("utils")

local clock = wibox.widget.textclock(utils.wiBarFont("%a %d %b %H:%M%P"), 60)

return clock
