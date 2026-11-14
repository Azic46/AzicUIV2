--[[
     _          _        _   _ ___
    / \    ____(_) ___  | | | |_ _|
   / _ \  |_  /| |/ __| | | | || |
  / ___ \  / / | | (__  | |_| || |
 /_/   \_\/___||_|\___|  \___/|___|   v3.0.0 NEBULA 3D

 Azic UI - NEBULA 3D animated Roblox UI library (Linoria-style API)
 Features: animated window, ripple buttons, 3D layered window, glass-metal surfaces, glowing toggles, smooth sliders,
 searchable dropdowns, inline color picker, keybinds (4 modes), tabboxes,
 dependency boxes, notifications, watermark, config system, live accent themes.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local Teams = game:GetService("Teams")
local LocalPlayer = Players.LocalPlayer

local Library = {
	Version = "3.0.0  |  3D NEBULA",
	Style3D = true,
	Depth = 1,
	Options = {}, Toggles = {}, Labels = {},
	Signals = {}, UnloadCallbacks = {}, AccentUpdaters = {}, KeyPickers = {},
	Unloaded = false,
	ToggleKeybind = Enum.KeyCode.RightShift,
	NotifySide = "Right",
	AnimationSpeed = 1,
	ReducedMotion = false,
	AmbientEffects = true,
	Touch = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled,
	ConfigFolder = "AzicUI",
	IgnoreIndexes = {},
	Theme = {
		Background = Color3.fromRGB(13, 13, 19),
		Panel = Color3.fromRGB(20, 20, 29),
		Element = Color3.fromRGB(29, 29, 42),
		ElementHover = Color3.fromRGB(40, 40, 58),
		Outline = Color3.fromRGB(46, 46, 66),
		Text = Color3.fromRGB(236, 236, 245),
		Muted = Color3.fromRGB(148, 163, 184),   -- 5.4:1 on Element
		Control = Color3.fromRGB(100, 116, 139), -- >=3:1 control borders
		Accent = Color3.fromRGB(139, 92, 255),
		AccentText = Color3.fromRGB(180, 149, 255), -- accent used for small text
		Risk = Color3.fromRGB(255, 85, 95),
	},
	Themes = {
		Violet = Color3.fromRGB(139, 92, 255),
		Cyan = Color3.fromRGB(34, 211, 238),
		Rose = Color3.fromRGB(251, 80, 130),
		Emerald = Color3.fromRGB(52, 211, 153),
		Amber = Color3.fromRGB(251, 191, 36),
		Ocean = Color3.fromRGB(59, 130, 246),
	},
}
local Theme = Library.Theme

---------------------------------------------------------------------
-- Icon catalogue (619 semantic names) + custom Roblox image support
-- Register real icon assets with Library:RegisterIcon("home", "rbxassetid://...")
---------------------------------------------------------------------
Library.IconNames = {
	"home",
	"dashboard",
	"overview",
	"menu",
	"settings",
	"sliders",
	"tune",
	"controls",
	"tools",
	"wrench",
	"hammer",
	"code",
	"terminal",
	"script",
	"console",
	"command",
	"cpu",
	"memory",
	"database",
	"server",
	"cloud",
	"network",
	"wifi",
	"bluetooth",
	"globe",
	"map",
	"compass",
	"navigation",
	"location",
	"pin",
	"map-pin",
	"target",
	"crosshair",
	"aim",
	"eye",
	"visibility",
	"eye-off",
	"camera",
	"video",
	"image",
	"gallery",
	"layers",
	"stack",
	"grid",
	"list",
	"table",
	"chart",
	"chart-bar",
	"chart-line",
	"chart-pie",
	"activity",
	"pulse",
	"heart",
	"shield",
	"lock",
	"unlock",
	"key",
	"fingerprint",
	"user",
	"users",
	"user-plus",
	"user-check",
	"user-x",
	"contact",
	"profile",
	"badge",
	"id-card",
	"bell",
	"bell-ring",
	"notification",
	"mail",
	"inbox",
	"send",
	"message",
	"messages",
	"chat",
	"comments",
	"phone",
	"smartphone",
	"tablet",
	"monitor",
	"laptop",
	"desktop",
	"keyboard",
	"mouse",
	"gamepad",
	"joystick",
	"controller",
	"trophy",
	"medal",
	"crown",
	"star",
	"sparkles",
	"zap",
	"bolt",
	"flame",
	"fire",
	"rocket",
	"plane",
	"car",
	"truck",
	"bike",
	"ship",
	"train",
	"wallet",
	"credit-card",
	"coins",
	"bank",
	"receipt",
	"shopping-cart",
	"bag",
	"package",
	"box",
	"archive",
	"folder",
	"folder-open",
	"file",
	"files",
	"file-text",
	"file-code",
	"file-image",
	"download",
	"upload",
	"import",
	"export",
	"share",
	"link",
	"external-link",
	"copy",
	"clipboard",
	"save",
	"bookmark",
	"tag",
	"tags",
	"filter",
	"funnel",
	"search",
	"zoom-in",
	"zoom-out",
	"plus",
	"minus",
	"x",
	"check",
	"check-circle",
	"alert",
	"alert-triangle",
	"info",
	"help",
	"question-circle",
	"clock",
	"calendar",
	"calendar-days",
	"timer",
	"stopwatch",
	"history",
	"refresh",
	"rotate",
	"undo",
	"redo",
	"play",
	"pause",
	"stop",
	"skip-back",
	"skip-forward",
	"volume",
	"volume-2",
	"volume-x",
	"mic",
	"mic-off",
	"headphones",
	"music",
	"radio",
	"podcast",
	"speaker",
	"sun",
	"moon",
	"cloud-sun",
	"cloud-rain",
	"snowflake",
	"thermometer",
	"umbrella",
	"wind",
	"leaf",
	"tree",
	"flower",
	"bug",
	"paw",
	"cat",
	"dog",
	"coffee",
	"cup",
	"glass",
	"bottle",
	"pizza",
	"apple",
	"game-die",
	"puzzle",
	"chess",
	"sword",
	"pickaxe",
	"hammer-anvil",
	"bomb",
	"wand",
	"magic-wand",
	"palette",
	"paintbrush",
	"brush",
	"pencil",
	"edit",
	"pen",
	"eraser",
	"crop",
	"move",
	"resize",
	"maximize",
	"minimize",
	"expand",
	"shrink",
	"fullscreen",
	"scan",
	"qr-code",
	"barcode",
	"printer",
	"print",
	"paperclip",
	"attachment",
	"pushpin",
	"flag",
	"award",
	"gift",
	"party",
	"popper",
	"lightbulb",
	"lamp",
	"power",
	"power-off",
	"plug",
	"battery",
	"battery-charging",
	"signal",
	"signal-high",
	"signal-low",
	"signal-zero",
	"gauge",
	"speedometer",
	"rocket-launch",
	"chart-no-axes",
	"chart-no-axes-combined",
	"trending-up",
	"trending-down",
	"arrow-up",
	"arrow-down",
	"arrow-left",
	"arrow-right",
	"chevron-up",
	"chevron-down",
	"chevron-left",
	"chevron-right",
	"more-horizontal",
	"more-vertical",
	"menu-square",
	"panel-left",
	"panel-right",
	"sidebar",
	"layout",
	"columns",
	"rows",
	"split",
	"square",
	"circle",
	"triangle",
	"hexagon",
	"diamond",
	"octagon",
	"cube",
	"box-select",
	"component",
	"puzzle-piece",
	"blocks",
	"workflow",
	"git-branch",
	"git-commit",
	"git-merge",
	"github",
	"bug-off",
	"wrench-screwdriver",
	"hammer-drill",
	"shield-check",
	"shield-alert",
	"shield-plus",
	"user-cog",
	"users-round",
	"settings-2",
	"cog",
	"sliders-horizontal",
	"list-check",
	"list-filter",
	"clipboard-check",
	"clipboard-list",
	"notebook",
	"book",
	"book-open",
	"graduation-cap",
	"school",
	"pencil-ruler",
	"calculator",
	"sigma",
	"function",
	"percent",
	"hash",
	"at-sign",
	"code-xml",
	"braces",
	"brackets",
	"terminal-square",
	"app-window",
	"app-window-mac",
	"monitor-smartphone",
	"screen-share",
	"cast",
	"airplay",
	"usb",
	"hard-drive",
	"sd-card",
	"server-cog",
	"database-backup",
	"cloud-upload",
	"cloud-download",
	"cloud-sync",
	"router",
	"antenna",
	"satellite",
	"rss",
	"earth",
	"map-pinned",
	"route",
	"signpost",
	"traffic-cone",
	"construction",
	"factory",
	"building",
	"store",
	"house",
	"hospital",
	"ambulance",
	"first-aid",
	"kit",
	"cross",
	"circle-help",
	"circle-check",
	"circle-x",
	"circle-alert",
	"triangle-alert",
	"octagon-alert",
	"badge-check",
	"badge-alert",
	"medal-star",
	"gem",
	"diamond-sparkle",
	"wand-sparkles",
	"fingerprint-lock",
	"shield-half",
	"lock-keyhole",
	"unlock-keyhole",
	"eye-closed",
	"scan-eye",
	"scan-face",
	"smile",
	"frown",
	"meh",
	"thumbs-up",
	"thumbs-down",
	"hand",
	"tap-pointer",
	"mouse-pointer",
	"cursor",
	"click",
	"touch-id",
	"accessibility",
	"wheelchair-person",
	"person-standing",
	"person-running",
	"person-walking",
	"footprints",
	"dumbbell",
	"activity-square",
	"chart-area",
	"chart-scatter",
	"chart-network",
	"nodes",
	"network-server",
	"cable",
	"ethernet",
	"globe-2",
	"language",
	"translate",
	"spell-check",
	"text",
	"cursor-text",
	"type",
	"bold",
	"italic",
	"underline",
	"strikethrough",
	"align-left",
	"align-center",
	"align-right",
	"align-justify",
	"indent",
	"outdent",
	"list-ordered",
	"list-",
	"checks",
	"quote",
	"heading",
	"ruler",
	"table-2",
	"panels-top-left",
	"panels-top-right",
	"panels-bottom-left",
	"panels-bottom-right",
	"app-store",
	"clipboard-copy",
	"file-plus",
	"file-minus",
	"file-check",
	"file-x",
	"file-search",
	"folder-plus",
	"folder-minus",
	"folder-check",
	"folder-x",
	"folder-sync",
	"folder-git",
	"folder-code",
	"folder-key",
	"folder-lock",
	"folder-heart",
	"folder-star",
	"folder-cog",
	"folder-tree",
	"folder-kanban",
	"calendar-check",
	"calendar-x",
	"calendar-plus",
	"calendar-minus",
	"calendar-clock",
	"calendar-heart",
	"alarm-clock",
	"bell-dot",
	"bell-plus",
	"bell-minus",
	"bell-off",
	"message-circle",
	"message-square",
	"message-plus",
	"message-minus",
	"message-check",
	"message-x",
	"messages-square",
	"send-horizontal",
	"reply",
	"reply-all",
	"forward",
	"corner-up-left",
	"corner-up-right",
	"share-2",
	"share-nodes",
	"external-link-2",
	"link-2",
	"unlink-2",
	"chain",
	"file-down",
	"file-up",
	"cloud-check",
	"cloud-off",
	"cloud-cog",
	"cloud-lightning",
	"cloud-moon",
	"cloud-sun-rain",
	"droplets",
	"waves",
	"mountain",
	"sun-dim",
	"sunset",
	"sunrise",
	"eclipse",
	"stars",
	"sparkle",
	"comet",
	"orbit",
	"atom",
	"dna",
	"flask-conical",
	"test-tube",
	"beaker",
	"microscope",
	"telescope",
	"brain",
	"brain-circuit",
	"bot",
	"robot",
	"search-check",
	"search-x",
	"search-code",
	"filter-x",
	"filter-plus",
	"sort-asc",
	"sort-desc",
	"arrow-down-up",
	"arrow-left-right",
	"move-horizontal",
	"move-vertical",
	"rotate-cw",
	"rotate-ccw",
	"refresh-cw",
	"refresh-ccw",
	"repeat",
	"repeat-1",
	"shuffle",
	"workflow-square",
	"git-pull-request",
	"git-pull-request-arrow",
	"git-fork",
	"git-graph",
	"package-check",
	"package-x",
	"truck-delivery",
	"warehouse",
	"forklift",
	"barcode-scan",
	"qr-code-scan",
	"shield-user",
	"shield-question",
	"lock-open",
	"key-round",
	"key-square",
	"keyhole",
	"vault",
	"safe",
	"wallet-cards",
	"banknote",
	"piggy-bank",
	"chart-candlestick",
	"chart-no-axes-gantt",
	"chart-waterfall",
	"chart-spline",
	"chart-column",
	"chart-bar-big",
	"currency",
	"dollar-sign",
	"euro",
	"pound-sterling",
	"bitcoin",
	"receipt-text",
	"file-spreadsheet",
	"file-chart",
	"file-audio",
	"file-video",
	"file-type",
	"image-plus",
	"image-minus",
	"image-off",
	"images",
	"camera-off",
	"camera-plus",
	"video-off",
	"video-plus",
	"film",
	"clapperboard",
	"gallery-horizontal",
	"gallery-vertical",
	"music-2",
	"music-3",
	"music-4",
	"audio-lines",
	"audio-waveform",
	"waveform",
	"equalizer",
	"volume-1",
	"volume-off",
	"play-circle",
	"pause-circle",
	"stop-circle",
	"skip-forward-circle",
	"skip-back-circle",
	"radio-tower",
	"microphone",
	"microphone-off",
	"gamepad-2",
	"dice-1",
	"dice-2",
	"dice-3",
	"dice-4",
	"dice-5",
	"dice-6",
	"ribbon",
	"rosette",
	"badge-percent",
	"ticket",
	"ticket-check",
	"ticket-x",
	"tag-plus",
	"tag-minus",
	"catalog",
	"list-plus",
	"list-minus",
	"list-x",
	"list-restart",
	"list-start",
	"list-end",
	"grip",
	"grip-vertical",
	"grip-horizontal",
	"drag-handle",
	"dots-horizontal",
	"dots-vertical",
	"ellipsis",
	"ellipsis-vertical"
}
Library.IconAssets = {}
function Library:RegisterIcon(name, image)
	assert(type(name) == "string" and type(image) == "string", "RegisterIcon expects name and image string")
	self.IconAssets[string.lower(name)] = image
end
function Library:GetIcon(name)
	if not name then return nil end
	return self.IconAssets[string.lower(tostring(name))]
end


-- Design tokens (global -> semantic -> component)
Library.Tokens = {
	Motion = { Fast = 0.12, Base = 0.2, Slow = 0.35, Enter = 0.52, Exit = 0.24 }, -- exit is faster than enter
	Radius = { Sm = 6, Md = 9, Lg = 12, Xl = 16, Xxl = 20 },
	Space = { 4, 8, 12, 16, 24 },
}
local Mo = Library.Tokens.Motion
local IsTouch = Library.Touch
-- Touch targets: >=44px rows on touch devices, compact on desktop
local Dim = {
	Row = IsTouch and 40 or 26, Button = IsTouch and 44 or 30, Input = IsTouch and 42 or 28,
	Item = IsTouch and 36 or 24, Hit = IsTouch and 30 or 18, Tab = IsTouch and 44 or 34, Close = IsTouch and 38 or 28,
}
do -- visible focus ring for gamepad / keyboard selection
	local ring = Instance.new("Frame")
	ring.BackgroundTransparency = 1
	local rs = Instance.new("UIStroke"); rs.Color = Color3.new(1, 1, 1); rs.Thickness = 2; rs.Parent = ring
	local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0, 6); rc.Parent = ring
	Library.Ring = ring
end

local Quint, Back, Out, Linear = Enum.EasingStyle.Quint, Enum.EasingStyle.Back, Enum.EasingDirection.Out, Enum.EasingStyle.Linear
local FontM, FontB, FontN = Enum.Font.GothamMedium, Enum.Font.GothamBold, Enum.Font.RobotoMono
local Left, Right, Center = Enum.TextXAlignment.Left, Enum.TextXAlignment.Right, Enum.TextXAlignment.Center
local MB1, MB2, MB3 = Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3

---------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------
local function New(class, props, children)
	local inst = Instance.new(class)
	if class == "TextButton" then inst.SelectionImageObject = Library.Ring end
	local parent
	for k, v in pairs(props or {}) do
		if k == "Parent" then parent = v else inst[k] = v end
	end
	for _, c in ipairs(children or {}) do c.Parent = inst end
	inst.Parent = parent
	return inst
end

local function Tween(obj, props, t, style, dir)
	local dur = Library.ReducedMotion and 0 or (t or 0.2) / Library.AnimationSpeed
	local tw = TweenService:Create(obj, TweenInfo.new(dur, Library.ReducedMotion and Linear or style or Quint, dir or Out), props)
	tw:Play()
	return tw
end

local function Corner(r) return New("UICorner", { CornerRadius = UDim.new(0, r or 6) }) end
local function Stroke(c, th, tr)
	return New("UIStroke", { Color = c or Theme.Outline, Thickness = th or 1, Transparency = tr or 0, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
end
local function Pad(t, r, b, l)
	return New("UIPadding", { PaddingTop = UDim.new(0, t), PaddingRight = UDim.new(0, r or t), PaddingBottom = UDim.new(0, b or t), PaddingLeft = UDim.new(0, l or r or t) })
end
local function List(pad, dir)
	return New("UIListLayout", { Padding = UDim.new(0, pad or 0), SortOrder = Enum.SortOrder.LayoutOrder, FillDirection = dir or Enum.FillDirection.Vertical })
end
local function Lbl(p)
	p.BackgroundTransparency = 1
	p.Font = p.Font or FontM
	p.TextSize = p.TextSize or 14
	p.TextColor3 = p.TextColor3 or Theme.Text
	p.TextXAlignment = p.TextXAlignment or Left
	return New("TextLabel", p)
end
local function Lighten(c, a) return c:Lerp(Color3.new(1, 1, 1), a) end
local function Round(n, d) local m = 10 ^ (d or 0) return math.floor(n * m + 0.5) / m end

local function PosOf(i)
	if i and i.UserInputType == Enum.UserInputType.Touch then
		return Vector2.new(i.Position.X, i.Position.Y) + GuiService:GetGuiInset()
	end
	return UserInputService:GetMouseLocation()
end
local function IsPress(i) return i.UserInputType == MB1 or i.UserInputType == Enum.UserInputType.Touch end
local function IsMove(i) return i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch end

function Library:Connect(sig, fn)
	local c = sig:Connect(fn)
	table.insert(self.Signals, c)
	return c
end
function Library:OnAccent(fn) table.insert(self.AccentUpdaters, fn) fn(Theme.Accent) end
function Library:SetAccent(c)
	Theme.Accent = c
	Theme.AccentText = Lighten(c, 0.35)
	for _, f in ipairs(self.AccentUpdaters) do pcall(f, c) end
end
function Library:OnUnload(fn) table.insert(self.UnloadCallbacks, fn) end

local function Drag(obj, onMove, onDown, onUp)
	local active = false
	obj.InputBegan:Connect(function(i)
		if IsPress(i) then
			active = true
			if onDown then onDown() end
			onMove(PosOf(i))
		end
	end)
	Library:Connect(UserInputService.InputChanged, function(i)
		if active and IsMove(i) then onMove(PosOf(i)) end
	end)
	Library:Connect(UserInputService.InputEnded, function(i)
		if active and IsPress(i) then
			active = false
			if onUp then onUp() end
		end
	end)
end

local function Ripple(parent, pos)
	local ap, as = parent.AbsolutePosition, parent.AbsoluteSize
	local r = New("Frame", {
		BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.78, AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale((pos.X - ap.X) / math.max(as.X, 1), (pos.Y - ap.Y) / math.max(as.Y, 1)),
		Size = UDim2.fromOffset(0, 0), ZIndex = parent.ZIndex + 1, Parent = parent,
	}, { Corner(999) })
	local s = math.max(as.X, as.Y) * 2.4
	Tween(r, { Size = UDim2.fromOffset(s, s), BackgroundTransparency = 1 }, 0.6)
	task.delay(0.65, function() r:Destroy() end)
end

---------------------------------------------------------------------
-- Root GUI, tooltip, notifications, watermark
---------------------------------------------------------------------
local Gui = New("ScreenGui", { Name = "AzicUI", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
do
	local ok = pcall(function() Gui.Parent = (gethui and gethui()) or CoreGui end)
	if not ok or not Gui.Parent then Gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
end
Library.Gui = Gui

local Tip = Lbl({
	Visible = false, AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, BackgroundColor3 = Theme.Panel,
	TextTransparency = 1, TextSize = 13, ZIndex = 200, Parent = Gui,
}, nil)
Tip.BackgroundTransparency = 1
Corner(5).Parent = Tip; Stroke().Parent = Tip; Pad(5, 9).Parent = Tip
local tipToken = 0
Library:Connect(RunService.RenderStepped, function()
	if Tip.Visible then
		local m = UserInputService:GetMouseLocation()
		Tip.Position = UDim2.fromOffset(m.X + 14, m.Y + 8)
	end
end)
function Library:AddTooltip(obj, getText)
	obj.MouseEnter:Connect(function()
		local t = getText()
		if t and t ~= "" then
			tipToken += 1
			Tip.Text = t
			Tip.Visible = true
			Tween(Tip, { BackgroundTransparency = 0, TextTransparency = 0 }, 0.15)
		end
	end)
	obj.MouseLeave:Connect(function()
		tipToken += 1
		local tk = tipToken
		Tween(Tip, { BackgroundTransparency = 1, TextTransparency = 1 }, 0.1)
		task.delay(0.12, function() if tk == tipToken then Tip.Visible = false end end)
	end)
end

local NotifyHolder = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(0, 280, 1, -28), Position = UDim2.new(1, -14, 0, 14), AnchorPoint = Vector2.new(1, 0), Parent = Gui })
local NotifyList = List(8); NotifyList.Parent = NotifyHolder

function Library:Notify(a, b)
	local o = type(a) == "table" and a or { Description = a, Time = b }
	local kinds = { Success = { "Success", Color3.fromRGB(52, 211, 153) }, Warning = { "Warning", Color3.fromRGB(251, 191, 36) }, Error = { "Error", Theme.Risk } }
	local kind = kinds[o.Type or ""]
	local tone = kind and kind[2] or Theme.Accent
	local title, desc, dur = o.Title or (kind and kind[1]) or "Azic UI", o.Description or o.Text or "", o.Time or 4
	local right = self.NotifySide ~= "Left"
	NotifyHolder.AnchorPoint = Vector2.new(right and 1 or 0, 0)
	NotifyHolder.Position = UDim2.new(right and 1 or 0, right and -14 or 14, 0, 14)
	NotifyList.HorizontalAlignment = right and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left
	local th = TextService:GetTextSize(desc, 13, FontM, Vector2.new(240, 1000)).Y
	local H = 34 + th + 10
	local wrap = New("Frame", { BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.new(0, 280, 0, 0), Parent = NotifyHolder })
	local inner = New("Frame", { BackgroundColor3 = Theme.Panel, Size = UDim2.new(0, 280, 0, H), Position = UDim2.new(right and 1.1 or -1.1, 0, 0, 0), Parent = wrap }, { Corner(8), Stroke() })
	New("Frame", { BackgroundColor3 = tone, Size = UDim2.new(0, 3, 1, 0), Parent = inner }, { Corner(2) })
	Lbl({ Text = title, Font = FontB, TextColor3 = Lighten(tone, 0.35), Position = UDim2.fromOffset(14, 7), Size = UDim2.new(1, -24, 0, 18), Parent = inner })
	Lbl({ Text = desc, TextSize = 13, TextColor3 = Theme.Muted, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Position = UDim2.fromOffset(14, 27), Size = UDim2.new(1, -24, 0, th), Parent = inner })
	local bar = New("Frame", { BackgroundColor3 = tone, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 2), BorderSizePixel = 0, Parent = inner })
	Tween(wrap, { Size = UDim2.new(0, 280, 0, H) }, 0.3)
	Tween(inner, { Position = UDim2.new(0, 0, 0, 0) }, 0.45, Back)
	Tween(bar, { Size = UDim2.new(0, 0, 0, 2) }, dur, Linear)
	task.delay(dur, function()
		Tween(inner, { Position = UDim2.new(right and 1.1 or -1.1, 0, 0, 0) }, 0.35)
		task.wait(0.3)
		Tween(wrap, { Size = UDim2.new(0, 280, 0, 0) }, 0.25)
		task.wait(0.3)
		wrap:Destroy()
	end)
end

function Library:SetWatermark(text)
	if not self.WM then
		local f = New("Frame", { BackgroundColor3 = Theme.Panel, Position = UDim2.fromOffset(14, 14), Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, Parent = Gui }, { Corner(6), Stroke() })
		local l = New("Frame", { BackgroundColor3 = Theme.Accent, Size = UDim2.new(1, 0, 0, 2), Parent = f }, { Corner(2) })
		self:OnAccent(function(c) l.BackgroundColor3 = c end)
		local t = Lbl({ TextSize = 13, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), Parent = f }, nil)
		Pad(0, 10).Parent = t
		self.WM = { Frame = f, Label = t }
	end
	self.WM.Label.Text = text
end
function Library:SetWatermarkVisibility(v) if not self.WM then self:SetWatermark("Azic UI") end self.WM.Frame.Visible = v end

---------------------------------------------------------------------
-- Element base
---------------------------------------------------------------------
local Element = {}
Element.__index = Element
function Element:OnChanged(fn) table.insert(self.Changed, fn) return self end
function Element:_Fire()
	if self.Callback then task.spawn(self.Callback, self.Value, self.Transparency) end
	for _, f in ipairs(self.Changed) do task.spawn(f, self.Value, self.Transparency) end
end
function Element:SetVisible(v) self.Holder.Visible = v end
function Element:SetDisabled(d)
	self.Disabled = d
	if self.Label then Tween(self.Label, { TextTransparency = d and 0.6 or 0 }) end
end
function Element:SetText(t) if self.Label then self.Label.Text = t end end
function Element:Reset() if self.Default ~= nil and self.SetValue then self:SetValue(self.Default) end end

local function NewElement(t, info, holder, label)
	return setmetatable({ Type = t, Changed = {}, Callback = info.Callback, Holder = holder, Label = label, Disabled = info.Disabled or false }, Element)
end
local function TipFor(obj, el, info)
	Library:AddTooltip(obj, function()
		if el.Disabled and info.DisabledTooltip then return info.DisabledTooltip end
		return info.Tooltip
	end)
end

---------------------------------------------------------------------
-- Addons: ColorPicker & KeyPicker
---------------------------------------------------------------------
local function ParseKey(n)
	if n == "MB1" then return MB1 elseif n == "MB2" then return MB2 elseif n == "MB3" then return MB3 end
	if not n or n == "None" then return nil end
	local ok, k = pcall(function() return Enum.KeyCode[n] end)
	return ok and k or nil
end

local function MakeColorPicker(parent, idx, info)
	info = info or {}
	local P = NewElement("ColorPicker", info, parent.Holder, nil)
	P.Transparency = info.Transparency
	local h, s, v = (info.Default or Color3.new(1, 1, 1)):ToHSV()
	P.Value = Color3.fromHSV(h, s, v)
	P.Default = P.Value

	local Swatch = New("TextButton", { Text = "", AutoButtonColor = false, Size = UDim2.fromOffset(Dim.Hit + 8, Dim.Hit - 2), BackgroundColor3 = P.Value, Parent = parent.Addons }, { Corner(5), Stroke() })
	Library:AddTooltip(Swatch, function() return info.Title end)
	local Panel = New("Frame", { BackgroundColor3 = Theme.Element, Size = UDim2.new(1, 0, 0, 0), ClipsDescendants = true, Visible = false, LayoutOrder = 5, Parent = parent.Holder }, { Corner(6) })
	local SV = New("Frame", { BackgroundColor3 = Color3.fromHSV(h, 1, 1), Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -44, 0, 104), ClipsDescendants = true, Parent = Panel }, { Corner(4) })
	New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromScale(1, 1), Parent = SV }, { New("UIGradient", { Transparency = NumberSequence.new(0, 1) }) })
	New("Frame", { BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.fromScale(1, 1), Parent = SV }, { New("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(1, 0) }) })
	local SVCur = New("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(10, 10), BackgroundTransparency = 1, Parent = SV }, { Corner(5), Stroke(Color3.new(1, 1, 1), 2) })
	local Hue = New("Frame", { AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Size = UDim2.fromOffset(20, 104), BackgroundColor3 = Color3.new(1, 1, 1), Parent = Panel }, {
		Corner(4),
		New("UIGradient", { Rotation = 90, Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)), ColorSequenceKeypoint.new(1 / 6, Color3.fromHSV(1 / 6, 1, 1)),
			ColorSequenceKeypoint.new(2 / 6, Color3.fromHSV(2 / 6, 1, 1)), ColorSequenceKeypoint.new(3 / 6, Color3.fromHSV(3 / 6, 1, 1)),
			ColorSequenceKeypoint.new(4 / 6, Color3.fromHSV(4 / 6, 1, 1)), ColorSequenceKeypoint.new(5 / 6, Color3.fromHSV(5 / 6, 1, 1)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 1, 1)) }) }),
	})
	local HueCur = New("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(1, 6, 0, 4), BackgroundColor3 = Color3.new(1, 1, 1), Parent = Hue }, { Corner(2), Stroke(Color3.new(0, 0, 0), 1, 0.4) })

	local function Update(fire, animate)
		P.Value = Color3.fromHSV(h, s, v)
		Swatch.BackgroundColor3 = P.Value
		SV.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
		SVCur.Position = UDim2.fromScale(s, 1 - v)
		HueCur.Position = UDim2.fromScale(0.5, h)
		if fire then P:_Fire() end
	end
	Drag(SV, function(m)
		s = math.clamp((m.X - SV.AbsolutePosition.X) / SV.AbsoluteSize.X, 0, 1)
		v = 1 - math.clamp((m.Y - SV.AbsolutePosition.Y) / SV.AbsoluteSize.Y, 0, 1)
		Update(true)
	end)
	Drag(Hue, function(m)
		h = math.clamp((m.Y - Hue.AbsolutePosition.Y) / Hue.AbsoluteSize.Y, 0, 0.999)
		Update(true)
	end)
	local open = false
	Swatch.MouseButton1Click:Connect(function()
		open = not open
		if open then
			Panel.Visible = true
			Tween(Panel, { Size = UDim2.new(1, 0, 0, 120) }, 0.3)
		else
			Tween(Panel, { Size = UDim2.new(1, 0, 0, 0) }, 0.25)
			task.delay(0.26, function() if not open then Panel.Visible = false end end)
		end
	end)
	function P:SetValue(c) h, s, v = c:ToHSV() Update(true) end
	P.SetValueRGB = P.SetValue
	function P:SetHSV(hh, ss, vv) h, s, v = hh, ss, vv Update(true) end
	Update(false)
	if idx then Library.Options[idx] = P end
	return P
end

local KeyModes = { "Toggle", "Hold", "Always", "Press" }
local function MakeKeyPicker(parent, idx, info)
	info = info or {}
	local KP = NewElement("KeyPicker", info, parent.Holder, nil)
	KP.Value = info.Default or "None"
	KP.Default = KP.Value
	KP.Mode = info.Mode or "Toggle"
	KP.State = KP.Mode == "Always"
	KP.Clicked = {}
	KP.Text = info.Text

	local Btn = New("TextButton", {
		Text = "", AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, Dim.Hit),
		BackgroundColor3 = Theme.Element, Font = FontN, TextSize = 12, TextColor3 = Theme.Muted, Parent = parent.Addons,
	}, { Corner(5), Stroke(), Pad(0, 6) })
	Btn.MouseEnter:Connect(function() Tween(Btn, { BackgroundColor3 = Theme.ElementHover }, 0.12) end)
	Btn.MouseLeave:Connect(function() Tween(Btn, { BackgroundColor3 = Theme.Element }, 0.12) end)
	Library:AddTooltip(Btn, function() return "Mode: " .. KP.Mode .. "  (right-click to change)" end)

	local function Refresh() Btn.Text = "[" .. tostring(KP.Value) .. "]" end
	function KP:SetValue(t)
		if type(t) == "table" then
			if t[1] then KP.Value = t[1] end
			if t[2] then KP.Mode = t[2] end
		elseif t then KP.Value = t end
		if KP.Mode == "Always" then KP.State = true end
		Refresh()
		if info.ChangedCallback then task.spawn(info.ChangedCallback, ParseKey(KP.Value), {}) end
		for _, f in ipairs(KP.Changed) do task.spawn(f, KP.Value) end
	end
	function KP:GetState() return KP.Mode == "Always" or KP.State end
	function KP:OnClick(fn) table.insert(KP.Clicked, fn) return KP end
	function KP:Matches(input)
		local k = ParseKey(KP.Value)
		if not k then return false end
		if k.EnumType == Enum.UserInputType then return input.UserInputType == k end
		return input.KeyCode == k
	end
	local function Click(state)
		if info.Callback then task.spawn(info.Callback, state) end
		for _, f in ipairs(KP.Clicked) do task.spawn(f, state) end
	end
	function KP:_Down()
		if KP.Mode == "Toggle" then
			KP.State = not KP.State
			if info.SyncToggleState and parent.Type == "Toggle" then parent:SetValue(KP.State) end
			Click(KP.State)
		elseif KP.Mode == "Hold" then KP.State = true Click(true)
		elseif KP.Mode == "Press" then Click(true) end
	end
	function KP:_Up()
		if KP.Mode == "Hold" and KP.State then KP.State = false Click(false) end
	end
	if info.SyncToggleState and parent.Type == "Toggle" then
		KP.State = parent.Value
		parent:OnChanged(function(val) KP.State = val end)
	end

	Btn.MouseButton1Click:Connect(function()
		Btn.Text = "[...]"
		Tween(Btn, { TextColor3 = Theme.AccentText }, 0.15)
		task.defer(function()
			Library.Listener = function(input)
				local name
				if input.UserInputType == Enum.UserInputType.Keyboard then
					if input.KeyCode == Enum.KeyCode.Escape then name = KP.Value
					elseif input.KeyCode == Enum.KeyCode.Backspace then name = "None"
					else name = input.KeyCode.Name end
				elseif input.UserInputType == MB1 then name = "MB1"
				elseif input.UserInputType == MB2 then name = "MB2"
				elseif input.UserInputType == MB3 then name = "MB3" end
				if not name then return false end
				KP:SetValue({ name })
				Tween(Btn, { TextColor3 = Theme.Muted }, 0.15)
				return true
			end
		end)
	end)
	Btn.MouseButton2Click:Connect(function()
		local i = table.find(KeyModes, KP.Mode) or 1
		KP.Mode = KeyModes[i % #KeyModes + 1]
		KP.State = KP.Mode == "Always"
		Library:Notify({ Title = "Keybind mode", Description = (KP.Text or idx or "Keybind") .. " -> " .. KP.Mode, Time = 2 })
	end)
	Refresh()
	table.insert(Library.KeyPickers, KP)
	if idx then Library.Options[idx] = KP end
	return KP
end

local function AttachAddons(obj)
	function obj:AddColorPicker(i, inf) MakeColorPicker(obj, i, inf) return obj end
	function obj:AddKeyPicker(i, inf) MakeKeyPicker(obj, i, inf) return obj end
end
local function NewAddons(head, rightOffset)
	return New("Frame", {
		BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -(rightOffset or 0), 0.5, 0),
		Size = UDim2.fromOffset(0, Dim.Hit + 4), AutomaticSize = Enum.AutomaticSize.X, Parent = head,
	}, { New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }) })
