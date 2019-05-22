local wibox = require("wibox")
local lain = require("lain")
local markup = lain.util.markup

local typography = require("vars").typography

local function wiBarFont(text)
  return markup.font(typography.mainFont, text)
end

local function wiBarMargin(widget)
  return wibox.container.margin(widget, 5, 5)
end

local function iconMargin(imageWidget)
  return wibox.container.margin(imageWidget, 2, 2, 2, 2)
end

return {
  wiBarFont = wiBarFont,
  wiBarMargin = wiBarMargin,
  iconMargin = iconMargin
}
