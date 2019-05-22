local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local vars = require("vars")

-- Make the taglist buttons clickable.
-- More useful than you think.
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local function taglist(s)
  local taglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
    style = {
      shape = gears.shape.powerline
    },
  }

  return taglist
end

return taglist