end

---------------------------------------------------------------------
-- Groupbox elements
---------------------------------------------------------------------
local Base = {}
Base.__index = Base

function Base:_Row()
	self.Order = (self.Order or 0) + 1
	return New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = self.Order, Parent = self.Container }, { List(4) })
end

function Base:AddToggle(idx, info)
	info = info or {}
	local Holder = self:_Row()
	local Head = New("TextButton", { Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, Dim.Row), Parent = Holder })
	local Label = Lbl({ Text = info.Text or idx, TextColor3 = info.Risky and Theme.Risk or Theme.Text, Size = UDim2.new(1, -50, 1, 0), Parent = Head })
	local Switch = New("Frame", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(38, 20), BackgroundColor3 = Theme.Element, Parent = Head }, { Corner(10) })
	local SwStroke = Stroke(Theme.Control, 1); SwStroke.Parent = Switch
	local Knob = New("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(14, 14), BackgroundColor3 = Theme.Muted, Parent = Switch }, { Corner(7) })

	local T = NewElement("Toggle", info, Holder, Label)
	T.Value = false
	T.Head = Head
	T.Addons = NewAddons(Head, 48)
	local function Render(animate)
		local on, t = T.Value, animate and 0.28 or 0
		Tween(Switch, { BackgroundColor3 = on and Theme.Accent or Theme.Element }, t)
		Tween(SwStroke, { Color = on and Lighten(Theme.Accent, 0.3) or Theme.Control, Thickness = on and 1.5 or 1 }, t)
		Tween(Knob, { Position = on and UDim2.new(1, -10, 0.5, 0) or UDim2.new(0, 10, 0.5, 0), BackgroundColor3 = on and Color3.new(1, 1, 1) or Theme.Muted, Size = UDim2.fromOffset(14, 14) }, t, Back)
	end
	function T:SetValue(v)
		v = v and true or false
		if v == T.Value then return end
		T.Value = v
		Render(true)
		T:_Fire()
	end
	Head.MouseButton1Down:Connect(function() if not T.Disabled then Tween(Knob, { Size = UDim2.fromOffset(20, 14) }, 0.12) end end)
	Head.MouseButton1Click:Connect(function() if not T.Disabled then T:SetValue(not T.Value) end end)
	Head.MouseEnter:Connect(function() if not T.Value then Tween(Switch, { BackgroundColor3 = Theme.ElementHover }, 0.15) end end)
	Head.MouseLeave:Connect(function() Render(true) end)
	Library:OnAccent(function() Render(false) end)
	TipFor(Head, T, info)
	T.Value = info.Default and true or false
	T.Default = T.Value
	Render(false)
	if info.Disabled then T:SetDisabled(true) end
	if info.Visible == false then Holder.Visible = false end
	AttachAddons(T)
	if idx then Library.Toggles[idx] = T end
	return T
end

function Base:AddButton(a, b)
	local info = type(a) == "table" and a or { Text = a, Func = b }
	local Holder = self:_Row()
	local Row = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, Dim.Button), Parent = Holder }, { List(6, Enum.FillDirection.Horizontal) })
	local Group = { Buttons = {} }

	local function Resize()
		local n, gap = #Group.Buttons, 6
		for _, bt in ipairs(Group.Buttons) do bt.Btn.Size = UDim2.new(1 / n, -(gap * (n - 1)) / n, 1, 0) end
	end
	local function Make(inf)
		local B = NewElement("Button", inf, Holder, nil)
		local Btn = New("TextButton", {
			Text = inf.Text or "Button", Font = FontM, TextSize = 14, TextColor3 = Theme.Text, AutoButtonColor = false,
			BackgroundColor3 = Theme.Element, ClipsDescendants = true, Size = UDim2.new(1, 0, 1, 0), Parent = Row,
		}, { Corner(6) })
		local BS = Stroke(Theme.Control, 1); BS.Parent = Btn
		local Sc = New("UIScale", { Parent = Btn })
		B.Btn, B.Label = Btn, Btn
		local armed = false
		Btn.MouseEnter:Connect(function() if not B.Disabled then Tween(Btn, { BackgroundColor3 = Theme.ElementHover }, 0.15) Tween(BS, { Color = Theme.Accent }, 0.15) end end)
		Btn.MouseLeave:Connect(function() Tween(Btn, { BackgroundColor3 = Theme.Element }, 0.2) Tween(BS, { Color = Theme.Control }, 0.2) Tween(Sc, { Scale = 1 }, 0.15) end)
		Btn.MouseButton1Down:Connect(function() if not B.Disabled then Tween(Sc, { Scale = 0.96 }, 0.1) end end)
		Btn.MouseButton1Up:Connect(function() Tween(Sc, { Scale = 1 }, 0.25, Back) end)
		Btn.MouseButton1Click:Connect(function()
			if B.Disabled then return end
			Ripple(Btn, UserInputService:GetMouseLocation())
			if inf.DoubleClick and not armed then
				armed = true
				Btn.Text = "Click again to confirm"
				Tween(Btn, { TextColor3 = Theme.AccentText }, 0.15)
				task.delay(0.9, function()
					if armed then armed = false Btn.Text = inf.Text or "Button" Tween(Btn, { TextColor3 = Theme.Text }, 0.15) end
				end)
				return
			end
			armed = false
			Btn.Text = inf.Text or "Button"
			Tween(Btn, { TextColor3 = Theme.Text }, 0.15)
			if inf.Func then task.spawn(inf.Func) end
		end)
		TipFor(Btn, B, inf)
		function B:SetText(t) inf.Text = t Btn.Text = t end
		function B:SetDisabled(d) B.Disabled = d Tween(Btn, { TextTransparency = d and 0.6 or 0 }, 0.15) end
		function B:SetVisible(v) Btn.Visible = v Resize() end
		function B:AddButton(i2) return Group.Add(i2) end
		if inf.Disabled then B:SetDisabled(true) end
		if inf.Visible == false then Btn.Visible = false end
		table.insert(Group.Buttons, B)
		Resize()
		return B
	end
	Group.Add = function(i2) return Make(type(i2) == "table" and i2 or { Text = i2 }) end
	return Make(info)
