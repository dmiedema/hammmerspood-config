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

-- Movement
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'H', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  
  win:setFrame(f)
end)

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'J', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + 10
  
  win:setFrame(f)
end)

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'K', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - 10
  
  win:setFrame(f)
end)

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'L', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  
  win:setFrame(f)
end)

-- Decrease Size
hs.hotkey.bind({'cmd', 'alt', 'shift'},  'H', function() 
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w - 10
  win:setFrame(f)
end)

hs.hotkey.bind({'cmd', 'alt', 'shift'},  'J', function() 
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h - 10
  f.y = f.y + 10
  win:setFrame(f)
end)
hs.hotkey.bind({'cmd', 'alt', 'shift'},  'K', function() 
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h - 10
  win:setFrame(f)
end)
hs.hotkey.bind({'cmd', 'alt', 'shift'},  'L', function() 
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w - 10
  f.x = f.x + 10
  win:setFrame(f)
end)

-- Increase size
hs.hotkey.bind({'ctrl', 'alt', 'shift'},  'H', function() 
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w + 10
  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({'ctrl', 'alt', 'shift'},  'J', function() 
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h + 10
  
  win:setFrame(f)
end)
hs.hotkey.bind({'ctrl', 'alt', 'shift'},  'K', function() 
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h + 10
  f.y = f.y - 10
  win:setFrame(f)
end)
hs.hotkey.bind({'ctrl', 'alt', 'shift'},  'L', function() 
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w + 10
  
  win:setFrame(f)
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

