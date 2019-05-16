local wibox = require("wibox")
local lain = require("lain")
local inspect = require("inspect")
local icons = require("vars").icons

local wifi_icon = wibox.widget.imagebox(icons.wifiOff)
local eth_icon = wibox.widget.imagebox()
local net = lain.widget.net {
    notify = "off",
    wifi_state = "on",
    eth_state = "on",
    settings = function()
        local eth0 = net_now.devices.eth0
        if eth0 then
            if eth0.ethernet then
                eth_icon:set_image(ethernet_icon_filename)
            else
                eth_icon:set_image()
            end
        end

        local wlan0 = net_now.devices.wlp2s0

        if wlan0 then
            if wlan0.wifi then
                local signal = wlan0.signal
                if signal < -83 then
                    wifi_icon:set_image(icons.wifiWeak)
                elseif signal < -70 then
                    wifi_icon:set_image(icons.wifiMid)
                elseif signal < -53 then
                    wifi_icon:set_image(icons.wifiGood)
                elseif signal >= -53 then
                    wifi_icon:set_image(icons.wifiGood)
                end
            else
                wifi_icon:set_image()
            end
        end
    end
}

return wifi_icon 