end

function Base:AddLabel(a, b, c)
	local idx, text, wrap
	if type(b) == "table" then idx, text, wrap = a, b.Text or "", b.DoesWrap else text, wrap, idx = a, b, c end
	local Holder = self:_Row()
	local Head = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22), AutomaticSize = wrap and Enum.AutomaticSize.Y or Enum.AutomaticSize.None, Parent = Holder })
	local Label = Lbl({ Text = text, TextColor3 = Theme.Muted, TextWrapped = wrap and true or false, TextTruncate = wrap and Enum.TextTruncate.None or Enum.TextTruncate.AtEnd, Size = UDim2.new(1, 0, 0, 22), AutomaticSize = wrap and Enum.AutomaticSize.Y or Enum.AutomaticSize.None, Parent = Head })
	local L = NewElement("Label", {}, Holder, Label)
	L.Addons = NewAddons(Head, 0)
	function L:SetText(t) Label.Text = t end
	AttachAddons(L)
	if idx then Library.Labels[idx] = L end
	return L
end

function Base:AddDivider()
	local H = self:_Row()
	H.AutomaticSize = Enum.AutomaticSize.None
	H.Size = UDim2.new(1, 0, 0, 10)
	New("Frame", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = H }, {
		New("UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.45), NumberSequenceKeypoint.new(1, 1) }) }),
	})
