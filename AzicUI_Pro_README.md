# Azic UI Pro 2.0

Dark, polished Roblox UI library with a Linoria-style API. Built from scratch.

## What's new in 2.0

- Persistent floating **A** button: tap/click it to open or close the window. It remains visible after the top-right close button hides the menu.
- `RightShift` still toggles the menu by default.
- Larger touch targets and animated hover/press feedback.
- 3D-inspired layered surfaces, gradients, accent strokes and animated transitions.
- A semantic catalogue of **619 icon names** plus `Library:RegisterIcon(name, image)` for binding real Roblox image assets.
- Tabs accept an optional icon key or direct `rbxassetid://` image.

> Icon note: the library includes the 619-name catalogue and the icon rendering/registration API. It does not bundle 619 third-party image files. Register the Roblox image asset IDs you want to display; until then, the tab uses a compact initial tile.

## Load

```lua
local Library = loadstring(game:HttpGet("YOUR_RAW_GITHUB_LIBRARY_URL"))()
```

## Tabs with icons

```lua
Library:RegisterIcon("home", "rbxassetid://YOUR_HOME_ICON_ID")
Library:RegisterIcon("settings", "rbxassetid://YOUR_SETTINGS_ICON_ID")

local Window = Library:CreateWindow({ Title = "My Hub", AutoShow = true })
local Main = Window:AddTab("Main", "home")
local Settings = Window:AddTab("Settings", "settings")
```

You can also pass a direct image asset:

```lua
local Visuals = Window:AddTab("Visuals", "rbxassetid://1234567890")
```

The icon catalogue is available as `Library.IconNames`. Use `Library:GetIcon("home")` to retrieve a registered image.

## Existing API

```lua
local Tab = Window:AddTab("Main")
local Group = Tab:AddLeftGroupbox("General")
Group:AddToggle("Enabled", { Text = "Enabled", Default = true })
Group:AddButton({ Text = "Action", Func = function() print("clicked") end })
```

All previous controls, config handling, notifications, watermark, theme controls, keybinds, sliders, dropdowns, tabboxes and dependency boxes are retained.

## Open / close controls

- Floating A button: always available while the ScreenGui exists.
- Top-right X: closes/hides the window.
- `RightShift`: toggles visibility by default.
- Change the key with `Library.ToggleKeybind`.

## Files

- `AzicUI_Pro_Library.lua` — updated library
- `AzicUI_Pro_Example.lua` — example usage
- `AzicUI_Pro_DESIGN.md` — design tokens and implementation notes
