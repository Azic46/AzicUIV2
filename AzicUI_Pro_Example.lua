--[[
    Azic UI - Example
    Run this to see every element in action.
]]

local repo = "https://raw.githubusercontent.com/Azic46/AzicUI/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()

local Options, Toggles = Library.Options, Library.Toggles

Library.NotifySide = "Right"                       -- "Left" | "Right"
Library.IgnoreIndexes = { "MenuKeybind" }          -- not saved in configs

local Window = Library:CreateWindow({
	Title = "Azic UI  |  Demo",
	AutoShow = true,
	Resizable = true,
	NotifySide = "Right",
})

-- Optional: register image assets for the semantic icon names you want to display.
-- The library ships with 619 icon names in Library.IconNames; supply your preferred
-- Roblox image asset IDs here to render the matching artwork.
-- Library:RegisterIcon("home", "rbxassetid://YOUR_IMAGE_ASSET_ID")

local Tabs = {
	Main = Window:AddTab("Main", "home"),
	Visuals = Window:AddTab("Visuals", "eye"),
	Settings = Window:AddTab("Settings", "settings"),
}

---------------------------------------------------------------------
-- MAIN
---------------------------------------------------------------------
local Combat = Tabs.Main:AddLeftGroupbox("Combat")

Combat:AddToggle("AimAssist", {
	Text = "Aim assist",
	Default = true,
	Tooltip = "Hover tooltips fade in smoothly",
	Callback = function(v) print("[cb] AimAssist:", v) end,
}):AddKeyPicker("AimKey", { Default = "MB2", Mode = "Hold", SyncToggleState = false, Text = "Aim assist" })
  :AddColorPicker("AimColor", { Default = Color3.fromRGB(255, 80, 120), Title = "Aim color" })

Combat:AddSlider("Smoothness", {
	Text = "Smoothness", Default = 35, Min = 0, Max = 100, Rounding = 0, Suffix = "%",
	Tooltip = "Drag, click or right-click to type an exact value",
})

Combat:AddDivider()

Combat:AddButton({
	Text = "Notify",
	Func = function()
		Library:Notify({ Type = "Success", Description = "Typed notifications: Success, Warning, Error or default.", Time = 5 })
	end,
	Tooltip = "Ripple + press animation",
}):AddButton({
	Text = "Danger (double click)",
	DoubleClick = true,
	Func = function() Library:Notify("You confirmed the dangerous action.", 3) end,
})

Combat:AddLabel("Labels can wrap their text when you pass true as the second argument.", true)

local Pick = Tabs.Main:AddRightGroupbox("Selection")
Pick:AddDropdown("Mode", { Text = "Mode", Values = { "Legit", "Rage", "Silent", "Off" }, Default = 1 })
Pick:AddDropdown("Targets", { Text = "Targets (multi)", Values = { "Head", "Torso", "Arms", "Legs" }, Multi = true, Default = { "Head" } })
Pick:AddDropdown("Search", { Text = "Searchable", Values = { "Apple", "Banana", "Cherry", "Dragonfruit", "Elderberry", "Fig", "Grape", "Honeydew", "Kiwi", "Lemon" }, Searchable = true, MaxVisibleDropdownItems = 6 })
Pick:AddDropdown("Players", { Text = "Player", SpecialType = "Player", ExcludeLocalPlayer = true })
Pick:AddInput("Name", { Text = "Textbox", Placeholder = "Type here...", Callback = function(v) print("[cb] Name:", v) end })

-- Dependency boxes: only visible while the toggle is on
local Dep = Tabs.Main:AddRightGroupbox("Dependencies")
Dep:AddToggle("ShowMore", { Text = "Show more options" })
local Box = Dep:AddDependencyBox()
Box:AddSlider("Power", { Text = "Power", Default = 50, Min = 0, Max = 100, Rounding = 0, HideMax = true })
Box:AddDropdown("Preset", { Text = "Preset", Values = { "A", "B", "C" }, Default = 1 })
Box:SetupDependencies({ { Toggles.ShowMore, true } })

-- Tabbox
local TB = Tabs.Main:AddLeftTabbox()
local T1, T2 = TB:AddTab("Tab 1"), TB:AddTab("Tab 2")
T1:AddToggle("T1Toggle", { Text = "Inside tabbox 1" })
T2:AddToggle("T2Toggle", { Text = "Inside tabbox 2" })

---------------------------------------------------------------------
-- VISUALS
---------------------------------------------------------------------
local Esp = Tabs.Visuals:AddLeftGroupbox("ESP")
Esp:AddToggle("EspEnabled", { Text = "Enabled" }):AddColorPicker("EspColor", { Default = Color3.fromRGB(80, 255, 170), Title = "ESP color" })
Esp:AddToggle("EspNames", { Text = "Names", Default = true })
Esp:AddToggle("EspRisky", { Text = "Risky option", Risky = true, Tooltip = "Risky = red label" })
Esp:AddToggle("EspLocked", { Text = "Disabled toggle", Disabled = true, DisabledTooltip = "I am disabled!" })

---------------------------------------------------------------------
-- SETTINGS
---------------------------------------------------------------------
local Menu = Tabs.Settings:AddLeftGroupbox("Menu")
Menu:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", Mode = "Toggle", NoUI = true, Text = "Menu keybind" })
Menu:AddButton({ Text = "Unload", DoubleClick = true, Func = function() Library:Unload() end })
Library.ToggleKeybind = Options.MenuKeybind

Library:BuildThemeSection(Tabs.Settings:AddLeftGroupbox("Theme"))
Library:BuildConfigSection(Tabs.Settings:AddRightGroupbox("Configs"))

---------------------------------------------------------------------
-- Watermark
---------------------------------------------------------------------
Library:SetWatermarkVisibility(true)
local frames, last, fps = 0, os.clock(), 60
local wm = game:GetService("RunService").RenderStepped:Connect(function()
	frames += 1
	if os.clock() - last >= 1 then
		fps, frames, last = frames, 0, os.clock()
		Library:SetWatermark(("Azic UI  |  %d fps"):format(fps))
	end
end)
Library:OnUnload(function() wm:Disconnect() end)

-- Reactive callbacks (recommended way)
Toggles.AimAssist:OnChanged(function() print("AimAssist is now", Toggles.AimAssist.Value) end)
Options.Smoothness:OnChanged(function() print("Smoothness:", Options.Smoothness.Value) end)

Library:Notify({ Type = "Success", Title = "Azic UI loaded", Description = "Use the floating A button or RightShift to open/close the menu.", Time = 5 })