end

function Base:AddSlider(idx, info)
	info = info or {}
	local Min, Max, Rounding = info.Min or 0, info.Max or 100, info.Rounding or 0
	local Holder = self:_Row()
	local Top = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18), Parent = Holder })
	local Label = Lbl({ Text = info.Compact and "" or (info.Text or idx), Size = UDim2.new(0.65, 0, 1, 0), Parent = Top })
	local ValueLbl = Lbl({ Font = FontN, TextColor3 = Theme.Muted, TextXAlignment = Right, Size = UDim2.new(0.35, 0, 1, 0), Position = UDim2.fromScale(0.65, 0), TextSize = 13, Parent = Top })
	local Hit = New("TextButton", { Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, Dim.Hit), Parent = Holder })
	local Track = New("Frame", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 8), BackgroundColor3 = Theme.Element, Parent = Hit }, { Corner(4) })
	local TS = Stroke(Theme.Control, 1); TS.Parent = Track
	local Fill = New("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = Theme.Accent, Parent = Track }, { Corner(4), New("UIGradient", { Color = ColorSequence.new(Theme.Accent, Lighten(Theme.Accent, 0.35)) }) })
	local Knob = New("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(10, 10), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 3, Parent = Track }, { Corner(8) })
	local S = NewElement("Slider", info, Holder, Label)
	S.Min, S.Max = Min, Max
	local function Fmt()
		if info.FormatDisplayValue then
			local ok, r = pcall(info.FormatDisplayValue, S, S.Value)
			if ok and r then return tostring(r) end
		end
		local suf = info.Suffix or ""
		if info.HideMax or info.Compact then return S.Value .. suf end
		return S.Value .. suf .. " / " .. Max .. suf
	end
	local function Render(animate)
		local f = Max == Min and 0 or (S.Value - Min) / (Max - Min)
		local t = animate and 0.12 or 0
		Tween(Fill, { Size = UDim2.fromScale(f, 1) }, t)
		Tween(Knob, { Position = UDim2.fromScale(f, 0.5) }, t)
		ValueLbl.Text = Fmt()
	end
	function S:SetValue(v)
		v = math.clamp(Round(tonumber(v) or Min, Rounding), Min, Max)
		local changed = v ~= S.Value
		S.Value = v
		Render(true)
		if changed then S:_Fire() end
	end
	function S:SetMax(m) Max, S.Max = m, m S:SetValue(S.Value) end
	function S:SetMin(m) Min, S.Min = m, m S:SetValue(S.Value) end
	Drag(Hit, function(m)
		if S.Disabled then return end
		local f = math.clamp((m.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
		S:SetValue(Min + (Max - Min) * f)
	end, function()
		Tween(Knob, { Size = UDim2.fromOffset(16, 16) }, 0.2, Back)
		Tween(ValueLbl, { TextColor3 = Theme.AccentText }, 0.15)
	end, function()
		Tween(Knob, { Size = UDim2.fromOffset(10, 10) }, 0.2)
		Tween(ValueLbl, { TextColor3 = Theme.Muted }, 0.15)
	end)
	Hit.MouseEnter:Connect(function() Tween(TS, { Color = Theme.Accent }, 0.15) end)
	Hit.MouseLeave:Connect(function() Tween(TS, { Color = Theme.Control }, 0.15) end)
	Library:OnAccent(function(c)
		Fill.BackgroundColor3 = c
		Fill:FindFirstChildOfClass("UIGradient").Color = ColorSequence.new(c, Lighten(c, 0.35))
	end)
	Library:AddTooltip(Hit, function()
		if S.Disabled and info.DisabledTooltip then return info.DisabledTooltip end
		return (info.Tooltip and (info.Tooltip .. "\n") or "") .. "Right-click to type a value"
	end)
	Hit.MouseButton2Click:Connect(function()
		if S.Disabled then return end
		local Box = New("TextBox", { Text = tostring(S.Value), Font = FontN, TextSize = 13, TextColor3 = Theme.Text, BackgroundColor3 = Theme.Panel, ClearTextOnFocus = false, Size = UDim2.new(0.35, 0, 1, 0), Position = UDim2.fromScale(0.65, 0), ZIndex = 5, Parent = Top }, { Corner(4), Stroke(Theme.Accent, 1) })
		ValueLbl.Visible = false
		Box:CaptureFocus()
		Box.FocusLost:Connect(function(enter)
			local n = tonumber(Box.Text)
			if enter and n then S:SetValue(n) end
			ValueLbl.Visible = true
			Box:Destroy()
		end)
	end)
	S.Value = math.clamp(info.Default or Min, Min, Max)
	S.Default = S.Value
	Render(false)
	if info.Disabled then S:SetDisabled(true) end
	if info.Visible == false then Holder.Visible = false end
	if idx then Library.Options[idx] = S end
	return S
end

function Base:AddInput(idx, info)
	info = info or {}
	local Holder = self:_Row()
	local Label
	if info.Text then Label = Lbl({ Text = info.Text, Size = UDim2.new(1, 0, 0, 18), Parent = Holder }) end
	local Box = New("TextBox", {
		Text = info.Default or "", PlaceholderText = info.Placeholder or "", PlaceholderColor3 = Theme.Muted, TextColor3 = Theme.Text,
		Font = FontM, TextSize = 14, TextXAlignment = Left, ClearTextOnFocus = info.ClearTextOnFocus == true,
		BackgroundColor3 = Theme.Element, Size = UDim2.new(1, 0, 0, Dim.Input), ClipsDescendants = true, Parent = Holder,
	}, { Corner(6), Pad(0, 8) })
	local BS = Stroke(Theme.Control, 1); BS.Parent = Box
	local I = NewElement("Input", info, Holder, Label)
	I.Value = Box.Text
	I.Default = I.Value
	function I:SetValue(t)
		t = tostring(t)
		if info.MaxLength then t = t:sub(1, info.MaxLength) end
		Box.Text = t
		if I.Value ~= t then I.Value = t I:_Fire() end
	end
	Box:GetPropertyChangedSignal("Text"):Connect(function()
		local t = Box.Text
		if info.Numeric then
			local clean = t:gsub("[^%d%.%-]", "")
			if clean ~= t then Box.Text = clean return end
		end
		if info.MaxLength and #t > info.MaxLength then Box.Text = t:sub(1, info.MaxLength) return end
		if not info.Finished and I.Value ~= t then I.Value = t I:_Fire() end
	end)
	Box.Focused:Connect(function() Tween(BS, { Color = Theme.Accent, Thickness = 1.5 }, 0.15) Tween(Box, { BackgroundColor3 = Theme.ElementHover }, 0.15) end)
	Box.FocusLost:Connect(function(enter)
		Tween(BS, { Color = Theme.Control, Thickness = 1 }, 0.15) Tween(Box, { BackgroundColor3 = Theme.Element }, 0.15)
		if info.Finished and enter then I.Value = Box.Text I:_Fire() end
	end)
	TipFor(Box, I, info)
	if info.Visible == false then Holder.Visible = false end
	if idx then Library.Options[idx] = I end
	return I
end

function Base:AddDropdown(idx, info)
	info = info or {}
	local Holder = self:_Row()
	local Label
	if info.Text then Label = Lbl({ Text = info.Text, Size = UDim2.new(1, 0, 0, 18), Parent = Holder }) end
	local Head = New("TextButton", { Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.Element, Size = UDim2.new(1, 0, 0, Dim.Input), ClipsDescendants = true, Parent = Holder }, { Corner(6) })
	local HS = Stroke(Theme.Control, 1); HS.Parent = Head
	local Disp = Lbl({ Size = UDim2.new(1, -30, 1, 0), Position = UDim2.fromOffset(8, 0), TextTruncate = Enum.TextTruncate.AtEnd, Parent = Head })
	local Arrow = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -4, 0.5, 0), Size = UDim2.fromOffset(20, 20), Parent = Head })
	local ArrowBars = {}
	for _, d in ipairs({ { -3, 45 }, { 3, -45 } }) do
		table.insert(ArrowBars, New("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, d[1], 0.5, 0), Size = UDim2.fromOffset(8, 2), Rotation = d[2], BackgroundColor3 = Theme.Muted, BorderSizePixel = 0, Parent = Arrow }, { Corner(1) }))
	end
	local ListF = New("Frame", { BackgroundColor3 = Theme.Element, Size = UDim2.new(1, 0, 0, 0), ClipsDescendants = true, Visible = false, LayoutOrder = 2, Parent = Holder }, { Corner(6) })
	local Search
	local topOff = 4
	if info.Searchable then
		Search = New("TextBox", { Text = "", PlaceholderText = "Search...", PlaceholderColor3 = Theme.Muted, TextColor3 = Theme.Text, Font = FontM, TextSize = 13, TextXAlignment = Left, ClearTextOnFocus = false, BackgroundColor3 = Theme.Panel, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 0, 24), Parent = ListF }, { Corner(5), Pad(0, 6) })
		topOff = 32
	end
	local Scroll = New("ScrollingFrame", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(0, topOff), Size = UDim2.new(1, 0, 1, -topOff - 2), ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Accent, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = ListF }, { List(2), Pad(0, 4) })

	local D = NewElement("Dropdown", info, Holder, Label)
	D.Multi = info.Multi or false
	D.Values = info.Values or {}
	D.DisabledValues = {}
	for _, v in ipairs(info.DisabledValues or {}) do D.DisabledValues[v] = true end
	D.Value = D.Multi and {} or nil
	local open, items = false, {}

	local function Show(v)
		if info.FormatDisplayValue then local ok, r = pcall(info.FormatDisplayValue, v) if ok and r then return tostring(r) end end
		return tostring(v)
	end
	local function UpdateDisplay()
		if D.Multi then
			local sel = {}
			for _, v in ipairs(D.Values) do if D.Value[v] then table.insert(sel, Show(v)) end end
			Disp.Text = #sel > 0 and table.concat(sel, ", ") or (info.Placeholder or "Select...")
		else
			Disp.Text = D.Value ~= nil and Show(D.Value) or (info.Placeholder or "Select...")
		end
		for v, it in pairs(items) do
			local sel = D.Multi and D.Value[v] or D.Value == v
			Tween(it.Label, { TextColor3 = sel and Theme.AccentText or (D.DisabledValues[v] and Theme.Muted or Theme.Text) }, 0.15)
			Tween(it.Bar, { Size = UDim2.fromOffset(3, sel and 14 or 0) }, 0.2)
		end
	end
	local function ListHeight()
		local n = math.max(1, math.min(#D.Values, info.MaxVisibleDropdownItems or 8))
		return n * (Dim.Item + 2) + topOff + 6
	end
	local function SetOpen(o)
		open = o
		if o then
			ListF.Visible = true
			Tween(ListF, { Size = UDim2.new(1, 0, 0, ListHeight()) }, 0.3)
		else
			Tween(ListF, { Size = UDim2.new(1, 0, 0, 0) }, 0.22)
			task.delay(0.23, function() if not open then ListF.Visible = false end end)
		end
		Tween(Arrow, { Rotation = o and 180 or 0 }, Mo.Base)
		for _, b in ipairs(ArrowBars) do Tween(b, { BackgroundColor3 = o and Theme.AccentText or Theme.Muted }, Mo.Base) end
		Tween(HS, { Color = o and Theme.Accent or Theme.Outline }, 0.2)
	end
	local function Build()
		for _, c in ipairs(Scroll:GetChildren()) do if c:IsA("GuiObject") then c:Destroy() end end
		items = {}
		if #D.Values == 0 then Lbl({ Text = "No options available", TextSize = 13, TextColor3 = Theme.Muted, Size = UDim2.new(1, 0, 0, Dim.Item), Parent = Scroll }) end
		for i, v in ipairs(D.Values) do
			local b = New("TextButton", { Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.ElementHover, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, Dim.Item), LayoutOrder = i, Parent = Scroll }, { Corner(5) })
			local bar = New("Frame", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 2, 0.5, 0), Size = UDim2.fromOffset(3, 0), BackgroundColor3 = Theme.Accent, Parent = b }, { Corner(2) })
			local l = Lbl({ Text = Show(v), TextSize = 13, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -12, 1, 0), TextTransparency = D.DisabledValues[v] and 0.5 or 0, Parent = b })
			items[v] = { Btn = b, Label = l, Bar = bar }
			b.MouseEnter:Connect(function() if not D.DisabledValues[v] then Tween(b, { BackgroundTransparency = 0.4 }, 0.12) end end)
			b.MouseLeave:Connect(function() Tween(b, { BackgroundTransparency = 1 }, 0.12) end)
			b.MouseButton1Click:Connect(function()
				if D.DisabledValues[v] then return end
				if D.Multi then D.Value[v] = (not D.Value[v]) or nil else D.Value = v SetOpen(false) end
				UpdateDisplay() D:_Fire()
			end)
		end
		UpdateDisplay()
	end
	function D:SetValue(v)
		if D.Multi then
			D.Value = {}
			if type(v) == "table" then for k, val in pairs(v) do if type(k) == "number" then D.Value[val] = true elseif val then D.Value[k] = true end end
			elseif v then D.Value[v] = true end
		else
			if type(v) == "number" then v = D.Values[v] end
			D.Value = v
		end
		UpdateDisplay() D:_Fire()
	end
	function D:SetValues(vals) D.Values = vals Build() if open then SetOpen(true) end end
	function D:SetDisabledValues(t) D.DisabledValues = {} for _, v in ipairs(t) do D.DisabledValues[v] = true end Build() end
	function D:GetActiveValues()
		if not D.Multi then return D.Value and { D.Value } or {} end
		local r = {} for v in pairs(D.Value) do table.insert(r, v) end return r
	end
	if Search then
		Search:GetPropertyChangedSignal("Text"):Connect(function()
			local q = Search.Text:lower()
			for v, it in pairs(items) do it.Btn.Visible = q == "" or tostring(v):lower():find(q, 1, true) ~= nil end
		end)
	end
	Head.MouseButton1Click:Connect(function() if not D.Disabled then SetOpen(not open) end end)
	Head.MouseEnter:Connect(function() Tween(Head, { BackgroundColor3 = Theme.ElementHover }, 0.15) end)
	Head.MouseLeave:Connect(function() Tween(Head, { BackgroundColor3 = Theme.Element }, 0.15) end)
	Library:OnAccent(function() UpdateDisplay() end)
	TipFor(Head, D, info)

	if info.SpecialType == "Player" then
		local function Refresh()
			local names = {}
			for _, p in ipairs(Players:GetPlayers()) do if not (info.ExcludeLocalPlayer and p == LocalPlayer) then table.insert(names, p.Name) end end
			D.Values = names Build()
		end
		Library:Connect(Players.PlayerAdded, Refresh) Library:Connect(Players.PlayerRemoving, function() task.defer(Refresh) end)
		Refresh()
	elseif info.SpecialType == "Team" then
		local names = {} for _, t in ipairs(Teams:GetTeams()) do table.insert(names, t.Name) end
		D.Values = names Build()
	else Build() end

	local def = info.Default
	D.Default = def
	if def ~= nil then
		if D.Multi then
			if type(def) == "table" then D:SetValue(def) elseif type(def) == "number" then D.Value[D.Values[def]] = true elseif def then D.Value[def] = true end
		else D.Value = type(def) == "number" and D.Values[def] or def end
		UpdateDisplay()
	end
	if info.Disabled then D:SetDisabled(true) end
	if info.Visible == false then Holder.Visible = false end
	if idx then Library.Options[idx] = D end
	return D
