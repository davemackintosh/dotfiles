-- Taken from https://github.com/lcpz/awesome-copycats/blob/master/themes/powerarrow/theme.lua
local wibox = require("wibox")
local lain = require("lain")
local awful = require("awful")
local path_this = debug.getinfo( 1, "S" ).source:match( "/.*/" )
local theme = require(path_this .. "../theme")

local modkey = "Mod4"

local widget = {}

local musicplr = awful.util.terminal .. " -title Music -g 130x34-320+16 -e ncmpcpp"
widget.mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
    awful.button({ }, 1, function ()
        os.execute("mpc prev")
        theme.mpd.update()
    end),
    awful.button({ }, 2, function ()
        os.execute("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ }, 3, function ()
        os.execute("mpc next")
        theme.mpd.update()
    end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            -- mpdicon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#FF8466", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font, " mpd paused "))
            -- mpdicon:set_image(theme.widget_music_pause)
        else
            widget:set_text("")
            -- mpdicon:set_image(theme.widget_music)
        end
    end
})

return widget

