local thisDir = debug.getinfo( 1, "S" ).source:match( "/.*/" )
local iconBase = thisDir .. "icons/"
local vars = {}
vars.colourPalette = {
  "#ECD078",
  "#D95B43",
  "#C02942",
  "#542437",
  "#53777A",
  "#222222"
}

vars.typography = {
  mainFont = "Fira Mono 11"
}

vars.typographyColours = {
  normal = vars.colourPalette[6],
  light = vars.colourPalette[1],
  unfocused = vars.colourPalette[2],
  urgent = vars.colourPalette[1],
}

vars.icons = {
  batteryCharging = iconBase .. "baseline-battery_charging_full-24px.svg",
  brightness = iconBase .. "baseline-brightness_high-24px.svg",
  wifiWeak = iconBase .. "baseline-signal_wifi_0_bar-24px.svg",
  wifiMid = iconBase .. "baseline-signal_wifi_2_bar-24px.svg",
  wifiGood = iconBase .. "baseline-signal_wifi_4_bar-24px.svg",
  wifiOff = iconBase .. "baseline-signal_wifi_off-24px.svg",
  volumeOn = iconBase .. "baseline-volume_up-24px.svg",
  volumeOff = iconBase .. "ic_volume_off_48px.svg",
}

return vars