end

function Base:AddDependencyBox()
	local Holder = self:_Row()
	local Box = setmetatable({ Container = Holder, Holder = Holder, Order = 0 }, Base)
	function Box:SetupDependencies(deps)
		local function Check()
			local ok = true
			for _, d in ipairs(deps) do
				local obj, want = d[1], d[2]
				if obj.Type == "Dropdown" then
					if obj.Multi then ok = ok and (obj.Value[want] and true or false) else ok = ok and obj.Value == want end
				else ok = ok and obj.Value == want end
			end
			Holder.Visible = ok
		end
		for _, d in ipairs(deps) do d[1]:OnChanged(Check) end
		Check()
	end
	return Box
end

---------------------------------------------------------------------
-- Groupbox / Tabbox / Tab / Window
---------------------------------------------------------------------
local function NewGroupbox(scroll, name)
	local Outer = New("Frame", { BackgroundColor3 = Theme.Panel, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = scroll }, { Corner(8), Stroke(), List(0) })
	local Title = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 32), Parent = Outer })
	local Bar = New("Frame", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(3, 14), BackgroundColor3 = Theme.Accent, Parent = Title }, { Corner(2) })
	Lbl({ Text = name, Font = FontB, Position = UDim2.fromOffset(21, 0), Size = UDim2.new(1, -30, 1, 0), Parent = Title })
	Library:OnAccent(function(c) Bar.BackgroundColor3 = c end)
	local Container = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, Parent = Outer }, { List(6), Pad(0, 10, 10, 10) })
	return setmetatable({ Container = Container, Order = 0, Outer = Outer }, Base)
