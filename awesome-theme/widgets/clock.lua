local wibox = require("wibox")
local vars = require("vars")
local markup = require("lain").util.markup

local clock = wibox.widget.textclock(markup.fontfg(vars.mainFont, vars.typographyColours.normal, "%a %d %b %H:%M%P"), 60)

return clock
