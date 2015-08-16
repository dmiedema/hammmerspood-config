-- Helers
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == '.lua' then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
-- hs.notify.new({title = 'Hammerspoon', subTitle = "Config loaded"}):send():release()
hs.alert.show("Config (re)loaded")

-- Window Functions
hs.hotkey.bind({"alt"}, "Z", function()
  local focusedApplication = hs.window.focusedWindow():application()
  local zoomMenuItem = {"Window", "Zoom"}
  -- Toggle 'zoom'
  focusedApplication:selectMenuItem(zoomMenuItem)
end)

-- Wifi events
local wifiWatcher = nil
local homeSSID = "miedema"
local lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
  newSSID = hs.wifi.currentNetwork()

  if newSSID == homeSSID and lastSSID ~= homeSSID then
    -- Just joined home Wifi network
    hs.audiodevice.defaultOutputDevice():setVolume(25)
  elseif newSSID ~= homeSSID then
    -- Just connected to not home wifi
    hs.audiodevice.defaultOutputDevice():setVolume(0)
  end

  lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