end

local function NewTabbox(scroll)
	local Outer = New("Frame", { BackgroundColor3 = Theme.Panel, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = scroll }, { Corner(8), Stroke(), List(0) })
	local Header = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 32), Parent = Outer }, { List(0, Enum.FillDirection.Horizontal) })
	local Body = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, Parent = Outer })
	local TB = { Tabs = {}, Active = nil }
	function TB:AddTab(name)
		local Btn = New("TextButton", { Text = "", AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = Header })
		local L = Lbl({ Text = name, Font = FontB, TextColor3 = Theme.Muted, TextXAlignment = Center, Size = UDim2.fromScale(1, 1), Parent = Btn })
		local Line = New("Frame", { AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1), Size = UDim2.new(0, 0, 0, 2), BackgroundColor3 = Theme.Accent, Parent = Btn }, { Corner(1) })
		local Cont = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Visible = false, Parent = Body }, { List(6), Pad(2, 10, 10, 10) })
		local Tab = setmetatable({ Container = Cont, Order = 0 }, Base)
		Library:OnAccent(function(c) Line.BackgroundColor3 = c end)
		local function Set(on)
			Cont.Visible = on
			Tween(L, { TextColor3 = on and Theme.Text or Theme.Muted }, 0.2)
			Tween(Line, { Size = UDim2.new(on and 0.6 or 0, 0, 0, 2) }, 0.3)
		end
		Btn.MouseButton1Click:Connect(function()
			if TB.Active then TB.Active.Set(false) end
			TB.Active = { Set = Set } Set(true)
		end)
		table.insert(TB.Tabs, Btn)
		for _, b in ipairs(TB.Tabs) do b.Size = UDim2.new(1 / #TB.Tabs, 0, 1, 0) end
		if #TB.Tabs == 1 then TB.Active = { Set = Set } Set(true) end
		return Tab
	end
	return TB
end

function Library:CreateWindow(cfg)
	cfg = cfg or {}
	local Window = { Tabs = {}, TabList = {}, ActiveTab = nil, Visible = false }
	local windowPosition = cfg.Position or UDim2.fromScale(0.5, 0.5)
	local windowSize = cfg.Size or UDim2.fromOffset(720, 500)
	-- Layered shadow plates create a convincing floating / extruded 3D silhouette.
	local ShadowFar = New("Frame", { Name = "AzicDepthFar", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(windowPosition.X.Scale, windowPosition.X.Offset + 10, windowPosition.Y.Scale, windowPosition.Y.Offset + 16), Size = UDim2.new(windowSize.X.Scale, windowSize.X.Offset + 18, windowSize.Y.Scale, windowSize.Y.Offset + 18), BackgroundColor3 = Color3.fromRGB(2, 3, 10), BackgroundTransparency = 0.30, BorderSizePixel = 0, ZIndex = 1, Parent = Gui }, { Corner(22), Stroke(Color3.fromRGB(70, 55, 130), 1, 0.72) })
	local ShadowNear = New("Frame", { Name = "AzicDepthNear", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(windowPosition.X.Scale, windowPosition.X.Offset + 5, windowPosition.Y.Scale, windowPosition.Y.Offset + 9), Size = UDim2.new(windowSize.X.Scale, windowSize.X.Offset + 8, windowSize.Y.Scale, windowSize.Y.Offset + 8), BackgroundColor3 = Color3.fromRGB(9, 8, 20), BackgroundTransparency = 0.08, BorderSizePixel = 0, ZIndex = 1, Parent = Gui }, { Corner(19), Stroke(Theme.Accent, 1.2, 0.55) })
	local Main = New("CanvasGroup", {
		Name = "Main", AnchorPoint = Vector2.new(0.5, 0.5), Position = windowPosition,
		Size = windowSize, BackgroundColor3 = Theme.Background, GroupTransparency = 1, Visible = false, BorderSizePixel = 0, ZIndex = 1, Parent = Gui,
	}, { Corner(16) })
	local MainGradient = New("UIGradient", { Rotation = 110, Color = ColorSequence.new(Color3.fromRGB(25, 24, 43), Theme.Background), Parent = Main })
	local Scale = New("UIScale", { Scale = 0.86, Parent = Main })
	local MainStroke = Stroke(Theme.Accent, 2); MainStroke.Parent = Main
	local StrokeGrad = New("UIGradient", { Rotation = 25, Parent = MainStroke })
	local InnerRim = New("Frame", { Name = "InnerRim", BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 3, Parent = Main }, { Corner(13), Stroke(Color3.fromRGB(255, 255, 255), 1, 0.91) })
	Library:OnAccent(function(c)
		MainGradient.Color = ColorSequence.new(Lighten(c, 0.90), Theme.Background)
		ShadowNear:FindFirstChildOfClass("UIStroke").Color = c
	end)

	-- top bar: beveled glass plate with a bright top edge
	local Top = New("Frame", { BackgroundColor3 = Theme.Panel, BackgroundTransparency = 0.08, Size = UDim2.new(1, 0, 0, 48), BorderSizePixel = 0, Parent = Main }, { Corner(15), New("UIGradient", { Rotation = 90, Color = ColorSequence.new(Color3.fromRGB(48, 43, 75), Theme.Panel) }) })
	New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.88, BorderSizePixel = 0, Position = UDim2.fromOffset(14, 1), Size = UDim2.new(1, -28, 0, 1), ZIndex = 5, Parent = Top })
	local Logo = New("Frame", { Position = UDim2.fromOffset(14, 11), Size = UDim2.fromOffset(26, 26), BackgroundColor3 = Theme.Accent, Parent = Top }, { Corner(6), New("UIGradient", { Rotation = 45 }) })
	local LogoGrad = Logo:FindFirstChildOfClass("UIGradient")
	Lbl({ Text = "A", Font = FontB, TextXAlignment = Center, TextColor3 = Color3.new(1, 1, 1), Size = UDim2.fromScale(1, 1), Parent = Logo })
	Lbl({ Text = cfg.Title or "Azic UI", Font = FontB, TextSize = 15, Position = UDim2.fromOffset(50, 0), Size = UDim2.new(0.5, 0, 1, 0), Parent = Top })
	Lbl({ Text = "NEBULA  /  " .. Library.Version, TextSize = 10, TextColor3 = Theme.Muted, TextXAlignment = Right, Position = UDim2.new(1, -112, 0, 0), Size = UDim2.fromOffset(100, 48), Parent = Top })
	local Close = New("TextButton", { Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.Risk, BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(Dim.Close, Dim.Close), Parent = Top }, { Corner(7) })
	local CrossBars = {}
	for _, r in ipairs({ 45, -45 }) do
		table.insert(CrossBars, New("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(14, 2), Rotation = r, BackgroundColor3 = Theme.Muted, BorderSizePixel = 0, Parent = Close }, { Corner(1) }))
	end
	Close.MouseEnter:Connect(function()
		Tween(Close, { BackgroundTransparency = 0.1 }, Mo.Fast)
		for _, b in ipairs(CrossBars) do Tween(b, { BackgroundColor3 = Color3.new(1, 1, 1) }, Mo.Fast) end
	end)
	Close.MouseLeave:Connect(function()
		Tween(Close, { BackgroundTransparency = 1 }, Mo.Base)
		for _, b in ipairs(CrossBars) do Tween(b, { BackgroundColor3 = Theme.Muted }, Mo.Base) end
	end)
	Close.MouseButton1Click:Connect(function()
		Window:SetVisible(false)
		local k = Library.ToggleKeybind
		local name = typeof(k) == "EnumItem" and k.Name or (type(k) == "table" and tostring(k.Value)) or "your menu key"
		Library:Notify({ Title = "Menu hidden", Description = "Press " .. name .. " to open it again.", Time = 3 })
	end)

	-- Persistent floating open/close control: remains visible while the window is hidden.
	local FloatSize = IsTouch and 58 or 50
	local FloatShadow = New("Frame", {
		Name = "AzicOpenCloseShadow", AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 21, 1, -16), Size = UDim2.fromOffset(FloatSize, FloatSize),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.42,
		BorderSizePixel = 0, ZIndex = 499, Parent = Gui,
	}, { Corner(18) })
	local Floating = New("TextButton", {
		Name = "AzicOpenClose", Text = "", AutoButtonColor = false,
		AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 18, 1, -22),
		Size = UDim2.fromOffset(FloatSize, FloatSize),
		BackgroundColor3 = Theme.Panel, BorderSizePixel = 0, ZIndex = 500, Parent = Gui,
	}, { Corner(18), Stroke(Theme.Accent, 2) })
	local FloatGrad = New("UIGradient", {
		Rotation = 135,
		Color = ColorSequence.new(Theme.Element, Theme.Panel),
		Parent = Floating,
	})
	local FloatCore = New("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.70, 0.70), BackgroundColor3 = Theme.Accent,
		BorderSizePixel = 0, ZIndex = 501, Parent = Floating,
	}, { Corner(11), New("UIGradient", { Rotation = 45, Color = ColorSequence.new(Theme.Accent, Lighten(Theme.Accent, 0.5)) }) })
	local FloatLabel = Lbl({
		Text = "A", Font = FontB, TextSize = 20, TextColor3 = Color3.new(1, 1, 1),
		TextXAlignment = Center, Size = UDim2.fromScale(1, 1), ZIndex = 502, Parent = FloatCore,
	})
	local FloatBevel = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(2, 2), Size = UDim2.new(1, -4, 1, -4), ZIndex = 503, Parent = Floating }, { Corner(16), Stroke(Color3.new(1, 1, 1), 1, 0.78) })
	local FloatScale = New("UIScale", { Scale = 1, Parent = Floating })
	Floating.MouseEnter:Connect(function()
		Tween(FloatScale, { Scale = 1.08 }, 0.14, Back)
		Tween(Floating, { BackgroundColor3 = Theme.ElementHover }, 0.14)
	end)
	Floating.MouseLeave:Connect(function()
		Tween(FloatScale, { Scale = 1 }, 0.16)
		Tween(Floating, { BackgroundColor3 = Theme.Panel }, 0.16)
	end)
	Floating.MouseButton1Click:Connect(function()
		Ripple(Floating, UserInputService:GetMouseLocation())
		Window:SetVisible(not Window.Visible)
	end)
	Library:OnAccent(function(c)
		FloatCore.BackgroundColor3 = c
		local g = FloatCore:FindFirstChildOfClass("UIGradient")
		if g then g.Color = ColorSequence.new(c, Lighten(c, 0.5)) end
		local st = Floating:FindFirstChildOfClass("UIStroke")
		if st then st.Color = c end
	end)
	Window.OpenCloseButton = Floating
	Window.OpenCloseShadow = FloatShadow
	local Line = New("Frame", { Position = UDim2.fromOffset(0, 48), Size = UDim2.new(1, 0, 0, 3), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = Main }, { New("UIGradient") })
	local LineGrad = Line:FindFirstChildOfClass("UIGradient")

	Library:OnAccent(function(c)
		local seq = ColorSequence.new({ ColorSequenceKeypoint.new(0, c), ColorSequenceKeypoint.new(0.5, Lighten(c, 0.6)), ColorSequenceKeypoint.new(1, c) })
		LineGrad.Color = seq
		LogoGrad.Color = ColorSequence.new(c, Lighten(c, 0.4))
		Logo.BackgroundColor3 = c
		StrokeGrad.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, c), ColorSequenceKeypoint.new(0.5, Theme.Outline), ColorSequenceKeypoint.new(1, c) })
	end)
	Library:Connect(RunService.RenderStepped, function()
		local t = os.clock()
		if Library.ReducedMotion or not Library.AmbientEffects then return end
		LineGrad.Offset = Vector2.new(((t * 0.4) % 2) - 1, 0)
		StrokeGrad.Rotation = (t * 45) % 360
		FloatGrad.Rotation = (135 + math.sin(t * 0.7) * 8) % 360
		local pulse = 1 + math.sin(t * 1.8) * 0.018
		FloatCore.Size = UDim2.fromScale(0.70 * pulse, 0.70 * pulse)
	end)

	-- dragging
	local dragging, dStart, dPos
	Top.InputBegan:Connect(function(i)
		if IsPress(i) then dragging, dStart, dPos = true, PosOf(i), Main.Position end
	end)
	Library:Connect(UserInputService.InputChanged, function(i)
		if dragging and IsMove(i) then
			local d = PosOf(i) - dStart
			local nextPos = UDim2.new(dPos.X.Scale, dPos.X.Offset + d.X, dPos.Y.Scale, dPos.Y.Offset + d.Y)
			Main.Position = nextPos
			ShadowNear.Position = UDim2.new(nextPos.X.Scale, nextPos.X.Offset + 5, nextPos.Y.Scale, nextPos.Y.Offset + 9)
			ShadowFar.Position = UDim2.new(nextPos.X.Scale, nextPos.X.Offset + 10, nextPos.Y.Scale, nextPos.Y.Offset + 16)
		end
	end)
	Library:Connect(UserInputService.InputEnded, function(i) if IsPress(i) then dragging = false end end)

	-- sidebar + content
	local Side = New("Frame", { BackgroundColor3 = Theme.Panel, BackgroundTransparency = 0.35, Position = UDim2.fromOffset(0, 51), Size = UDim2.new(0, 164, 1, -51), BorderSizePixel = 0, Parent = Main })
	New("UIGradient", { Rotation = 0, Color = ColorSequence.new(Color3.fromRGB(29, 27, 47), Theme.Panel), Parent = Side })
	New("Frame", { BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.18, Position = UDim2.new(1, -1, 0, 10), Size = UDim2.new(0, 1, 1, -20), BorderSizePixel = 0, Parent = Side })
	local TabList = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -50), Parent = Side }, { List(6), Pad(12, 8) })
	Lbl({ Text = "Welcome, " .. (LocalPlayer and LocalPlayer.DisplayName or "Player"), TextSize = 12, TextColor3 = Theme.Muted, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 14, 1, -10), Size = UDim2.new(1, -20, 0, 18), TextTruncate = Enum.TextTruncate.AtEnd, Parent = Side })
	local Content = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(164, 51), Size = UDim2.new(1, -164, 1, -51), Parent = Main }, { Pad(10) })

	-- resizing
	if cfg.Resizable ~= false then
		local Grip = New("TextButton", { Text = "", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 1), Position = UDim2.fromScale(1, 1), Size = UDim2.fromOffset(22, 22), ZIndex = 10, Parent = Main })
		for _, g in ipairs({ { -9, 12 }, { -5, 6 } }) do
			New("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(1, g[1], 1, g[1]), Size = UDim2.fromOffset(g[2], 2), Rotation = -45, BackgroundColor3 = Theme.Muted, BorderSizePixel = 0, Parent = Grip }, { Corner(1) })
		end
		Drag(Grip, function(pos)
			local ap = Main.AbsolutePosition
			local w, h = math.clamp(pos.X - ap.X, 540, 1500), math.clamp(pos.Y - ap.Y, 380, 1000)
			Main.Size = UDim2.fromOffset(w, h)
			ShadowNear.Size = UDim2.fromOffset(w + 8, h + 8)
			ShadowFar.Size = UDim2.fromOffset(w + 18, h + 18)
		end, function()
			local ap = Main.AbsolutePosition
			Main.AnchorPoint = Vector2.new(0, 0)
			Main.Position = UDim2.fromOffset(ap.X, ap.Y)
			ShadowNear.AnchorPoint, ShadowFar.AnchorPoint = Vector2.new(0, 0), Vector2.new(0, 0)
			ShadowNear.Position = UDim2.fromOffset(ap.X + 5, ap.Y + 9)
			ShadowFar.Position = UDim2.fromOffset(ap.X + 10, ap.Y + 16)
		end)
	end

	function Window:SetVisible(v)
		self.Visible = v
		if v then
			Main.Visible, ShadowNear.Visible, ShadowFar.Visible = true, Library.Style3D, Library.Style3D
			Main.GroupTransparency = 1
			Tween(Main, { GroupTransparency = 0 }, Mo.Slow)
			Tween(Scale, { Scale = 1 }, Mo.Enter, Back)
			Tween(ShadowNear, { BackgroundTransparency = 0.08 }, Mo.Slow)
			Tween(ShadowFar, { BackgroundTransparency = 0.30 }, Mo.Slow)
		else
			Tween(Main, { GroupTransparency = 1 }, Mo.Exit)
			Tween(Scale, { Scale = 0.88 }, Mo.Exit)
			Tween(ShadowNear, { BackgroundTransparency = 1 }, Mo.Exit)
			Tween(ShadowFar, { BackgroundTransparency = 1 }, Mo.Exit)
			task.delay(Mo.Exit + 0.06, function() if not self.Visible then Main.Visible, ShadowNear.Visible, ShadowFar.Visible = false, false, false end end)
		end
	end
	function Window:SetDepthVisible(enabled)
		ShadowNear.Visible = enabled and self.Visible
		ShadowFar.Visible = enabled and self.Visible
		MainStroke.Thickness = enabled and 2 or 1
		InnerRim.Visible = enabled
	end
	function Window:SelectTab(tab)
		if self.ActiveTab == tab then return end
		if self.ActiveTab then self.ActiveTab:_SetActive(false) end
		self.ActiveTab = tab
		tab:_SetActive(true)
	end

	function Window:AddTab(name, tabOptions)
		local opts = type(tabOptions) == "table" and tabOptions or { Icon = tabOptions }
		local Tab = { Name = name, Active = false, Icon = opts.Icon }
		local Btn = New("TextButton", { Text = "", AutoButtonColor = false, BackgroundColor3 = Theme.Element, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, Dim.Tab), Parent = TabList }, { Corner(7) })
		local iconAsset = Library:GetIcon(opts.Icon) or (type(opts.Icon) == "string" and (opts.Icon:match("^rbxassetid://") and opts.Icon or nil))
		if iconAsset then
			New("ImageLabel", { BackgroundTransparency = 1, Image = iconAsset, ImageColor3 = Theme.Muted, Position = UDim2.fromOffset(11, (Dim.Tab - 20) / 2), Size = UDim2.fromOffset(20, 20), Parent = Btn })
		elseif opts.Icon then
			local tile = New("Frame", { BackgroundColor3 = Theme.Element, Position = UDim2.fromOffset(9, (Dim.Tab - 24) / 2), Size = UDim2.fromOffset(24, 24), Parent = Btn }, { Corner(7), Stroke(Theme.Outline, 1) })
			Lbl({ Text = string.upper(string.sub(tostring(opts.Icon), 1, 1)), Font = FontB, TextSize = 12, TextXAlignment = Center, TextColor3 = Theme.AccentText, Size = UDim2.fromScale(1, 1), Parent = tile })
		end
		local textX = opts.Icon and 42 or 16
		local TL = Lbl({ Text = name, TextColor3 = Theme.Muted, Position = UDim2.fromOffset(textX, 0), Size = UDim2.new(1, -textX, 1, 0), Parent = Btn })
		local Ind = New("Frame", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(3, 0), BackgroundColor3 = Theme.Accent, Parent = Btn }, { Corner(2) })
		Library:OnAccent(function(c) Ind.BackgroundColor3 = c end)
		local Page = New("CanvasGroup", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, GroupTransparency = 1, Parent = Content })
		local function Col(xs, xo)
			return New("ScrollingFrame", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(xs, xo, 0, 0), Size = UDim2.new(0.5, -5, 1, 0), ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Accent, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = Page }, { List(10), Pad(0, 0, 4, 0) })
		end
		local LeftCol, RightCol = Col(0, 0), Col(0.5, 5)

		Btn.MouseEnter:Connect(function() if not Tab.Active then Tween(Btn, { BackgroundTransparency = 0.6 }, 0.15) Tween(TL, { TextColor3 = Theme.Text }, 0.15) end end)
		Btn.MouseLeave:Connect(function() if not Tab.Active then Tween(Btn, { BackgroundTransparency = 1 }, 0.15) Tween(TL, { TextColor3 = Theme.Muted }, 0.15) end end)
		Btn.MouseButton1Click:Connect(function() Ripple(Btn, UserInputService:GetMouseLocation()) Window:SelectTab(Tab) end)
		Btn.ClipsDescendants = true

		function Tab:_SetActive(on)
			Tab.Active = on
			if on then
				Page.Visible = true
				Page.Position = UDim2.fromOffset(0, 18)
				Tween(Page, { Position = UDim2.fromOffset(0, 0), GroupTransparency = 0 }, 0.4)
				Tween(Ind, { Size = UDim2.fromOffset(3, 18) }, 0.35, Back)
				Tween(TL, { TextColor3 = Theme.Text }, 0.2)
				Tween(Btn, { BackgroundTransparency = 0.3 }, 0.2)
			else
				Tween(Page, { GroupTransparency = 1 }, 0.15)
				Tween(Ind, { Size = UDim2.fromOffset(3, 0) }, 0.2)
				Tween(TL, { TextColor3 = Theme.Muted }, 0.2)
				Tween(Btn, { BackgroundTransparency = 1 }, 0.2)
				task.delay(0.16, function() if not Tab.Active then Page.Visible = false end end)
			end
		end
		function Tab:AddLeftGroupbox(n) return NewGroupbox(LeftCol, n) end
		function Tab:AddRightGroupbox(n) return NewGroupbox(RightCol, n) end
		function Tab:AddLeftTabbox() return NewTabbox(LeftCol) end
		function Tab:AddRightTabbox() return NewTabbox(RightCol) end

		Window.Tabs[name] = Tab
		table.insert(Window.TabList, Tab)
		if #Window.TabList == 1 then Window:SelectTab(Tab) end
		return Tab
	end

	ShadowNear.Visible, ShadowFar.Visible = false, false
	Library.Window = Window
	if cfg.ToggleKeybind then Library.ToggleKeybind = cfg.ToggleKeybind end
	if cfg.NotifySide then Library.NotifySide = cfg.NotifySide end
	if cfg.AutoShow ~= false then task.defer(function() Window:SetVisible(true) end) end
	return Window
