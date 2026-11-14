# Azic UI — NEBULA 3D Edition

Version: **3.0.0 NEBULA**

A visual upgrade of the existing Azic UI library. The existing Linoria-style controls and configuration API are retained as far as possible.

## Visual upgrades
- Layered offset shadow plates behind the main window for an extruded / floating 3D look.
- Dark glass-style gradients, a beveled inner rim, brighter accent border and a polished top bar.
- Animated accent sweep and subtle breathing effect on the floating open/close control.
- Larger default window (720 × 500) and updated spacing for the taller title bar.
- `Library:Set3DEnabled(true/false)` to toggle the depth treatment.

## Important note about “3D”
Roblox ScreenGui elements are 2D interface objects. This edition creates a 3D-style illusion using depth layers, gradients, highlights, shadows and motion; it does not turn the interface into actual 3D world geometry.

## Usage
Use the same API as the previous library:

```lua
local Library = loadstring(game:HttpGet("YOUR_RAW_LIBRARY_URL"))()
local Window = Library:CreateWindow({
    Title = "Azic UI — NEBULA",
    AutoShow = true,
    Resizable = true,
})

local Tab = Window:AddTab("Dashboard", "home")
local Group = Tab:AddLeftGroupbox("Welcome")
Group:AddButton({
    Text = "Test notification",
    Func = function()
        Library:Notify({ Type = "Success", Description = "NEBULA is online." })
    end,
})

-- Optional: disable / re-enable the layered 3D treatment.
Library:Set3DEnabled(true)
```

## Compatibility
- Designed for Roblox Lua / Luau.
- Uses the existing Azic UI API; test in Roblox Studio before using in a live experience.
- This is a UI library only. It does not add game automation, cheats, remote-event abuse, or anti-cheat bypasses.
