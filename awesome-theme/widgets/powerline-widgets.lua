local wibox = require("wibox")
local lain = require("lain")
local inspect = require("inspect")

local separators = lain.util.separators
local background = wibox.container.background

local colours = require(".vars").colourPalette

function powerlineBarWidget(widgets, direction)
  local bar = {
    layout = wibox.layout.fixed.horizontal,
  }
  local normalisedDirection = direction or "arrow_left"
  local arrow = separators[normalisedDirection]
  
  -- Loop over the widgets
  for index, widget in ipairs(widgets) do
    local colour = colours[index]
    local adjacentColour

    if normalisedDirection == "arrow_left" then
      adjacentColour = colours[index - 1]
    else
      adjacentColour = colours[index + 1]
    end

    if normalisedDirection == "arrow_left" then
      if index == 0 then
        table.insert(bar, arrow("alpha", colour))
      else if index > 0 then
          table.insert(bar, arrow(adjacentColour or "alpha", colour))
        end
      end

      table.insert(bar, background(widget, colour))
  else
    table.insert(bar, background(widget, colour))
print(index, #widgets, offset, index ~= (#widgets - (offset or 0)))
    if index ~= #widgets then
      table.insert(bar, arrow(colour, adjacentColour or "alpha"))
    else
      table.insert(bar, arrow(colour, "alpha"))
    end
  end


  end

  return bar

  --[[
    return { -- Meta info on the right.
      arrow("alpha", colourPalette[3]),
      background(wibox.widget.textclock(), colourPalette[3]),
      arrow(colourPalette[3], colourPalette[4]),
      background(wiBarMargin(batteryWidget.widget), colourPalette[4]),
      background(wibox.container.margin(iconMargin(wibox.widget.imagebox(icons.batteryCharging)), dpi(0), dpi(5)), colourPalette[4]),
      arrow(colourPalette[4], colourPalette[5]),
      background(wiBarMargin(iconMargin(wifi_icon)), colourPalette[5]),
  }
  ]]--
end

return powerlineBarWidget