end

function Library:ToggleUI() if self.Window then self.Window:SetVisible(not self.Window.Visible) end end

function Library:Set3DEnabled(enabled)
	self.Style3D = enabled == true
	if self.Window and self.Window.SetDepthVisible then self.Window:SetDepthVisible(self.Style3D) end
end


Library:Connect(UserInputService.InputBegan, function(input)
	if Library.Listener then
		if Library.Listener(input) then Library.Listener = nil end
		return
	end
	if UserInputService:GetFocusedTextBox() then return end
	local tk = Library.ToggleKeybind
	if typeof(tk) == "EnumItem" then
		if input.KeyCode == tk then Library:ToggleUI() end
	elseif type(tk) == "table" and tk.Matches and tk:Matches(input) then
		Library:ToggleUI()
	end
	for _, kp in ipairs(Library.KeyPickers) do if kp:Matches(input) then kp:_Down() end end
end)
Library:Connect(UserInputService.InputEnded, function(input)
	for _, kp in ipairs(Library.KeyPickers) do if kp:Matches(input) then kp:_Up() end end
end)

---------------------------------------------------------------------
-- Config system + settings builders
---------------------------------------------------------------------
local function FS() return writefile and readfile and isfolder and makefolder and listfiles and isfile end
local function CfgPath(name) return Library.ConfigFolder .. "/configs/" .. name .. ".json" end
local function Ensure()
	if not isfolder(Library.ConfigFolder) then makefolder(Library.ConfigFolder) end
	if not isfolder(Library.ConfigFolder .. "/configs") then makefolder(Library.ConfigFolder .. "/configs") end
