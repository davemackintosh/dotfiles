local gears = require("gears")
local vars = require("vars")
local sysTheme = require("beautiful.xresources").get_current_theme()

-- Notification theme vars.
--
-- notification_font
-- notification_bg
-- notification_fg
-- notification_border_width
-- notification_border_color
-- notification_shape
-- notification_opacity
-- notification_margin
-- notification_width
-- notification_height


local notificationStyles = {
  notification_shape = gears.shape.rounded_rect,
  notification_bg = string.sub(sysTheme.background, -7), -- Because in all liklihood, there's transparency
  notification_fg = sysTheme.foreground,
  notification_margin = 15,
  notification_font = vars.typography.mainFont,
  notification_spacing = 10
}

return notificationStyles

