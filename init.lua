-- Config Reloader
function reloadConfig(files)
  local doReload = false
  for _,file in pairs(files) do
      if file:sub(-4) == ".lua" then
          doReload = true
      end
  end
  if doReload then
      hs.reload()
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-- Lock Screen on `ScLk` push
hs.hotkey.bind({"shift"}, "pagedown", function()
  hs.caffeinate.lockScreen()
end)

-- Dual screen layout
function dualScreen(key)
  local leftWidth, rightWidth
  local laptopScreen = "Color LCD"
  local desktopScreen = hs.screen.primaryScreen()
  if key == "end" then
    leftWidth = 0.5
    rightWidth = 0.5
  elseif key == "home" then
    leftWidth = 0.47
    rightWidth = 0.53
  end
  local windowLayout = {
    {hs.application'chrome':name(), nil, desktopScreen, {x=0, y=0, w=leftWidth, h=1}, nil, nil},
    {"Sublime Text", nil, desktopScreen, {x=leftWidth, y=0, w=rightWidth, h=0.65}, nil, nil},
    {"Code", nil, desktopScreen, {x=leftWidth, y=0, w=rightWidth, h=0.65}, nil, nil},
    {"Hyper", nil, desktopScreen, {x=leftWidth, y=0.65, w=rightWidth, h=0.35}, nil, nil},
    {"Dashlane", nil, laptopScreen, {x=0.35, y=0.35, w=nil, h=nil}, nil, nil}
  }
  hs.layout.apply(windowLayout)
end

hs.hotkey.bind({"shift"}, "end", function() return dualScreen("end") end)
hs.hotkey.bind({"shift"}, "home", function() return dualScreen("home") end)