end

function Library:GetConfigs()
	if not FS() then return {} end
	Ensure()
	local out = {}
	for _, p in ipairs(listfiles(self.ConfigFolder .. "/configs")) do
		local n = p:match("([^/\\]+)%.json$")
		if n then table.insert(out, n) end
	end
	return out
end

function Library:SaveConfig(name)
	if not FS() then return false, "Your executor does not support saving files" end
	if not name or name:gsub(" ", "") == "" then return false, "Enter a config name first" end
	Ensure()
	local d = {}
	local function skip(i) return i:sub(1, 5) == "Azic_" or table.find(self.IgnoreIndexes, i) end
	for idx, o in pairs(self.Toggles) do if not skip(idx) then d[idx] = { t = "Toggle", v = o.Value } end end
	for idx, o in pairs(self.Options) do
		if not skip(idx) then
			if o.Type == "ColorPicker" then d[idx] = { t = o.Type, v = { o.Value.R, o.Value.G, o.Value.B } }
			elseif o.Type == "KeyPicker" then d[idx] = { t = o.Type, v = o.Value, m = o.Mode }
			else d[idx] = { t = o.Type, v = o.Value } end
		end
	end
	local ok, err = pcall(function() writefile(CfgPath(name), HttpService:JSONEncode(d)) end)
	return ok, err
end

function Library:LoadConfig(name)
	if not FS() or not isfile(CfgPath(name)) then return false, "Select a saved config first" end
	local ok, d = pcall(function() return HttpService:JSONDecode(readfile(CfgPath(name))) end)
	if not ok then return false, "That config file is damaged. Save it again" end
	for idx, e in pairs(d) do
		local o = self.Toggles[idx] or self.Options[idx]
		if o then
			pcall(function()
				if e.t == "ColorPicker" then o:SetValue(Color3.new(e.v[1], e.v[2], e.v[3]))
				elseif e.t == "KeyPicker" then o:SetValue({ e.v, e.m })
				else o:SetValue(e.v) end
			end)
		end
	end
	return true
end

function Library:BuildThemeSection(group)
	local names = {}
	for n in pairs(self.Themes) do table.insert(names, n) end
	table.sort(names)
	group:AddDropdown("Azic_Theme", { Text = "Accent theme", Values = names, Default = "Violet", Callback = function(v) if v then Library:SetAccent(Library.Themes[v]) end end })
	group:AddLabel("Custom accent"):AddColorPicker("Azic_Accent", { Default = Theme.Accent, Title = "Accent color", Callback = function(c) Library:SetAccent(c) end })
	group:AddToggle("Azic_Reduce", { Text = "Reduce motion", Tooltip = "Instant transitions, no ambient effects", Callback = function(v) Library.ReducedMotion = v end })
	group:AddToggle("Azic_Ambient", { Text = "Ambient effects", Default = true, Tooltip = "Shimmer line and glowing border", Callback = function(v) Library.AmbientEffects = v end })
	group:AddSlider("Azic_AnimSpeed", { Text = "Animation speed", Default = 1, Min = 0.25, Max = 3, Rounding = 2, Suffix = "x", HideMax = true, Callback = function(v) Library.AnimationSpeed = v end })
end

function Library:BuildConfigSection(group)
	group:AddInput("Azic_CfgName", { Text = "Config name", Placeholder = "my-config" })
	local list = group:AddDropdown("Azic_CfgList", { Text = "Configs", Values = self:GetConfigs(), Default = 0, Placeholder = "No configs yet" })
	group:AddButton({ Text = "Save config", Func = function()
		local ok, err = Library:SaveConfig(Library.Options.Azic_CfgName.Value)
		Library:Notify(ok and { Type = "Success", Description = "Config saved." } or { Type = "Error", Title = "Couldn't save config", Description = tostring(err) .. "." })
		list:SetValues(Library:GetConfigs())
	end }):AddButton({ Text = "Load config", Func = function()
		local ok, err = Library:LoadConfig(list.Value)
		Library:Notify(ok and { Type = "Success", Description = "Config loaded." } or { Type = "Error", Title = "Couldn't load config", Description = tostring(err) .. "." })
	end })
	group:AddButton({ Text = "Refresh list", Func = function() list:SetValues(Library:GetConfigs()) end })
	group:AddButton({ Text = "Reset all to defaults", DoubleClick = true, Tooltip = "Resets every option (not themes or configs)", Func = function()
		Library:ResetAll()
		Library:Notify({ Type = "Warning", Title = "Defaults restored", Description = "All options were reset." })
	end })
end

function Library:ResetAll()
	for _, tbl in ipairs({ self.Toggles, self.Options }) do
		for idx, o in pairs(tbl) do
			if tostring(idx):sub(1, 5) ~= "Azic_" and not table.find(self.IgnoreIndexes, idx) then pcall(o.Reset, o) end
		end
	end
end

function Library:Unload()
	if self.Unloaded then return end
	self.Unloaded = true
	for _, f in ipairs(self.UnloadCallbacks) do pcall(f) end
	for _, c in ipairs(self.Signals) do pcall(function() c:Disconnect() end) end
	Gui:Destroy()
end

if getgenv then getgenv().AzicLibrary = Library end
return Library
