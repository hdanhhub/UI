-- HDANH HUB - CYBERPUNK DARK EDITION
-- Theme: Đen/xám than + Cyan neon + Vàng gold
-- Logic giữ nguyên từ bản gốc, giao diện thiết kế lại 100%

if getgenv().Nousigi then 
	if game.CoreGui:FindFirstChild("HDanh Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name, "HDanh Hub") then
				v:Destroy()
			end
		end
	end
end
getgenv().Nousigi = true

local DisableAnimation = game.Players.LocalPlayer.PlayerGui:FindFirstChild('TouchGui')

-- ============================================================
-- THEME: CYBERPUNK DARK
-- Nền đen xám than + accent cyan neon + chữ vàng gold
-- ============================================================
local T1UIColor = {
    ["Border Color"]                  = Color3.fromRGB(0, 210, 230),     -- cyan neon
    ["Click Effect Color"]            = Color3.fromRGB(0, 255, 210),     -- cyan sáng
    ["Setting Icon Color"]            = Color3.fromRGB(180, 220, 230),   -- cyan nhạt
    ["Logo Image"]                    = "rbxassetid://123613996022560",
    ["Search Icon Color"]             = Color3.fromRGB(0, 210, 230),     -- cyan
    ["Search Icon Highlight Color"]   = Color3.fromRGB(0, 255, 210),     -- cyan sáng hơn
    ["GUI Text Color"]                = Color3.fromRGB(255, 210, 80),    -- vàng gold
    ["Text Color"]                    = Color3.fromRGB(220, 230, 240),   -- trắng xanh
    ["Placeholder Text Color"]        = Color3.fromRGB(90, 110, 120),    -- xám xanh
    ["Title Text Color"]              = Color3.fromRGB(0, 210, 230),     -- cyan

    ["Background Main Color"]         = Color3.fromRGB(12, 14, 18),     -- đen than
    ["Background 1 Color"]            = Color3.fromRGB(18, 22, 30),     -- đen xanh nhạt
    ["Background 1 Transparency"]     = 0.05,
    ["Background 2 Color"]            = Color3.fromRGB(24, 30, 40),     -- xám xanh
    ["Background 3 Color"]            = Color3.fromRGB(16, 20, 26),     -- đen xanh tối
    ["Background Image"]              = "",

    ["Page Selected Color"]           = Color3.fromRGB(0, 210, 230),    -- cyan
    ["Section Text Color"]            = Color3.fromRGB(0, 210, 230),    -- cyan
    ["Section Underline Color"]       = Color3.fromRGB(0, 180, 200),    -- cyan tối hơn
    ["Toggle Border Color"]           = Color3.fromRGB(40, 80, 100),    -- xanh xám
    ["Toggle Checked Color"]          = Color3.fromRGB(0, 210, 230),    -- cyan
    ["Toggle Desc Color"]             = Color3.fromRGB(140, 170, 185),  -- xám xanh nhạt

    ["Button Color"]                  = Color3.fromRGB(22, 28, 38),     -- đen xanh
    ["Label Color"]                   = Color3.fromRGB(14, 18, 24),     -- đen tối
    ["Dropdown Icon Color"]           = Color3.fromRGB(0, 210, 230),    -- cyan
    ["Dropdown Selected Color"]       = Color3.fromRGB(0, 210, 230),    -- cyan
    ["Dropdown Selected Check Color"] = Color3.fromRGB(255, 210, 80),   -- vàng gold

    ["Textbox Highlight Color"]       = Color3.fromRGB(0, 210, 230),    -- cyan
    ["Box Highlight Color"]           = Color3.fromRGB(0, 150, 170),    -- cyan tối
    ["Slider Line Color"]             = Color3.fromRGB(20, 40, 55),     -- xanh tối
    ["Slider Highlight Color"]        = Color3.fromRGB(0, 210, 230),    -- cyan

    ["Tween Animation 1 Speed"]       = DisableAnimation and 0 or 0.25,
    ["Tween Animation 2 Speed"]       = DisableAnimation and 0 or 0.5,
    ["Tween Animation 3 Speed"]       = DisableAnimation and 0 or 0.1,
    ["Text Stroke Transparency"]      = .85
}

getgenv().UIColor = T1UIColor
getgenv().AllControls = {}
getgenv().UIToggled = false

local currcolor = {}
local Library = {};
local Library_Function = {}
local TweenService = game:GetService('TweenService')
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function makeDraggable(topBarObject, object)
	local dragging = nil
	local dragInput = nil
	local dragStart = nil
	local startPosition = nil
	topBarObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPosition = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	topBarObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	uis.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			if not djtmemay and cac then
				TweenService:Create(object, TweenInfo.new(DisableAnimation and 0 or 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
				}):Play()
			elseif not djtmemay and not cac then
				object.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
			end
		end
	end)
end

Library_Function.Gui = Instance.new('ScreenGui')
Library_Function.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.Gui.Name = 'HDanh Hub GUI'
Library_Function.Gui.Enabled = false

getgenv().ReadyForGuiLoaded = false
spawn(function()
	repeat
		task.wait()
	until getgenv().ReadyForGuiLoaded
	if getgenv().UIToggled then
		Library_Function.Gui.Enabled = true
	end
end)

Library_Function.NotiGui = Instance.new('ScreenGui')
Library_Function.NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.NotiGui.Name = 'HDanh Hub Notification'

Library_Function.HideGui = Instance.new('ScreenGui')
Library_Function.HideGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.HideGui.Name = 'HDanh Hub'

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ToggleScreenGui = Instance.new("ScreenGui")
ToggleScreenGui.Parent = game:GetService("CoreGui")
ToggleScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleScreenGui.Name = "NazuXWindowsToggleUltimate"

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- ============================================================
-- TOGGLE BUTTON - CYBERPUNK STYLE
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BananaToggleGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

local mainButton = Instance.new("ImageButton")
mainButton.Parent = screenGui
mainButton.Size = UDim2.new(0, 58, 0, 58)
mainButton.Position = UDim2.new(0, 12, 0.5, -29)
mainButton.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
mainButton.BackgroundTransparency = 0
mainButton.AutoButtonColor = false
mainButton.Image = "rbxassetid://123613996022560"
mainButton.ImageColor3 = Color3.fromRGB(0, 210, 230)
mainButton.ScaleType = Enum.ScaleType.Fit
mainButton.ZIndex = 10
mainButton.ClipsDescendants = true

-- Bo tròn hoàn toàn
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainButton

local icon = mainButton

-- UIStroke cyan neon
local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = mainButton
UIStroke.Color = Color3.fromRGB(0, 210, 230)
UIStroke.Thickness = 1.8
UIStroke.Transparency = 0.4

-- Glow effect bên trong
local innerGlow = Instance.new("Frame")
innerGlow.Parent = mainButton
innerGlow.Size = UDim2.new(1, 0, 1, 0)
innerGlow.BackgroundColor3 = Color3.fromRGB(0, 210, 230)
innerGlow.BackgroundTransparency = 0.88
innerGlow.BorderSizePixel = 0
innerGlow.ZIndex = 1
local innerGlowCorner = Instance.new("UICorner")
innerGlowCorner.CornerRadius = UDim.new(0, 10)
innerGlowCorner.Parent = innerGlow

local isToggled = true
local dragging = false
local dragStart
local startPos
local CLICK_DISTANCE = 6

local tweenOn = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenOff = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local fluentTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local hoverTweenInfo  = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local clickTweenInfo  = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local defaultTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local faded = false
local fadeOutTween = TweenService:Create(icon, defaultTweenInfo, { ImageTransparency = 0 })
local fadeInTween  = TweenService:Create(icon, defaultTweenInfo, { ImageTransparency = 0 })

mainButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragStart = input.Position
		startPos = mainButton.Position
		dragging = true
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then
		local delta = input.Position - dragStart
		if math.abs(delta.X) > CLICK_DISTANCE or math.abs(delta.Y) > CLICK_DISTANCE then
			mainButton.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		local delta = input.Position - dragStart
		if math.abs(delta.X) < CLICK_DISTANCE and math.abs(delta.Y) < CLICK_DISTANCE then
			isToggled = not isToggled
			if isToggled then
				TweenService:Create(mainButton, tweenOn, { BackgroundColor3 = Color3.fromRGB(12, 14, 18) }):Play()
			else
				TweenService:Create(mainButton, tweenOff, { BackgroundColor3 = Color3.fromRGB(6, 8, 12) }):Play()
			end
		end
		dragging = false
	end
end)

mainButton.MouseEnter:Connect(function()
	TweenService:Create(mainButton, fluentTweenInfo, { Size = UDim2.new(0, 62, 0, 62), BackgroundTransparency = 0 }):Play()
	TweenService:Create(UIStroke, fluentTweenInfo, { Transparency = 0.1 }):Play()
	TweenService:Create(mainButton, hoverTweenInfo, { BackgroundColor3 = Color3.fromRGB(16, 22, 30) }):Play()
end)

mainButton.MouseLeave:Connect(function()
	local targetColor = isToggled and Color3.fromRGB(12, 14, 18) or Color3.fromRGB(6, 8, 12)
	TweenService:Create(mainButton, fluentTweenInfo, { Size = UDim2.new(0, 58, 0, 58), BackgroundTransparency = 0 }):Play()
	TweenService:Create(UIStroke, fluentTweenInfo, { Transparency = 0.4 }):Play()
	TweenService:Create(mainButton, defaultTweenInfo, { BackgroundColor3 = targetColor }):Play()
end)

mainButton.MouseButton1Down:Connect(function()
	TweenService:Create(mainButton, hoverTweenInfo, { Size = UDim2.new(0, 54, 0, 54), BackgroundColor3 = Color3.fromRGB(0, 40, 50) }):Play()
end)

mainButton.MouseButton1Click:Connect(function()
	Library.ToggleUI()
	isToggled = getgenv().UIToggled
	local scaleTween = TweenService:Create(mainButton, clickTweenInfo, { Size = UDim2.new(0, 53, 0, 53) })
	local scaleBackTween = TweenService:Create(mainButton, clickTweenInfo, { Size = UDim2.new(0, 58, 0, 58) })
	local targetColor = isToggled and Color3.fromRGB(12, 14, 18) or Color3.fromRGB(6, 8, 12)
	local colorTween = TweenService:Create(mainButton, defaultTweenInfo, { BackgroundColor3 = targetColor })
	if faded then fadeOutTween:Play() else fadeInTween:Play() end
	faded = not faded
	scaleTween:Play()
	colorTween:Play()
	spawn(function() wait(0.15) scaleBackTween:Play() end)
end)

Library.ToggleUI = function()
	getgenv().UIToggled = not getgenv().UIToggled
	if game.CoreGui:FindFirstChild("HDanh Hub GUI") then
		for a, b in ipairs(game.CoreGui:GetChildren()) do
			if b.Name == "HDanh Hub GUI" then
				b.Enabled = getgenv().UIToggled
			end
		end
	end
	isToggled = getgenv().UIToggled
	local targetColor = isToggled and Color3.fromRGB(12, 14, 18) or Color3.fromRGB(6, 8, 12)
	TweenService:Create(mainButton, defaultTweenInfo, { BackgroundColor3 = targetColor }):Play()
end

Library.DestroyUI = function()
	if game.CoreGui:FindFirstChild("HDanh Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name, "HDanh Hub") then v:Destroy() end
		end
	end
	local toggleGui = game.CoreGui:FindFirstChild("NazuXWindowsToggleUltimate")
	if toggleGui then toggleGui:Destroy() end
	getgenv().Nousigi = false
	getgenv().UIToggled = false
	getgenv().AllControls = {}
	getgenv().ReadyForGuiLoaded = false
end

-- ============================================================
-- NOTIFICATION SYSTEM
-- ============================================================
local NotiContainer = Instance.new("Frame")
local NotiList = Instance.new("UIListLayout")
NotiContainer.Name = "NotiContainer"
NotiContainer.Parent = Library_Function.NotiGui
NotiContainer.AnchorPoint = Vector2.new(1, 1)
NotiContainer.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
NotiContainer.BackgroundTransparency = 1.000
NotiContainer.Position = UDim2.new(1, -5, 1, -5)
NotiContainer.Size = UDim2.new(0, 350, 1, -10)
NotiList.Name = "NotiList"
NotiList.Parent = NotiContainer
NotiList.SortOrder = Enum.SortOrder.LayoutOrder
NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotiList.Padding = UDim.new(0, 5)

Library_Function.Gui.Parent = game:GetService('CoreGui')
Library_Function.NotiGui.Parent = game:GetService('CoreGui')
Library_Function.HideGui.Parent = game:GetService('CoreGui')

function Library_Function.Getcolor(color)
	return { math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255) }
end

local libCreateNoti = function(Setting)
	getgenv().TitleNameNoti = Setting.Title or ""
	local Description = Setting.Description or Setting.Desc or Setting.Content or ""
	local Duration = Setting.Duration or Setting.Timeshow or Setting.Delay or 10

	local NotiFrame = Instance.new("Frame")
	local Noticontainer = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local NotiStroke = Instance.new("UIStroke")
	local Title_1 = Instance.new("TextLabel")
	local TextButton = Instance.new("TextButton")
	local CloseImage = Instance.new("ImageLabel")

	NotiFrame.Name = "NotiFrame"
	NotiFrame.Parent = NotiContainer
	NotiFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
	NotiFrame.BackgroundTransparency = 1
	NotiFrame.Size = UDim2.new(1, 0, 0, 60)
	NotiFrame.ClipsDescendants = true

	Noticontainer.Name = "Noticontainer"
	Noticontainer.Parent = NotiFrame
	Noticontainer.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
	Noticontainer.Size = UDim2.new(1, 0, 1, 0)
	Noticontainer.Position = UDim2.new(1, 0, 0, 0)

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Noticontainer

	NotiStroke.Color = Color3.fromRGB(0, 210, 230)
	NotiStroke.Thickness = 1
	NotiStroke.Transparency = 0.5
	NotiStroke.Parent = Noticontainer

	-- Left accent bar
	local accentBar = Instance.new("Frame")
	accentBar.Parent = Noticontainer
	accentBar.Size = UDim2.new(0, 3, 1, 0)
	accentBar.BackgroundColor3 = Color3.fromRGB(0, 210, 230)
	accentBar.BorderSizePixel = 0
	local accentCorner = Instance.new("UICorner")
	accentCorner.CornerRadius = UDim.new(0, 3)
	accentCorner.Parent = accentBar

	Title_1.Name = "Title"
	Title_1.Parent = Noticontainer
	Title_1.BackgroundTransparency = 1
	Title_1.Position = UDim2.new(0, 14, 0, 8)
	Title_1.Size = UDim2.new(1, -40, 0, 20)
	Title_1.Font = Enum.Font.GothamBold
	Title_1.Text = getgenv().TitleNameNoti
	Title_1.TextSize = 14
	Title_1.TextXAlignment = Enum.TextXAlignment.Left
	Title_1.TextColor3 = Color3.fromRGB(0, 210, 230)

	TextButton.Name = "CloseBtn"
	TextButton.Parent = Noticontainer
	TextButton.BackgroundTransparency = 1
	TextButton.AnchorPoint = Vector2.new(1, 0)
	TextButton.Position = UDim2.new(1, -5, 0, 5)
	TextButton.Size = UDim2.new(0, 20, 0, 20)
	TextButton.Text = ""

	CloseImage.Name = "CloseImage"
	CloseImage.Parent = TextButton
	CloseImage.AnchorPoint = Vector2.new(0.5, 0.5)
	CloseImage.BackgroundTransparency = 1
	CloseImage.Position = UDim2.new(0.5, 0, 0.5, 0)
	CloseImage.Size = UDim2.new(0.8, 0, 0.8, 0)
	CloseImage.Image = "rbxassetid://3926305904"
	CloseImage.ImageRectOffset = Vector2.new(284, 4)
	CloseImage.ImageRectSize = Vector2.new(24, 24)
	CloseImage.ImageColor3 = getgenv().UIColor["Search Icon Color"]

	if Description and Description ~= "" then
		NotiFrame.Size = UDim2.new(1, 0, 0, 80)
		local TextLabelNoti2 = Instance.new("TextLabel")
		TextLabelNoti2.BackgroundTransparency = 1
		TextLabelNoti2.Position = UDim2.new(0, 14, 0, 30)
		TextLabelNoti2.Size = UDim2.new(1, -20, 0, 0)
		TextLabelNoti2.Font = Enum.Font.GothamBold
		TextLabelNoti2.Text = Description
		TextLabelNoti2.TextSize = 12
		TextLabelNoti2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabelNoti2.RichText = true
		TextLabelNoti2.TextColor3 = getgenv().UIColor["Text Color"]
		TextLabelNoti2.AutomaticSize = Enum.AutomaticSize.Y
		TextLabelNoti2.TextWrapped = true
		TextLabelNoti2.Parent = Noticontainer
	end

	local function remove()
		TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			Position = UDim2.new(1, 0, 0, 0)
		}):Play()
		wait(.25)
		NotiFrame:Destroy()
	end

	TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
		Position = UDim2.new(0, 0, 0, 0)
	}):Play()

	TextButton.MouseEnter:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
		}):Play()
	end)
	TextButton.MouseLeave:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Color"]
		}):Play()
	end)
	TextButton.MouseButton1Click:Connect(function() wait(.25) remove() end)
	spawn(function() wait(Duration) remove() end)
end

function Library:Notify(Setting, bypass)
	if not getgenv().Config or bypass then
		local s, e = pcall(function() libCreateNoti(Setting) end)
		if e then print(e) end
	end
end

-- ============================================================
-- CREATE WINDOW - CYBERPUNK DARK
-- ============================================================
function Library:CreateWindow(Setting)
	local TitleNameMain = Setting.Title or "HDANH HUB"
	getgenv().MainDesc = Setting.Desc or Setting.Subtitle or ""
	if Setting.Image then getgenv().UIColor["Logo Image"] = Setting.Image end

	local djtmemay = false
	cac = false

	local Main = Instance.new("Frame")
	local maingui = Instance.new("ImageLabel")
	local MainCorner = Instance.new("UICorner")
	local TopMain = Instance.new("Frame")
	local Ruafimg = Instance.new("ImageLabel")
	local TextLabelMain = Instance.new("TextLabel")
	local PageControl = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local ControlList = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local ControlTitle = Instance.new("TextLabel")
	local MainPage = Instance.new("Frame")
	local UIPage = Instance.new("UIPageLayout")
	local Concacontainer = Instance.new("Frame")
	local Concacmain = Instance.new("Frame")
	local MainContainer

	-- Main frame
	Main.Name = "Main"
	Main.Parent = Library_Function.Gui
	Main.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
	Main.BackgroundTransparency = 1
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Size = UDim2.new(0, 640, 0, 365)
	makeDraggable(Main, Main)

	maingui.Name = "maingui"
	maingui.Parent = Main
	maingui.AnchorPoint = Vector2.new(0.5, 0.5)
	maingui.BackgroundTransparency = 1
	maingui.Position = UDim2.new(0.5, 0, 0.5, 0)
	maingui.Size = UDim2.new(1, 30, 1, 30)
	maingui.Image = "rbxassetid://8068653048"
	maingui.ScaleType = Enum.ScaleType.Slice
	maingui.SliceCenter = Rect.new(15, 15, 175, 175)
	maingui.SliceScale = 1.3
	maingui.ImageColor3 = Color3.fromRGB(0, 210, 230)
	maingui.ImageTransparency = 1

	-- Main container - nền đen xám than
	MainContainer = Instance.new("ImageLabel")
	MainContainer.Name = "MainContainer"
	MainContainer.Parent = Main
	MainContainer.BackgroundColor3 = Color3.fromRGB(10, 12, 16)
	MainContainer.Size = UDim2.new(1, 0, 1, 0)

	local uistr = Instance.new("UIStroke", MainContainer)
	uistr.Thickness = 1.2
	uistr.Color = Color3.fromRGB(0, 210, 230)
	uistr.Transparency = 0.3

	-- Gradient nền phủ nhẹ cyan/xanh
	local uigradient = Instance.new("UIGradient", MainContainer)
	uigradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 180, 210)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 80, 120))
	}
	uigradient.Rotation = 135
	uigradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.94),
		NumberSequenceKeypoint.new(1, 0.97)
	}

	getgenv().ReadyForGuiLoaded = true

	MainCorner.CornerRadius = UDim.new(0, 8)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = MainContainer

	Concacontainer.Name = "Concacontainer"
	Concacontainer.Parent = MainContainer
	Concacontainer.BackgroundTransparency = 1
	Concacontainer.ClipsDescendants = true
	Concacontainer.Position = UDim2.new(0, 0, 0, 32)
	Concacontainer.Size = UDim2.new(1, 0, 1, -32)

	Concacmain.Name = "Concacmain"
	Concacmain.Parent = Concacontainer
	Concacmain.BackgroundTransparency = 1
	Concacmain.Size = UDim2.new(1, 0, 1, 0)

	-- ============================================================
	-- TOP BAR - cyberpunk style với đường kẻ cyan
	-- ============================================================
	TopMain.Name = "TopMain"
	TopMain.Parent = MainContainer
	TopMain.BackgroundColor3 = Color3.fromRGB(8, 10, 14)
	TopMain.BackgroundTransparency = 0.0
	TopMain.Size = UDim2.new(1, 0, 0, 32)

	local TopCorner = Instance.new("UICorner")
	TopCorner.CornerRadius = UDim.new(0, 8)
	TopCorner.Parent = TopMain

	-- Đường kẻ cyan bên dưới topbar
	local TopStroke = Instance.new("Frame", TopMain)
	TopStroke.Name = "TopStroke"
	TopStroke.BackgroundColor3 = Color3.fromRGB(0, 210, 230)
	TopStroke.BackgroundTransparency = 0.2
	TopStroke.BorderSizePixel = 0
	TopStroke.Position = UDim2.new(0, 0, 1, -1)
	TopStroke.Size = UDim2.new(1, 0, 0, 1)

	-- Gradient đường kẻ dưới topbar
	local topStrokeGrad = Instance.new("UIGradient")
	topStrokeGrad.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.15, 0),
		NumberSequenceKeypoint.new(0.85, 0),
		NumberSequenceKeypoint.new(1, 1)
	}
	topStrokeGrad.Parent = TopStroke

	-- Logo
	Ruafimg.Name = "Ruafimg"
	Ruafimg.Parent = TopMain
	Ruafimg.BackgroundTransparency = 1
	Ruafimg.Position = UDim2.new(0, 6, 0, 4)
	Ruafimg.Size = UDim2.new(0, 24, 0, 24)
	Ruafimg.Image = getgenv().UIColor["Logo Image"]
	Ruafimg.ImageColor3 = Color3.fromRGB(0, 210, 230)

	-- Tiêu đề
	TextLabelMain.Name = "TextLabelMain"
	TextLabelMain.Parent = TopMain
	TextLabelMain.BackgroundTransparency = 1
	TextLabelMain.Position = UDim2.new(0, 36, 0, 0)
	TextLabelMain.Size = UDim2.new(0.5, 0, 1, 0)
	TextLabelMain.Font = Enum.Font.GothamBold
	TextLabelMain.RichText = true
	TextLabelMain.TextSize = 14
	TextLabelMain.TextWrapped = true
	TextLabelMain.TextXAlignment = Enum.TextXAlignment.Left
	TextLabelMain.Text = "<font color=\"rgb(0,210,230)\">" .. tostring(TitleNameMain or "HDANH HUB") .. "</font> <font color=\"rgb(255,210,80)\">" .. tostring(getgenv().MainDesc or "") .. "</font>"

	-- Corner indicators (decorative, cyberpunk style)
	local function makeCornerDeco(parent, anchorX, anchorY, posX, posY)
		local deco = Instance.new("Frame")
		deco.Parent = parent
		deco.Size = UDim2.new(0, 8, 0, 8)
		deco.BackgroundColor3 = Color3.fromRGB(0, 210, 230)
		deco.BackgroundTransparency = 0.3
		deco.BorderSizePixel = 0
		deco.AnchorPoint = Vector2.new(anchorX, anchorY)
		deco.Position = UDim2.new(posX, 0, posY, 0)
		deco.ZIndex = 5
		local dc = Instance.new("UICorner")
		dc.CornerRadius = UDim.new(0, 2)
		dc.Parent = deco
	end
	makeCornerDeco(MainContainer, 0, 0, 0, 0)
	makeCornerDeco(MainContainer, 1, 0, 1, 0)
	makeCornerDeco(MainContainer, 0, 1, 0, 1)
	makeCornerDeco(MainContainer, 1, 1, 1, 1)

	-- ============================================================
	-- SIDEBAR (Tab list) - Cyberpunk Dark
	-- ============================================================
	PageControl.Name = "Background1"
	PageControl.Parent = Concacmain
	PageControl.Position = UDim2.new(0, 5, 0, 5)
	PageControl.Size = UDim2.new(0, 175, 0, 320)
	PageControl.BackgroundColor3 = Color3.fromRGB(8, 10, 14)
	PageControl.BackgroundTransparency = 0

	local pageControlStroke = Instance.new("UIStroke", PageControl)
	pageControlStroke.Color = Color3.fromRGB(0, 210, 230)
	pageControlStroke.Thickness = 1
	pageControlStroke.Transparency = 0.5

	local pageControlCorner = Instance.new("UICorner", PageControl)
	pageControlCorner.CornerRadius = UDim.new(0, 6)

	-- Header sidebar
	ControlTitle.Name = "GUITextColor"
	ControlTitle.Parent = PageControl
	ControlTitle.BackgroundTransparency = 1
	ControlTitle.Position = UDim2.new(0, 10, 0, 5)
	ControlTitle.Size = UDim2.new(1, -10, 0, 22)
	ControlTitle.Font = Enum.Font.GothamBold
	ControlTitle.Text = "◈ MENU"
	ControlTitle.TextSize = 12
	ControlTitle.TextXAlignment = Enum.TextXAlignment.Left
	ControlTitle.TextColor3 = Color3.fromRGB(0, 210, 230)

	-- Đường kẻ dưới header sidebar
	local sideHeaderLine = Instance.new("Frame", PageControl)
	sideHeaderLine.Size = UDim2.new(1, -16, 0, 1)
	sideHeaderLine.Position = UDim2.new(0, 8, 0, 27)
	sideHeaderLine.BackgroundColor3 = Color3.fromRGB(0, 210, 230)
	sideHeaderLine.BackgroundTransparency = 0.6
	sideHeaderLine.BorderSizePixel = 0
	local sideHeaderLineGrad = Instance.new("UIGradient")
	sideHeaderLineGrad.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.2, 0),
		NumberSequenceKeypoint.new(0.8, 0),
		NumberSequenceKeypoint.new(1, 1)
	}
	sideHeaderLineGrad.Parent = sideHeaderLine

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = PageControl

	-- Tab scroll list
	ControlList.Name = "ControlList"
	ControlList.Parent = PageControl
	ControlList.Active = true
	ControlList.BackgroundTransparency = 1
	ControlList.BorderSizePixel = 0
	ControlList.Position = UDim2.new(0, 0, 0, 32)
	ControlList.Size = UDim2.new(1, -4, 1, -32)
	ControlList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ControlList.CanvasSize = UDim2.new(0, 0, 0, 0)
	ControlList.ScrollBarThickness = 3
	ControlList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

	UIListLayout.Parent = ControlList
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 3)

	-- ============================================================
	-- GLOBAL SEARCH BAR (top of sidebar)
	-- ============================================================
	local PageSearch = Instance.new("Frame")
	local PageSearchCorner = Instance.new("UICorner")
	local SearchFrame = Instance.new("Frame")
	local SearchIcon = Instance.new("ImageLabel")
	local SearchBox = Instance.new("TextBox")

	PageSearch.Name = "PageSearch"
	PageSearch.Parent = PageControl
	PageSearch.AnchorPoint = Vector2.new(1, 0)
	PageSearch.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
	PageSearch.Position = UDim2.new(1, -5, 0, 5)
	PageSearch.Size = UDim2.new(0, 165, 0, 22)
	PageSearch.ClipsDescendants = true

	PageSearchCorner.Parent = PageSearch
	PageSearchCorner.CornerRadius = UDim.new(0, 4)

	local searchStroke = Instance.new("UIStroke", PageSearch)
	searchStroke.Color = Color3.fromRGB(0, 210, 230)
	searchStroke.Thickness = 1
	searchStroke.Transparency = 0.6

	SearchFrame.Name = "SearchFrame"
	SearchFrame.Parent = PageSearch
	SearchFrame.BackgroundTransparency = 1
	SearchFrame.Size = UDim2.new(0, 22, 1, 0)

	SearchIcon.Name = "SearchIcon"
	SearchIcon.Parent = SearchFrame
	SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	SearchIcon.BackgroundTransparency = 1
	SearchIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	SearchIcon.Size = UDim2.new(0, 14, 0, 14)
	SearchIcon.Image = "rbxassetid://8154282545"
	SearchIcon.ImageColor3 = Color3.fromRGB(0, 210, 230)

	SearchBox.Name = "SearchBox"
	SearchBox.Parent = PageSearch
	SearchBox.Active = true
	SearchBox.BackgroundTransparency = 1
	SearchBox.CursorPosition = -1
	SearchBox.Position = UDim2.new(0, 26, 0, 0)
	SearchBox.Size = UDim2.new(1, -28, 1, 0)
	SearchBox.Font = Enum.Font.GothamBold
	SearchBox.PlaceholderColor3 = Color3.fromRGB(60, 90, 100)
	SearchBox.PlaceholderText = "Search..."
	SearchBox.Text = ""
	SearchBox.TextColor3 = Color3.fromRGB(220, 230, 240)
	SearchBox.TextSize = 12
	SearchBox.TextXAlignment = Enum.TextXAlignment.Left

	-- Main page area
	MainPage.Name = "MainPage"
	MainPage.Parent = Concacmain
	MainPage.BackgroundTransparency = 1
	MainPage.ClipsDescendants = true
	MainPage.Position = UDim2.new(0, 185, 0, 0)
	MainPage.Size = UDim2.new(0, 445, 0, 330)

	UIPage.Name = "UIPage"
	UIPage.Parent = MainPage
	UIPage.FillDirection = Enum.FillDirection.Vertical
	UIPage.SortOrder = Enum.SortOrder.LayoutOrder
	UIPage.EasingDirection = Enum.EasingDirection.InOut
	UIPage.EasingStyle = Enum.EasingStyle.Quart
	UIPage.Padding = UDim.new(0, 10)
	UIPage.TweenTime = getgenv().UIColor["Tween Animation 1 Speed"]

	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ControlList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
	end)

	-- Shadow
	local Shadow = Instance.new("ImageLabel", Main)
	Shadow.Name = "Shadow"
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundTransparency = 1
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Size = UDim2.new(1, 50, 1, 50)
	Shadow.ZIndex = 0
	Shadow.Image = "rbxassetid://5028857084"
	Shadow.ImageColor3 = Color3.fromRGB(0, 150, 180)
	Shadow.ImageTransparency = 0.6
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(24, 24, 276, 276)

	-- Global search logic
	local sectionInfo = {}
	if not GlobalSearch then
		GlobalSearch = function(searchText)
			searchText = string.lower(searchText)
			if searchText == "" then
				for _, control in pairs(getgenv().AllControls) do
					control.TabButton.Visible = true
					control.Section.Visible = true
					control.Element.Visible = true
				end
				for _, tab in pairs(ControlList:GetChildren()) do
					if not tab:IsA('UIListLayout') then tab.Visible = true end
				end
				return
			end
			for _, control in pairs(getgenv().AllControls) do
				control.Section.Visible = false
				control.Element.Visible = false
			end
			for _, tab in pairs(ControlList:GetChildren()) do
				if not tab:IsA('UIListLayout') then tab.Visible = false end
			end
			local sectionsWithElements = {}
			local elementsInSection = {}
			for _, control in pairs(getgenv().AllControls) do
				local elementName = string.lower(control.Name or "")
				local sectionName = string.lower(control.SectionName or "")
				local elementFound = string.find(elementName, searchText, 1, true) ~= nil
				local sectionFound = string.find(sectionName, searchText, 1, true) ~= nil
				if not elementsInSection[control.Section] then elementsInSection[control.Section] = {} end
				table.insert(elementsInSection[control.Section], { control = control, elementFound = elementFound, sectionFound = sectionFound })
				if elementFound then sectionsWithElements[control.Section] = true end
			end
			local foundTabs = {}
			for section, elements in pairs(elementsInSection) do
				local hasElementMatch = false
				for _, elementInfo in ipairs(elements) do
					if elementInfo.elementFound then hasElementMatch = true end
				end
				for _, elementInfo in ipairs(elements) do
					local control = elementInfo.control
					if elementInfo.elementFound then
						control.Element.Visible = true
						if elementInfo.sectionFound or hasElementMatch then control.Section.Visible = true end
						foundTabs[control.TabName] = true
						control.TabButton.Visible = true
					elseif elementInfo.sectionFound and not hasElementMatch then
						control.Section.Visible = true
						control.Element.Visible = false
						foundTabs[control.TabName] = true
						control.TabButton.Visible = true
					end
				end
			end
			for tabName, _ in pairs(foundTabs) do
				for _, tab in pairs(ControlList:GetChildren()) do
					if not tab:IsA('UIListLayout') and string.find(tab.Name, tabName, 1, true) then
						tab.Visible = true
					end
				end
			end
		end
	end

	SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		GlobalSearch(SearchBox.Text)
	end)

	local Main_Function = {}
	local LayoutOrderBut = -1
	local LayoutOrder = -1
	local PageCounter = 1

	-- ============================================================
	-- ADD TAB - Cyberpunk Dark
	-- ============================================================
	function Main_Function:AddTab(PageName, IconId)
		local Page_Name = tostring(PageName)
		local Page_Title = Page_Name

		LayoutOrder = LayoutOrder + 1
		LayoutOrderBut = LayoutOrderBut + 1

		local PageNameControl = Instance.new("Frame")
		local Frame = Instance.new("Frame")
		local TabNameCorner = Instance.new("UICorner")
		local Line = Instance.new("Frame")
		local InLine = Instance.new("Frame")
		local LineCorner = Instance.new("UICorner")
		local TabTitleContainer = Instance.new("Frame")
		local TabTitle = Instance.new("TextLabel")
		local PageButton = Instance.new("TextButton")

		-- Tab icon
		local TabIcon = Instance.new("ImageLabel")
		TabIcon.Name = "TabIcon"
		TabIcon.Parent = Frame
		TabIcon.BackgroundTransparency = 1
		TabIcon.Position = UDim2.new(0, 8, 0.5, 0)
		TabIcon.AnchorPoint = Vector2.new(0, 0.5)
		TabIcon.Size = UDim2.new(0, 16, 0, 16)
		TabIcon.Image = IconId or ""
		TabIcon.ImageColor3 = Color3.fromRGB(0, 210, 230)
		TabIcon.ScaleType = Enum.ScaleType.Fit

		PageNameControl.Name = Page_Name .. "_Control"
		PageNameControl.Parent = ControlList
		PageNameControl.BackgroundTransparency = 1
		PageNameControl.LayoutOrder = LayoutOrderBut
		PageNameControl.Size = UDim2.new(1, -4, 0, 32)

		-- Tab button frame
		Frame.Name = "Frame"
		Frame.Parent = PageNameControl
		Frame.BackgroundColor3 = Color3.fromRGB(12, 16, 22)
		Frame.BackgroundTransparency = 0.2
		Frame.Size = UDim2.new(1, 0, 1, 0)

		TabNameCorner.CornerRadius = UDim.new(0, 5)
		TabNameCorner.Parent = Frame

		local frameStroke = Instance.new("UIStroke", Frame)
		frameStroke.Color = Color3.fromRGB(0, 210, 230)
		frameStroke.Thickness = 1
		frameStroke.Transparency = 0.8

		-- Active indicator (left bar)
		Line.Name = "Line"
		Line.Parent = Frame
		Line.BackgroundTransparency = 1
		Line.Size = UDim2.new(1, 0, 1, 0)

		InLine.Name = "PageInLine"
		InLine.Parent = Line
		InLine.BackgroundColor3 = Color3.fromRGB(0, 210, 230)
		InLine.BackgroundTransparency = 1
		InLine.BorderSizePixel = 0
		InLine.Size = UDim2.new(0, 3, 0.7, 0)
		InLine.Position = UDim2.new(0, 0, 0.15, 0)

		LineCorner.CornerRadius = UDim.new(0, 2)
		LineCorner.Parent = InLine

		TabTitleContainer.Name = "TabTitleContainer"
		TabTitleContainer.Parent = Frame
		TabTitleContainer.BackgroundTransparency = 1
		TabTitleContainer.Position = UDim2.new(0, (IconId and IconId ~= "") and 28 or 10, 0, 0)
		TabTitleContainer.Size = UDim2.new(1, -((IconId and IconId ~= "") and 30 or 12), 1, 0)

		TabTitle.Name = "TabTitle"
		TabTitle.Parent = TabTitleContainer
		TabTitle.BackgroundTransparency = 1
		TabTitle.Size = UDim2.new(1, 0, 1, 0)
		TabTitle.Font = Enum.Font.GothamBold
		TabTitle.Text = Page_Name
		TabTitle.TextSize = 13
		TabTitle.TextXAlignment = Enum.TextXAlignment.Left
		TabTitle.TextColor3 = Color3.fromRGB(120, 150, 165)

		PageButton.Name = "PageButton"
		PageButton.Parent = Frame
		PageButton.BackgroundTransparency = 1
		PageButton.Size = UDim2.new(1, 0, 1, 0)
		PageButton.Font = Enum.Font.SourceSans
		PageButton.Text = ""

		-- Page container (right side)
		local PageContainer = Instance.new("ScrollingFrame")
		PageContainer.Name = Page_Name
		PageContainer.Parent = MainPage
		PageContainer.Active = true
		PageContainer.BackgroundTransparency = 1
		PageContainer.BorderSizePixel = 0
		PageContainer.Size = UDim2.new(1, 0, 1, 0)
		PageContainer.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
		PageContainer.ScrollBarThickness = 3
		PageContainer.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageContainer.Visible = LayoutOrderBut == 0

		local PageList = Instance.new("Frame")
		PageList.Name = "PageList"
		PageList.Parent = PageContainer
		PageList.BackgroundTransparency = 1
		PageList.Size = UDim2.new(1, 0, 1, 0)
		PageList.AutomaticSize = Enum.AutomaticSize.Y

		local PageListLayout = Instance.new("UIListLayout")
		PageListLayout.Parent = PageList
		PageListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageListLayout.Padding = UDim.new(0, 5)

		local PagePadding = Instance.new("UIPadding")
		PagePadding.Parent = PageList
		PagePadding.PaddingTop = UDim.new(0, 5)
		PagePadding.PaddingLeft = UDim.new(0, 5)
		PagePadding.PaddingRight = UDim.new(0, 5)
		PagePadding.PaddingBottom = UDim.new(0, 5)

		PageListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			PageContainer.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y + 10)
		end)

		-- Tab search (per-page)
		local PageSearch2 = Instance.new("Frame")
		local SearchFrame2 = Instance.new("Frame")
		local SearchIcon2 = Instance.new("ImageLabel")
		local SearchButton2 = Instance.new("TextButton")
		local SearchBox2 = Instance.new("TextBox")

		PageSearch2.Name = "PageSearch"
		PageSearch2.Parent = Frame
		PageSearch2.AnchorPoint = Vector2.new(1, 0.5)
		PageSearch2.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
		PageSearch2.Position = UDim2.new(1, -5, 0.5, 0)
		PageSearch2.Size = UDim2.new(0, 20, 0, 20)
		PageSearch2.ClipsDescendants = true

		local ps2corner = Instance.new("UICorner")
		ps2corner.CornerRadius = UDim.new(0, 4)
		ps2corner.Parent = PageSearch2

		local ps2stroke = Instance.new("UIStroke", PageSearch2)
		ps2stroke.Color = Color3.fromRGB(0, 210, 230)
		ps2stroke.Thickness = 1
		ps2stroke.Transparency = 0.6

		SearchFrame2.Name = "SearchFrame"
		SearchFrame2.Parent = PageSearch2
		SearchFrame2.BackgroundTransparency = 1
		SearchFrame2.Size = UDim2.new(0, 20, 1, 0)

		SearchIcon2.Name = "SearchIcon"
		SearchIcon2.Parent = SearchFrame2
		SearchIcon2.AnchorPoint = Vector2.new(0.5, 0.5)
		SearchIcon2.BackgroundTransparency = 1
		SearchIcon2.Position = UDim2.new(0.5, 0, 0.5, 0)
		SearchIcon2.Size = UDim2.new(0, 14, 0, 14)
		SearchIcon2.Image = "rbxassetid://8154282545"
		SearchIcon2.ImageColor3 = getgenv().UIColor["Search Icon Color"]

		SearchButton2.Name = "Search Button"
		SearchButton2.Parent = SearchFrame2
		SearchButton2.BackgroundTransparency = 1
		SearchButton2.Size = UDim2.new(1, 0, 1, 0)
		SearchButton2.Font = Enum.Font.SourceSans
		SearchButton2.Text = ""
		SearchButton2.TextColor3 = Color3.fromRGB(220, 230, 240)
		SearchButton2.TextSize = 14

		SearchBox2.Name = "Search Box"
		SearchBox2.Parent = PageSearch2
		SearchBox2.BackgroundTransparency = 1
		SearchBox2.Position = UDim2.new(0, 24, 0, 0)
		SearchBox2.Size = UDim2.new(1, -26, 1, 0)
		SearchBox2.Font = Enum.Font.GothamBold
		SearchBox2.Text = ""
		SearchBox2.TextSize = 12
		SearchBox2.TextXAlignment = Enum.TextXAlignment.Left
		SearchBox2.PlaceholderText = "Search..."
		SearchBox2.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
		SearchBox2.TextColor3 = getgenv().UIColor["Text Color"]

		local Openned = false
		SearchButton2.MouseEnter:Connect(function()
			TweenService:Create(SearchIcon2, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), {
				ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
			}):Play()
		end)
		SearchButton2.MouseLeave:Connect(function()
			TweenService:Create(SearchIcon2, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), {
				ImageColor3 = getgenv().UIColor["Search Icon Color"]
			}):Play()
		end)
		SearchButton2.MouseButton1Click:Connect(function()
			Openned = not Openned
			local size = Openned and UDim2.new(0, 165, 0, 20) or UDim2.new(0, 20, 0, 20)
			TweenService:Create(PageSearch2, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Size = size }):Play()
		end)

		local function hideOtherFrame()
			for i, v in next, PageList:GetChildren() do
				if not v:IsA('UIListLayout') and not v:IsA('UIPadding') then v.Visible = false end
			end
		end
		local function showFrameName()
			for i, v in pairs(PageList:GetChildren()) do
				if not v:IsA('UIListLayout') and not v:IsA('UIPadding') then
					if string.find(string.lower(v.Name), string.lower(SearchBox2.Text)) then
						v.Visible = true
					end
				end
			end
		end
		SearchBox2:GetPropertyChangedSignal("Text"):Connect(function()
			hideOtherFrame()
			showFrameName()
		end)

		-- Highlight first tab
		for i, v in pairs(ControlList:GetChildren()) do
			if not (v:IsA('UIListLayout')) then
				if i == 2 then
					v.Frame.Line.PageInLine.BackgroundTransparency = 0
				end
			end
		end

		-- Tab click handler
		PageButton.MouseButton1Click:Connect(function()
			if tostring(UIPage.CurrentPage) == PageContainer.Name then return end

			for i, v in pairs(MainPage:GetChildren()) do
				if not (v:IsA('UIPageLayout')) and not (v:IsA('UICorner')) then
					v.Visible = false
				end
			end
			PageContainer.Visible = true
			UIPage:JumpTo(PageContainer)

			for i, v in next, ControlList:GetChildren() do
				if not (v:IsA('UIListLayout')) then
					if v.Name == Page_Name .. "_Control" then
						TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 0
						}):Play()
						TweenService:Create(v.Frame, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundColor3 = Color3.fromRGB(0, 40, 55)
						}):Play()
						TweenService:Create(v.Frame.TabTitleContainer.TabTitle, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							TextColor3 = Color3.fromRGB(0, 210, 230)
						}):Play()
					else
						TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 1
						}):Play()
						TweenService:Create(v.Frame, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundColor3 = Color3.fromRGB(12, 16, 22)
						}):Play()
						TweenService:Create(v.Frame.TabTitleContainer.TabTitle, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							TextColor3 = Color3.fromRGB(120, 150, 165)
						}):Play()
					end
				end
			end
		end)

		-- ============================================================
		-- ADD SECTION - Cyberpunk Dark
		-- ============================================================
		local pageFunction = {}
		function pageFunction:AddSection(Section_Name, Toggleable, SectionGap, SectionColor)
			local Toggleable = Toggleable or false
			local Section = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Topsec = Instance.new("Frame")
			local Sectiontitle = Instance.new("TextLabel")
			local Linesec = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local SectionList = Instance.new("UIListLayout")

			Section.Name = Section_Name .. "_Dot"
			Section.Parent = PageList
			Section.Size = UDim2.new(1, -5, 0, 30)
			Section.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
			Section.BackgroundTransparency = 0.1
			Section.ClipsDescendants = true

			local sectionStroke = Instance.new("UIStroke", Section)
			sectionStroke.Color = Color3.fromRGB(0, 210, 230)
			sectionStroke.Thickness = 1
			sectionStroke.Transparency = 0.6

			-- Left accent bar section
			local sectionAccent = Instance.new("Frame", Section)
			sectionAccent.Size = UDim2.new(0, 2, 1, 0)
			sectionAccent.BackgroundColor3 = Color3.fromRGB(0, 210, 230)
			sectionAccent.BackgroundTransparency = 0.3
			sectionAccent.BorderSizePixel = 0
			local sectionAccentCorner = Instance.new("UICorner")
			sectionAccentCorner.CornerRadius = UDim.new(0, 2)
			sectionAccentCorner.Parent = sectionAccent

			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = Section

			Topsec.Name = "Topsec"
			Topsec.Parent = Section
			Topsec.BackgroundTransparency = 1
			Topsec.Size = UDim2.new(1, 0, 0, 28)

			Sectiontitle.Name = "Sectiontitle"
			Sectiontitle.Parent = Topsec
			Sectiontitle.BackgroundTransparency = 1
			Sectiontitle.Position = UDim2.new(0, 10, 0, 0)
			Sectiontitle.Size = UDim2.new(1, -10, 1, 0)
			Sectiontitle.Font = Enum.Font.GothamBold
			Sectiontitle.Text = Section_Name
			Sectiontitle.TextSize = 12
			Sectiontitle.TextColor3 = Color3.fromRGB(0, 210, 230)
			Sectiontitle.TextXAlignment = Enum.TextXAlignment.Left

			Linesec.Name = "Linesec"
			Linesec.Parent = Topsec
			Linesec.AnchorPoint = Vector2.new(0.5, 1)
			Linesec.BorderSizePixel = 0
			Linesec.Position = UDim2.new(0.5, 0, 1, -1)
			Linesec.Size = UDim2.new(1, -12, 0, 1)
			Linesec.BackgroundColor3 = Color3.fromRGB(0, 180, 200)

			UIGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.2, 0),
				NumberSequenceKeypoint.new(0.8, 0),
				NumberSequenceKeypoint.new(1, 1)
			}
			UIGradient.Parent = Linesec

			SectionList.Name = "SectionList"
			SectionList.Parent = Section
			SectionList.SortOrder = Enum.SortOrder.LayoutOrder
			SectionList.Padding = UDim.new(0, 4)

			local SizeSectionY
			local sectionIsVisible = false
			if Toggleable then
				local VisibilitySectionFrame = Instance.new("Frame")
				local VisibilitySectionFrameCorner = Instance.new("UICorner")
				local visibility = Instance.new("ImageButton")
				local visibility_off = Instance.new("ImageButton")
				local VisibilityButton = Instance.new("TextButton")

				VisibilityButton.Name = "VisibilityButton"
				VisibilityButton.Parent = Topsec
				VisibilityButton.AnchorPoint = Vector2.new(1, 0.5)
				VisibilityButton.BackgroundTransparency = 1
				VisibilityButton.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilityButton.Size = UDim2.new(0, 20, 0, 20)
				VisibilityButton.Font = Enum.Font.SourceSans
				VisibilityButton.Text = ""
				VisibilityButton.ZIndex = 2

				VisibilitySectionFrame.Name = "VisibilitySectionFrame"
				VisibilitySectionFrame.Parent = Topsec
				VisibilitySectionFrame.AnchorPoint = Vector2.new(1, 0.5)
				VisibilitySectionFrame.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
				VisibilitySectionFrame.BorderSizePixel = 0
				VisibilitySectionFrame.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilitySectionFrame.Size = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrameCorner.CornerRadius = UDim.new(0, 4)
				VisibilitySectionFrameCorner.Parent = VisibilitySectionFrame

				visibility.Name = "visibility"
				visibility.Parent = VisibilitySectionFrame
				visibility.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility.BackgroundTransparency = 1
				visibility.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility.Size = UDim2.new(1, -4, 1, -4)
				visibility.ZIndex = 2
				visibility.Image = "rbxassetid://3926307971"
				visibility.ImageRectOffset = Vector2.new(84, 44)
				visibility.ImageRectSize = Vector2.new(36, 36)
				visibility.ImageTransparency = 1
				visibility.ImageColor3 = Color3.fromRGB(0, 210, 230)

				visibility_off.Name = "visibility_off"
				visibility_off.Parent = VisibilitySectionFrame
				visibility_off.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility_off.BackgroundTransparency = 1
				visibility_off.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility_off.Size = UDim2.new(1, -4, 1, -4)
				visibility_off.ZIndex = 2
				visibility_off.Image = "rbxassetid://3926307971"
				visibility_off.ImageRectOffset = Vector2.new(564, 44)
				visibility_off.ImageRectSize = Vector2.new(36, 36)
				visibility_off.ImageTransparency = 0
				visibility_off.ImageColor3 = Color3.fromRGB(0, 210, 230)

				VisibilityButton.MouseButton1Down:Connect(function()
					sectionIsVisible = not sectionIsVisible
					TweenService:Create(visibility, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 0 or 1
					}):Play()
					wait(getgenv().UIColor["Tween Animation 1 Speed"] / 4)
					TweenService:Create(visibility_off, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 1 or 0
					}):Play()
					TweenService:Create(Section, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size = UDim2.new(1, -5, 0, (sectionIsVisible and SizeSectionY or 28))
					}):Play()
				end)
			end

			SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if not Toggleable then
					Section.Size = UDim2.new(1, -5, 0, SectionList.AbsoluteContentSize.Y + 5)
				end
				SizeSectionY = SectionList.AbsoluteContentSize.Y + 5
				if sectionIsVisible then
					TweenService:Create(Section, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size = UDim2.new(1, -5, 0, SizeSectionY)
					}):Play()
				end
			end)

			local sectionFunction = {}

			-- ============================================================
			-- ADD TOGGLE - Cyberpunk style
			-- ============================================================
			function sectionFunction:AddToggle(idk, Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local Desc = Setting.Desc or Setting.Description
				local Default = Setting.Default
				if Default == nil then Default = false end
				local Callback = Setting.Callback
				local ToggleFrame = Instance.new("Frame")
				local TogFrame1 = Instance.new("Frame")
				local checkbox = Instance.new("ImageLabel")
				local check = Instance.new("Frame")
				local ToggleDesc = Instance.new("TextLabel")
				local ToggleTitle = Instance.new("TextLabel")
				local ToggleBg = Instance.new("Frame")
				local ToggleCorner = Instance.new("UICorner")
				local ToggleButton = Instance.new("TextButton")
				local ToggleList = Instance.new("UIListLayout")

				ToggleFrame.Name = "ToggleFrame"
				ToggleFrame.Parent = Section
				ToggleFrame.BackgroundTransparency = 1
				if Desc and Desc ~= "" then
					ToggleFrame.AutomaticSize = Enum.AutomaticSize.Y
					ToggleFrame.Size = UDim2.new(1, 0, 0, 0)
				else
					ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
				end

				TogFrame1.Name = "TogFrame1"
				TogFrame1.Parent = ToggleFrame
				TogFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
				TogFrame1.BackgroundTransparency = 1
				TogFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
				TogFrame1.Size = UDim2.new(1, -8, 1, 0)

				checkbox.Name = "checkbox"
				checkbox.Parent = TogFrame1
				checkbox.AnchorPoint = Vector2.new(1, 0.5)
				checkbox.BackgroundTransparency = 1
				checkbox.Position = UDim2.new(1, -6, 0.5, 0)
				checkbox.Size = UDim2.new(0, 20, 0, 20)
				checkbox.Image = "rbxassetid://4552505888"
				checkbox.ImageColor3 = Color3.fromRGB(30, 60, 80)

				check.Name = "check"
				check.Parent = checkbox
				check.AnchorPoint = Vector2.new(0.5, 0.5)
				check.BackgroundColor3 = Color3.fromRGB(0, 210, 230)
				check.Position = UDim2.new(0.5, 0, 0.5, 0)
				local checkGradient = Instance.new("UIGradient")
				checkGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 240)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 200)),
				})
				checkGradient.Rotation = 135
				checkGradient.Parent = check
				local checkCorner = Instance.new("UICorner")
				checkCorner.CornerRadius = UDim.new(1, 0)
				checkCorner.Parent = check

				if Desc and Desc ~= "" then
					ToggleDesc.Name = "ToggleDesc"
					ToggleDesc.Parent = TogFrame1
					ToggleDesc.BackgroundTransparency = 1
					ToggleDesc.Position = UDim2.new(0, 10, 0, 25)
					ToggleDesc.Size = UDim2.new(1, -50, 0, 0)
					ToggleDesc.Font = Enum.Font.Gotham
					ToggleDesc.Text = Desc
					ToggleDesc.TextSize = 12
					ToggleDesc.TextWrapped = true
					ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
					ToggleDesc.RichText = true
					ToggleDesc.AutomaticSize = Enum.AutomaticSize.Y
					ToggleDesc.TextColor3 = Color3.fromRGB(100, 140, 155)
					local pad = Instance.new("UIPadding", TogFrame1)
					pad.PaddingTop = UDim.new(0, 5)
					pad.PaddingBottom = UDim.new(0, 5)
				end

				ToggleTitle.Name = "TextColor"
				ToggleTitle.Parent = TogFrame1
				ToggleTitle.BackgroundTransparency = 1
				if Desc and Desc ~= "" then
					ToggleTitle.Position = UDim2.new(0, 10, 0, 5)
					ToggleTitle.Size = UDim2.new(1, -50, 0, 20)
				else
					ToggleTitle.Position = UDim2.new(0, 10, 0, 0)
					ToggleTitle.Size = UDim2.new(1, -50, 1, 0)
				end
				ToggleTitle.Font = Enum.Font.GothamBold
				ToggleTitle.Text = Title
				ToggleTitle.TextSize = 13
				ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
				ToggleTitle.TextYAlignment = Enum.TextYAlignment.Center
				ToggleTitle.RichText = true
				ToggleTitle.TextColor3 = Color3.fromRGB(200, 215, 225)

				ToggleBg.Name = "Background1"
				ToggleBg.Parent = TogFrame1
				ToggleBg.Size = UDim2.new(1, 0, 1, 0)
				ToggleBg.ZIndex = 0
				ToggleBg.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
				ToggleBg.BackgroundTransparency = 0.2

				ToggleCorner.CornerRadius = UDim.new(0, 6)
				ToggleCorner.Parent = ToggleBg

				ToggleButton.Name = "ToggleButton"
				ToggleButton.Parent = TogFrame1
				ToggleButton.BackgroundTransparency = 1
				ToggleButton.Size = UDim2.new(1, 0, 1, 0)
				ToggleButton.Position = UDim2.new(0, 0, 0, 0)
				ToggleButton.Font = Enum.Font.SourceSans
				ToggleButton.Text = ""

				ToggleList.Name = "ToggleList"
				ToggleList.Parent = ToggleFrame
				ToggleList.HorizontalAlignment = Enum.HorizontalAlignment.Center
				ToggleList.SortOrder = Enum.SortOrder.LayoutOrder
				ToggleList.VerticalAlignment = Enum.VerticalAlignment.Center
				ToggleList.Padding = UDim.new(0, 4)

				local function ChangeStage(val)
					local csize = val and UDim2.new(0.6, 0, 0.6, 0) or UDim2.new(0, 0, 0, 0)
					TweenService:Create(check, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size = csize, Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5)
					}):Play()
					TweenService:Create(checkbox, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						ImageColor3 = val and Color3.fromRGB(0, 210, 230) or Color3.fromRGB(30, 60, 80)
					}):Play()
				end

				ChangeStage(Default)
				if Default and Callback then Callback(Default) end

				local function ButtonClick()
					Default = not Default
					ChangeStage(Default)
					if Callback then pcall(Callback, Default) end
				end

				ToggleButton.MouseButton1Click:Connect(function() ButtonClick() end)
				ToggleButton.MouseEnter:Connect(function()
					TweenService:Create(ToggleBg, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(0, 30, 42) }):Play()
				end)
				ToggleButton.MouseLeave:Connect(function()
					TweenService:Create(ToggleBg, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(14, 18, 26) }):Play()
				end)

				local toggleFunction = {}
				function toggleFunction.SetStage(value)
					if value ~= Default then ButtonClick() end
				end

				local controlData = {
					Name = Title, Section = Section, Element = ToggleFrame,
					SectionName = Section_Name, TabName = Page_Name, TabButton = PageNameControl
				}
				table.insert(getgenv().AllControls, controlData)
				return toggleFunction
			end

			-- ============================================================
			-- ADD BUTTON - Cyberpunk style
			-- ============================================================
			function sectionFunction:AddButton(Setting, Callback)
				local Title = Setting.Title or Setting.Text or ""
				local Desc = Setting.Desc or Setting.Description
				local Callback = Setting.Callback or Setting.Func or function() end

				local Button = Instance.new("Frame")
				local RowBG_1 = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local RowHover_1 = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local TextColor_1 = Instance.new("TextLabel")
				local ClickArea_1 = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local Button_1 = Instance.new("TextButton")

				Button.Name = "Button"
				Button.Parent = Section
				Button.BackgroundTransparency = 1
				if Desc and Desc ~= "" then
					Button.AutomaticSize = Enum.AutomaticSize.Y
					Button.Size = UDim2.new(1, 0, 0, 0)
				else
					Button.Size = UDim2.new(1, 0, 0, 32)
				end

				RowBG_1.Name = "RowBG"
				RowBG_1.Parent = Button
				RowBG_1.AnchorPoint = Vector2.new(0.5, 0.5)
				RowBG_1.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
				RowBG_1.BackgroundTransparency = 0.1
				RowBG_1.Position = UDim2.new(0.5, 0, 0.5, 0)
				RowBG_1.Size = UDim2.new(1, -8, 1, 0)

				UICorner_1.Parent = RowBG_1
				UICorner_1.CornerRadius = UDim.new(0, 6)

				local btnStroke = Instance.new("UIStroke", RowBG_1)
				btnStroke.Color = Color3.fromRGB(0, 210, 230)
				btnStroke.Thickness = 1
				btnStroke.Transparency = 0.7

				RowHover_1.Name = "RowHover"
				RowHover_1.Parent = RowBG_1
				RowHover_1.BackgroundColor3 = Color3.fromRGB(0, 210, 230)
				RowHover_1.BackgroundTransparency = 1
				RowHover_1.Size = UDim2.new(1, 0, 1, 0)
				RowHover_1.ZIndex = 2

				UICorner_2.Parent = RowHover_1
				UICorner_2.CornerRadius = UDim.new(0, 6)

				TextColor_1.Name = "TextColor"
				TextColor_1.Parent = RowBG_1
				TextColor_1.BackgroundTransparency = 1
				if Desc and Desc ~= "" then
					TextColor_1.Position = UDim2.new(0, 12, 0, 5)
					TextColor_1.Size = UDim2.new(1, -24, 0, 20)
				else
					TextColor_1.Position = UDim2.new(0, 12, 0, 0)
					TextColor_1.Size = UDim2.new(1, -24, 1, 0)
				end
				TextColor_1.Font = Enum.Font.GothamBold
				TextColor_1.Text = Title
				TextColor_1.TextColor3 = Color3.fromRGB(220, 230, 240)
				TextColor_1.TextSize = 13
				TextColor_1.TextXAlignment = Enum.TextXAlignment.Left

				if Desc and Desc ~= "" then
					local TextDesc = Instance.new("TextLabel")
					TextDesc.Parent = RowBG_1
					TextDesc.BackgroundTransparency = 1
					TextDesc.Position = UDim2.new(0, 12, 0, 22)
					TextDesc.Size = UDim2.new(1, -24, 0, 0)
					TextDesc.AutomaticSize = Enum.AutomaticSize.Y
					TextDesc.Font = Enum.Font.Gotham
					TextDesc.Text = Desc
					TextDesc.TextColor3 = Color3.fromRGB(80, 120, 140)
					TextDesc.TextSize = 11
					TextDesc.TextWrapped = true
					TextDesc.TextXAlignment = Enum.TextXAlignment.Left
					TextDesc.RichText = true
				end

				-- Arrow indicator
				local arrowLabel = Instance.new("TextLabel")
				arrowLabel.Parent = RowBG_1
				arrowLabel.AnchorPoint = Vector2.new(1, 0.5)
				arrowLabel.Position = UDim2.new(1, -10, 0.5, 0)
				arrowLabel.Size = UDim2.new(0, 20, 0, 20)
				arrowLabel.BackgroundTransparency = 1
				arrowLabel.Font = Enum.Font.GothamBold
				arrowLabel.Text = "›"
				arrowLabel.TextColor3 = Color3.fromRGB(0, 210, 230)
				arrowLabel.TextSize = 16
				arrowLabel.ZIndex = 3

				Button_1.Name = "ClickButton"
				Button_1.Parent = RowBG_1
				Button_1.BackgroundTransparency = 1
				Button_1.Size = UDim2.new(1, 0, 1, 0)
				Button_1.ZIndex = 4
				Button_1.Font = Enum.Font.SourceSans
				Button_1.Text = ""

				Button_1.MouseEnter:Connect(function()
					TweenService:Create(RowHover_1, TweenInfo.new(0.15), { BackgroundTransparency = 0.88 }):Play()
					TweenService:Create(btnStroke, TweenInfo.new(0.15), { Transparency = 0.2 }):Play()
					TweenService:Create(TextColor_1, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(0, 210, 230) }):Play()
				end)
				Button_1.MouseLeave:Connect(function()
					TweenService:Create(RowHover_1, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
					TweenService:Create(btnStroke, TweenInfo.new(0.15), { Transparency = 0.7 }):Play()
					TweenService:Create(TextColor_1, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(220, 230, 240) }):Play()
				end)
				Button_1.MouseButton1Down:Connect(function()
					TweenService:Create(RowBG_1, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(0, 40, 55) }):Play()
				end)
				Button_1.MouseButton1Up:Connect(function()
					TweenService:Create(RowBG_1, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(14, 18, 26) }):Play()
				end)
				Button_1.MouseButton1Click:Connect(function()
					pcall(Callback)
				end)

				local controlData = {
					Name = Title, Section = Section, Element = Button,
					SectionName = Section_Name, TabName = Page_Name, TabButton = PageNameControl
				}
				table.insert(getgenv().AllControls, controlData)

				local buttonFunction = {}
				function buttonFunction:SetTitle(text) TextColor_1.Text = text end
				return buttonFunction
			end

			-- ============================================================
			-- ADD LABEL
			-- ============================================================
			function sectionFunction:AddLabel(text)
				local Title = text
				local LabelFrame = Instance.new("Frame")
				local LabelBG = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local TextColor = Instance.new("TextLabel")

				LabelFrame.Name = "LabelFrame"
				LabelFrame.Parent = Section
				LabelFrame.AutomaticSize = Enum.AutomaticSize.Y
				LabelFrame.BackgroundTransparency = 1
				LabelFrame.Size = UDim2.new(1, 0, 0, 0)

				LabelBG.Name = "LabelBG"
				LabelBG.Parent = LabelFrame
				LabelBG.AnchorPoint = Vector2.new(0.5, 0)
				LabelBG.AutomaticSize = Enum.AutomaticSize.Y
				LabelBG.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
				LabelBG.BackgroundTransparency = 0.2
				LabelBG.Position = UDim2.new(0.5, 0, 0, 0)
				LabelBG.Size = UDim2.new(1, -8, 0, 0)

				UICorner.Parent = LabelBG
				UICorner.CornerRadius = UDim.new(0, 6)

				local labelStroke = Instance.new("UIStroke", LabelBG)
				labelStroke.Color = Color3.fromRGB(0, 210, 230)
				labelStroke.Thickness = 1
				labelStroke.Transparency = 0.75

				TextColor.Name = "TextColor"
				TextColor.Parent = LabelBG
				TextColor.AutomaticSize = Enum.AutomaticSize.Y
				TextColor.BackgroundTransparency = 1
				TextColor.Position = UDim2.new(0, 10, 0, 6)
				TextColor.Size = UDim2.new(1, -20, 1, -12)
				TextColor.Font = Enum.Font.GothamMedium
				TextColor.Text = Title
				TextColor.TextColor3 = Color3.fromRGB(120, 170, 190)
				TextColor.TextSize = 12
				TextColor.TextWrapped = true
				TextColor.TextXAlignment = Enum.TextXAlignment.Left

				local labelFunction = {}
				function labelFunction:SetText(text) TextColor.Text = text end
				function labelFunction.SetColor(color) TextColor.TextColor3 = color end

				local controlData = {
					Name = Title, Section = Section, Element = LabelFrame,
					SectionName = Section_Name, TabName = Page_Name, TabButton = PageNameControl
				}
				table.insert(getgenv().AllControls, controlData)
				return labelFunction
			end

			-- ============================================================
			-- ADD TEXTBOX - Cyberpunk style
			-- ============================================================
			function sectionFunction:AddTextbox(idk, Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local Placeholder = Setting.Placeholder or Setting.Placeholdertext or ""
				local Default = Setting.Default or ""
				local Callback = Setting.Callback or function() end
				local callOnChanged = Setting.callOnChanged or false

				local TextboxFrame = Instance.new("Frame")
				local TextboxBG = Instance.new("Frame")
				local UICorner_T = Instance.new("UICorner")
				local TextboxTitle = Instance.new("TextLabel")
				local TextboxInput = Instance.new("TextBox")
				local InputCorner = Instance.new("UICorner")

				TextboxFrame.Name = Title
				TextboxFrame.Parent = Section
				TextboxFrame.BackgroundTransparency = 1
				TextboxFrame.Size = UDim2.new(1, 0, 0, 50)

				TextboxBG.Name = "Background1"
				TextboxBG.Parent = TextboxFrame
				TextboxBG.AnchorPoint = Vector2.new(0.5, 0.5)
				TextboxBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextboxBG.Size = UDim2.new(1, -8, 1, 0)
				TextboxBG.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
				TextboxBG.BackgroundTransparency = 0.1

				UICorner_T.CornerRadius = UDim.new(0, 6)
				UICorner_T.Parent = TextboxBG

				local tbStroke = Instance.new("UIStroke", TextboxBG)
				tbStroke.Color = Color3.fromRGB(0, 210, 230)
				tbStroke.Thickness = 1
				tbStroke.Transparency = 0.7

				TextboxTitle.Name = "TextColor"
				TextboxTitle.Parent = TextboxBG
				TextboxTitle.BackgroundTransparency = 1
				TextboxTitle.Position = UDim2.new(0, 10, 0, 0)
				TextboxTitle.Size = UDim2.new(1, -10, 0, 22)
				TextboxTitle.Font = Enum.Font.GothamBold
				TextboxTitle.Text = Title
				TextboxTitle.TextSize = 12
				TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left
				TextboxTitle.TextColor3 = Color3.fromRGB(0, 210, 230)

				local InputContainer = Instance.new("Frame")
				InputContainer.Parent = TextboxBG
				InputContainer.Position = UDim2.new(0, 8, 0, 24)
				InputContainer.Size = UDim2.new(1, -16, 0, 20)
				InputContainer.BackgroundColor3 = Color3.fromRGB(8, 12, 18)
				InputContainer.BackgroundTransparency = 0

				InputCorner.CornerRadius = UDim.new(0, 4)
				InputCorner.Parent = InputContainer

				local inputBorderStroke = Instance.new("UIStroke", InputContainer)
				inputBorderStroke.Color = Color3.fromRGB(0, 210, 230)
				inputBorderStroke.Thickness = 1
				inputBorderStroke.Transparency = 0.8

				TextboxInput.Name = "TextboxInput"
				TextboxInput.Parent = InputContainer
				TextboxInput.BackgroundTransparency = 1
				TextboxInput.Position = UDim2.new(0, 6, 0, 0)
				TextboxInput.Size = UDim2.new(1, -12, 1, 0)
				TextboxInput.Font = Enum.Font.GothamBold
				TextboxInput.PlaceholderText = Placeholder
				TextboxInput.PlaceholderColor3 = Color3.fromRGB(50, 80, 95)
				TextboxInput.Text = Default
				TextboxInput.TextColor3 = Color3.fromRGB(220, 230, 240)
				TextboxInput.TextSize = 12
				TextboxInput.TextXAlignment = Enum.TextXAlignment.Left
				TextboxInput.ClearTextOnFocus = false

				TextboxInput.Focused:Connect(function()
					TweenService:Create(inputBorderStroke, TweenInfo.new(0.2), { Transparency = 0.2, Color = Color3.fromRGB(0, 255, 220) }):Play()
					TweenService:Create(tbStroke, TweenInfo.new(0.2), { Transparency = 0.3 }):Play()
				end)
				TextboxInput.FocusLost:Connect(function(enterPressed)
					TweenService:Create(inputBorderStroke, TweenInfo.new(0.2), { Transparency = 0.8, Color = Color3.fromRGB(0, 210, 230) }):Play()
					TweenService:Create(tbStroke, TweenInfo.new(0.2), { Transparency = 0.7 }):Play()
					if enterPressed then pcall(Callback, TextboxInput.Text) end
				end)
				if callOnChanged then
					TextboxInput:GetPropertyChangedSignal("Text"):Connect(function()
						pcall(Callback, TextboxInput.Text)
					end)
				end

				local textboxFunction = {}
				function textboxFunction:SetValue(text) TextboxInput.Text = tostring(text) end
				function textboxFunction:GetValue() return TextboxInput.Text end

				local controlData = {
					Name = Title, Section = Section, Element = TextboxFrame,
					SectionName = Section_Name, TabName = Page_Name, TabButton = PageNameControl
				}
				table.insert(getgenv().AllControls, controlData)
				return textboxFunction
			end

			-- ============================================================
			-- ADD SLIDER - Cyberpunk style
			-- ============================================================
			function sectionFunction:AddSlider(idk, Setting)
				local TitleText = tostring(Setting.Text or Setting.Title) or ""
				local minValue = tonumber(Setting.Min) or 0
				local maxValue = tonumber(Setting.Max) or 100
				local Precise = Setting.Precise or false
				local DefaultValue = tonumber(Setting.Default) or 0
				local Callback = Setting.Callback
				local Rounding = Setting.Rouding or Setting.Rounding

				local SliderFrame = Instance.new("Frame")
				local SliderBG = Instance.new("Frame")
				local SliderBGCorner = Instance.new("UICorner")
				local SliderTitle = Instance.new("TextLabel")
				local SliderBar = Instance.new("Frame")
				local SliderButton = Instance.new("TextButton")
				local SliderBarCorner = Instance.new("UICorner")
				local Bar = Instance.new("Frame")
				local BarCorner = Instance.new("UICorner")
				local Sliderboxframe = Instance.new("Frame")
				local Sliderbox = Instance.new("UICorner")
				local Sliderbox_2 = Instance.new("TextBox")

				SliderFrame.Name = TitleText
				SliderFrame.Parent = Section
				SliderFrame.BackgroundTransparency = 1
				SliderFrame.Size = UDim2.new(1, 0, 0, 52)

				SliderBG.Name = "Background1"
				SliderBG.Parent = SliderFrame
				SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				SliderBG.Size = UDim2.new(1, -8, 1, 0)
				SliderBG.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
				SliderBG.BackgroundTransparency = 0.1

				SliderBGCorner.CornerRadius = UDim.new(0, 6)
				SliderBGCorner.Parent = SliderBG

				local sliderStroke = Instance.new("UIStroke", SliderBG)
				sliderStroke.Color = Color3.fromRGB(0, 210, 230)
				sliderStroke.Thickness = 1
				sliderStroke.Transparency = 0.7

				SliderTitle.Name = "TextColor"
				SliderTitle.Parent = SliderBG
				SliderTitle.BackgroundTransparency = 1
				SliderTitle.Position = UDim2.new(0, 10, 0, 0)
				SliderTitle.Size = UDim2.new(0.6, -10, 0, 24)
				SliderTitle.Font = Enum.Font.GothamBold
				SliderTitle.Text = TitleText
				SliderTitle.TextSize = 12
				SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
				SliderTitle.TextColor3 = Color3.fromRGB(200, 215, 225)

				-- Value box
				Sliderboxframe.Name = "Background2"
				Sliderboxframe.Parent = SliderBG
				Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
				Sliderboxframe.Position = UDim2.new(1, -8, 0, 4)
				Sliderboxframe.Size = UDim2.new(0, 55, 0, 18)
				Sliderboxframe.BackgroundColor3 = Color3.fromRGB(8, 12, 18)
				Sliderboxframe.BackgroundTransparency = 0

				Sliderbox.CornerRadius = UDim.new(0, 4)
				Sliderbox.Parent = Sliderboxframe

				local valStroke = Instance.new("UIStroke", Sliderboxframe)
				valStroke.Color = Color3.fromRGB(0, 210, 230)
				valStroke.Thickness = 1
				valStroke.Transparency = 0.6

				Sliderbox_2.Name = "TextColor"
				Sliderbox_2.Parent = Sliderboxframe
				Sliderbox_2.BackgroundTransparency = 1
				Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
				Sliderbox_2.Font = Enum.Font.GothamBold
				Sliderbox_2.Text = ""
				Sliderbox_2.TextSize = 11
				Sliderbox_2.TextColor3 = Color3.fromRGB(255, 210, 80)

				-- Slider track
				SliderBar.Name = "SliderBar"
				SliderBar.Parent = SliderFrame
				SliderBar.AnchorPoint = Vector2.new(0.5, 0)
				SliderBar.Position = UDim2.new(0.5, 0, 0, 30)
				SliderBar.Size = UDim2.new(1, -20, 0, 5)
				SliderBar.BackgroundColor3 = Color3.fromRGB(20, 28, 38)

				SliderButton.Name = "SliderButton"
				SliderButton.Parent = SliderBar
				SliderButton.BackgroundTransparency = 1
				SliderButton.Size = UDim2.new(1, 0, 4, 0)
				SliderButton.Position = UDim2.new(0, 0, -1.5, 0)
				SliderButton.Font = Enum.Font.GothamBold
				SliderButton.Text = ""

				SliderBarCorner.CornerRadius = UDim.new(1, 0)
				SliderBarCorner.Parent = SliderBar

				-- Fill bar (cyan)
				Bar.Name = "Bar"
				Bar.BorderSizePixel = 0
				Bar.Parent = SliderBar
				Bar.Size = UDim2.new(0, 0, 1, 0)
				Bar.BackgroundColor3 = Color3.fromRGB(0, 210, 230)

				local barGrad = Instance.new("UIGradient")
				barGrad.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 180, 200)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 220))
				}
				barGrad.Parent = Bar

				BarCorner.CornerRadius = UDim.new(1, 0)
				BarCorner.Parent = Bar

				SliderButton.MouseEnter:Connect(function()
					TweenService:Create(sliderStroke, TweenInfo.new(0.15), { Transparency = 0.3 }):Play()
				end)
				SliderButton.MouseLeave:Connect(function()
					TweenService:Create(sliderStroke, TweenInfo.new(0.15), { Transparency = 0.7 }):Play()
				end)

				local callBackAndSetText = function(val)
					Sliderbox_2.Text = tostring(val)
					if Callback then Callback(tonumber(val)) end
				end

				if DefaultValue then
					DefaultValue = math.clamp(DefaultValue, minValue, maxValue)
					Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 1, 0)
					Sliderbox_2.Text = tostring(DefaultValue)
				end

				local dragging = false
				local dragInput
				local holdTime = 0
				local holdStarted = 0

				local function onInputBegan(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						holdStarted = tick()
						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false
								holdStarted = 0
							end
						end)
					end
				end
				local function onInputEnded(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false; holdStarted = 0
					end
				end
				local function onInputChanged(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						dragInput = input
					end
				end

				SliderButton.InputBegan:Connect(onInputBegan)
				SliderButton.InputEnded:Connect(onInputEnded)
				SliderButton.InputChanged:Connect(onInputChanged)

				RunService.RenderStepped:Connect(function()
					if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
						dragging = true
					end
					if dragging and dragInput then
						local barWidth = math.clamp(dragInput.Position.X - SliderBar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
						local percentage = barWidth / SliderBar.AbsoluteSize.X
						local value = minValue + (maxValue - minValue) * percentage
						if Rounding then
							value = tonumber(string.format("%." .. Rounding .. "f", value))
						elseif not Precise then
							value = math.floor(value)
						end
						value = math.clamp(value, minValue, maxValue)
						pcall(function() callBackAndSetText(value) end)
						Bar.Size = UDim2.new(percentage, 0, 1, 0)
					end
				end)

				local function GetSliderValue(Value)
					Value = tonumber(Value) or minValue
					Value = math.clamp(Value, minValue, maxValue)
					if Rounding then
						Value = tonumber(string.format("%." .. Rounding .. "f", Value))
					elseif not Precise then
						Value = math.floor(Value)
					end
					local percentage = (Value - minValue) / (maxValue - minValue)
					Bar.Size = UDim2.new(percentage, 0, 1, 0)
					callBackAndSetText(Value)
				end

				Sliderbox_2.FocusLost:Connect(function() GetSliderValue(Sliderbox_2.Text) end)

				local slider_function = {}
				function slider_function.SetValue(Value) GetSliderValue(Value) end
				function slider_function.GetValue() return tonumber(Sliderbox_2.Text) or minValue end

				local controlData = {
					Name = TitleText, Section = Section, Element = SliderFrame,
					SectionName = Section_Name, TabName = Page_Name, TabButton = PageNameControl
				}
				table.insert(getgenv().AllControls, controlData)
				return slider_function
			end

			-- ============================================================
			-- ADD DROPDOWN - Cyberpunk style
			-- ============================================================
			function sectionFunction:AddDropdown(idk, Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local List = Setting.Values
				local Search = Setting.Search or false
				local Selected = Setting.Selected or Setting.Multi or false
				local Default = (function()
					if Setting.Default then
						if type(Setting.Default) == "number" then return List[Setting.Default]
						elseif type(Setting.Default) == "string" then return Setting.Default end
					end
					return nil
				end)()
				local Callback = Setting.Callback
				local pairsFunc = Setting.SortPairs or pairs

				local DropdownFrame = Instance.new("Frame")
				local Dropdownbg = Instance.new("Frame")
				local Dropdowncorner = Instance.new("UICorner")
				local Topdrop = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local ImgDrop = Instance.new("ImageLabel")
				local DropdownButton = Instance.new("TextButton")
				local Dropdownlisttt = Instance.new("Frame")
				local DropdownScroll = Instance.new("ScrollingFrame")
				local ScrollContainer = Instance.new("Frame")
				local ScrollContainerList = Instance.new("UIListLayout")

				DropdownFrame.Name = Title .. "DropdownFrame"
				DropdownFrame.Parent = Section
				DropdownFrame.BackgroundTransparency = 1
				DropdownFrame.Size = UDim2.new(1, 0, 0, 28)

				Dropdownbg.Name = "Background1"
				Dropdownbg.Parent = DropdownFrame
				Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
				Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
				Dropdownbg.Size = UDim2.new(1, -8, 1, 0)
				Dropdownbg.ClipsDescendants = true
				Dropdownbg.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
				Dropdownbg.BackgroundTransparency = 0.1

				Dropdowncorner.CornerRadius = UDim.new(0, 6)
				Dropdowncorner.Parent = Dropdownbg

				local dropStroke = Instance.new("UIStroke", Dropdownbg)
				dropStroke.Color = Color3.fromRGB(0, 210, 230)
				dropStroke.Thickness = 1
				dropStroke.Transparency = 0.7

				Topdrop.Name = "Background2"
				Topdrop.Parent = Dropdownbg
				Topdrop.Size = UDim2.new(1, 0, 0, 28)
				Topdrop.BackgroundColor3 = Color3.fromRGB(10, 14, 22)
				Topdrop.BackgroundTransparency = 0.2

				UICorner.CornerRadius = UDim.new(0, 6)
				UICorner.Parent = Topdrop

				local Dropdowntitle
				if Search then
					Dropdowntitle = Instance.new("TextBox")
					Dropdowntitle.PlaceholderText = Title
					Dropdowntitle.PlaceholderColor3 = Color3.fromRGB(50, 80, 95)
				else
					Dropdowntitle = Instance.new("TextLabel")
					Dropdowntitle.Text = Default and (Title .. ": " .. Default) or Title
				end

				Dropdowntitle.Name = "TextColorPlaceholder"
				Dropdowntitle.Parent = Topdrop
				Dropdowntitle.BackgroundTransparency = 1
				Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
				Dropdowntitle.Size = UDim2.new(1, -35, 1, 0)
				Dropdowntitle.Font = Enum.Font.GothamBold
				Dropdowntitle.TextSize = 12
				Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
				Dropdowntitle.ClipsDescendants = true
				Dropdowntitle.TextColor3 = Color3.fromRGB(200, 215, 225)

				ImgDrop.Name = "ImgDrop"
				ImgDrop.Parent = Topdrop
				ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
				ImgDrop.BackgroundTransparency = 1
				ImgDrop.Position = UDim2.new(1, -8, 0.5, 0)
				ImgDrop.Size = UDim2.new(0, 14, 0, 14)
				ImgDrop.Image = "rbxassetid://6954383209"
				ImgDrop.ImageColor3 = Color3.fromRGB(0, 210, 230)

				DropdownButton.Name = "DropdownButton"
				DropdownButton.Parent = Topdrop
				DropdownButton.BackgroundTransparency = 1
				DropdownButton.Size = Search and UDim2.new(0, 28, 0, 28) or UDim2.new(1, 0, 1, 0)
				DropdownButton.Position = Search and UDim2.new(1, -32, 0, 0) or UDim2.new(0, 0, 0, 0)
				DropdownButton.Font = Enum.Font.GothamBold
				DropdownButton.Text = ""

				Dropdownlisttt.Name = "Dropdownlisttt"
				Dropdownlisttt.Parent = Dropdownbg
				Dropdownlisttt.BackgroundTransparency = 1
				Dropdownlisttt.BorderSizePixel = 0
				Dropdownlisttt.Position = UDim2.new(0, 0, 0, 28)
				Dropdownlisttt.Size = UDim2.new(1, 0, 0, 0)

				DropdownScroll.Name = "DropdownScroll"
				DropdownScroll.Parent = Dropdownlisttt
				DropdownScroll.Active = true
				DropdownScroll.BackgroundTransparency = 1
				DropdownScroll.BorderSizePixel = 0
				DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
				DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
				DropdownScroll.ScrollBarThickness = 3
				DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

				ScrollContainer.Name = "ScrollContainer"
				ScrollContainer.Parent = DropdownScroll
				ScrollContainer.BackgroundTransparency = 1
				ScrollContainer.Position = UDim2.new(0, 4, 0, 4)
				ScrollContainer.Size = UDim2.new(1, -12, 1, -4)

				ScrollContainerList.Name = "ScrollContainerList"
				ScrollContainerList.Parent = ScrollContainer
				ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
				ScrollContainerList.Padding = UDim.new(0, 3)

				local isOpen = false
				local currentSelected = Default

				DropdownButton.MouseButton1Click:Connect(function()
					isOpen = not isOpen
					local listsize = isOpen and UDim2.new(1, 0, 0, math.min(#List * 26 + 8, 200)) or UDim2.new(1, 0, 0, 0)
					local mainsize = isOpen and UDim2.new(1, 0, 0, math.min(#List * 26 + 8, 200) + 28) or UDim2.new(1, 0, 0, 28)
					local rotation = isOpen and 180 or 0
					TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Size = listsize }):Play()
					TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Size = mainsize }):Play()
					TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Rotation = rotation }):Play()
					TweenService:Create(dropStroke, TweenInfo.new(0.2), { Transparency = isOpen and 0.3 or 0.7 }):Play()
				end)

				ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 8 + ScrollContainerList.AbsoluteContentSize.Y)
				end)

				-- Populate items
				local ListNew = {}
				if Selected and type(List[1]) == "string" then
					for _, v in pairs(List) do ListNew[v] = false end
				else
					for _, v in pairs(List) do ListNew[v] = v end
				end

				local dropdownFunction = {}
				local itemButtons = {}

				for i, v in pairsFunc(ListNew) do
					local itemVal = v
					local SampleItem = Instance.new("Frame")
					local SampleItemCorner = Instance.new("UICorner")
					local SampleItemBG = Instance.new("Frame")
					local SampleItemBGCorner = Instance.new("UICorner")
					local SampleItemTitle = Instance.new("TextLabel")
					local SampleItemCheck = Instance.new("ImageButton")
					local SampleItemButton = Instance.new("TextButton")

					SampleItem.Name = tostring(i)
					SampleItem.Parent = ScrollContainer
					SampleItem.BackgroundTransparency = 1
					SampleItem.Size = UDim2.new(1, 0, 0, 24)

					SampleItemCorner.CornerRadius = UDim.new(0, 4)
					SampleItemCorner.Parent = SampleItem

					SampleItemBG.Name = "SampleItemBG"
					SampleItemBG.Parent = SampleItem
					SampleItemBG.AnchorPoint = Vector2.new(0.5, 0.5)
					SampleItemBG.BackgroundColor3 = Color3.fromRGB(0, 210, 230)
					SampleItemBG.BackgroundTransparency = 1
					SampleItemBG.Position = UDim2.new(0.5, 0, 0.5, 0)
					SampleItemBG.Size = UDim2.new(1, 0, 1, 0)

					SampleItemBGCorner.CornerRadius = UDim.new(0, 4)
					SampleItemBGCorner.Parent = SampleItemBG

					SampleItemTitle.Name = "SampleItemTitle"
					SampleItemTitle.Parent = SampleItemBG
					SampleItemTitle.BackgroundTransparency = 1
					SampleItemTitle.Position = UDim2.new(0, 8, 0, 0)
					SampleItemTitle.Size = UDim2.new(1, -30, 0, 24)
					SampleItemTitle.Font = Enum.Font.GothamBold
					SampleItemTitle.Text = tostring(i)
					SampleItemTitle.TextColor3 = Color3.fromRGB(200, 215, 225)
					SampleItemTitle.TextSize = 12
					SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left

					SampleItemCheck.Name = "SampleItemCheck"
					SampleItemCheck.Parent = SampleItemBG
					SampleItemCheck.AnchorPoint = Vector2.new(1, 0.5)
					SampleItemCheck.BackgroundTransparency = 1
					SampleItemCheck.Position = UDim2.new(1, -2, 0.5, 0)
					SampleItemCheck.Size = UDim2.new(0, 22, 0, 22)
					SampleItemCheck.ZIndex = 2
					SampleItemCheck.Image = "rbxassetid://3926305904"
					SampleItemCheck.ImageColor3 = Color3.fromRGB(0, 210, 230)
					SampleItemCheck.ImageRectOffset = Vector2.new(312, 4)
					SampleItemCheck.ImageRectSize = Vector2.new(24, 24)
					SampleItemCheck.ImageTransparency = (tostring(i) == tostring(Default)) and 0 or 1

					SampleItemButton.Name = "SampleItemButton"
					SampleItemButton.Parent = SampleItem
					SampleItemButton.BackgroundTransparency = 1
					SampleItemButton.Size = UDim2.new(1, 0, 1, 0)
					SampleItemButton.Font = Enum.Font.SourceSans
					SampleItemButton.Text = ""
					SampleItemButton.ZIndex = 2

					SampleItemButton.MouseEnter:Connect(function()
						if tostring(i) ~= tostring(currentSelected) then
							TweenService:Create(SampleItemBG, TweenInfo.new(0.1), { BackgroundTransparency = 0.85 }):Play()
							TweenService:Create(SampleItemTitle, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(0, 210, 230) }):Play()
						end
					end)
					SampleItemButton.MouseLeave:Connect(function()
						if tostring(i) ~= tostring(currentSelected) then
							TweenService:Create(SampleItemBG, TweenInfo.new(0.1), { BackgroundTransparency = 1 }):Play()
							TweenService:Create(SampleItemTitle, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(200, 215, 225) }):Play()
						end
					end)
					SampleItemButton.MouseButton1Click:Connect(function()
						if Selected then
							itemVal = not itemVal
							ListNew[i] = itemVal
							TweenService:Create(SampleItemCheck, TweenInfo.new(0.15), { ImageTransparency = itemVal and 0 or 1 }):Play()
							TweenService:Create(SampleItemBG, TweenInfo.new(0.15), { BackgroundTransparency = itemVal and 0.7 or 1 }):Play()
							if Callback then Callback(i, itemVal) end
						else
							-- deselect all
							for _, btn in pairs(itemButtons) do
								TweenService:Create(btn.check, TweenInfo.new(0.15), { ImageTransparency = 1 }):Play()
								TweenService:Create(btn.bg, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
								TweenService:Create(btn.title, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(200, 215, 225) }):Play()
							end
							currentSelected = tostring(i)
							TweenService:Create(SampleItemCheck, TweenInfo.new(0.15), { ImageTransparency = 0 }):Play()
							TweenService:Create(SampleItemBG, TweenInfo.new(0.15), { BackgroundTransparency = 0.7 }):Play()
							TweenService:Create(SampleItemTitle, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(0, 210, 230) }):Play()
							if not Search then Dropdowntitle.Text = Title .. ": " .. tostring(i) end
							if Callback then Callback(tostring(i)) end

							TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Size = UDim2.new(1, 0, 0, 0) }):Play()
							TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Size = UDim2.new(1, 0, 0, 28) }):Play()
							TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Rotation = 0 }):Play()
							isOpen = false
						end
					end)

					itemButtons[tostring(i)] = { check = SampleItemCheck, bg = SampleItemBG, title = SampleItemTitle }
				end

				function dropdownFunction:SetValue(value)
					for key, btn in pairs(itemButtons) do
						TweenService:Create(btn.check, TweenInfo.new(0.15), { ImageTransparency = 1 }):Play()
						TweenService:Create(btn.bg, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
						TweenService:Create(btn.title, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(200, 215, 225) }):Play()
					end
					if itemButtons[tostring(value)] then
						currentSelected = tostring(value)
						TweenService:Create(itemButtons[tostring(value)].check, TweenInfo.new(0.15), { ImageTransparency = 0 }):Play()
						TweenService:Create(itemButtons[tostring(value)].bg, TweenInfo.new(0.15), { BackgroundTransparency = 0.7 }):Play()
						TweenService:Create(itemButtons[tostring(value)].title, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(0, 210, 230) }):Play()
						if not Search then Dropdowntitle.Text = Title .. ": " .. tostring(value) end
					end
				end
				function dropdownFunction:GetValue() return currentSelected end
				function dropdownFunction:SetTitle(newTitle)
					if Search then Dropdowntitle.PlaceholderText = newTitle
					else Dropdowntitle.Text = newTitle end
				end

				local controlData = {
					Name = Title, Section = Section, Element = DropdownFrame,
					SectionName = Section_Name, TabName = Page_Name, TabButton = PageNameControl,
					SetValue = dropdownFunction.SetValue, GetValue = dropdownFunction.GetValue
				}
				table.insert(getgenv().AllControls, controlData)
				return dropdownFunction
			end

			-- ============================================================
			-- ADD KEYBIND - Cyberpunk style
			-- ============================================================
			function sectionFunction:AddKeyBind(Setting, Callback)
				local TitleText = tostring(Setting.Title or Setting.Text) or ""
				local Default = Setting.Default or Setting.Key or "F"
				local Mode = Setting.Mode or "Toggle"
				local Callback = Setting.Callback or Callback or function() end

				local function GetKeyString(key)
					local keyStr = tostring(key)
					keyStr = keyStr:gsub("Enum.UserInputType.", "")
					keyStr = keyStr:gsub("Enum.KeyCode.", "")
					return keyStr
				end

				local CurrentKey = GetKeyString(Default)
				local CurrentMode = Mode
				local Picking = false
				local ToggleState = false
				local HoldActive = false

				local BindFrame = Instance.new("Frame")
				local BindBG = Instance.new("Frame")
				local BindBGCorner = Instance.new("UICorner")
				local BindButtonTitle = Instance.new("TextLabel")
				local BindCor = Instance.new("Frame")
				local BindCorCorner = Instance.new("UICorner")
				local Bindkey = Instance.new("TextButton")

				BindFrame.Name = TitleText .. "bguvl"
				BindFrame.Parent = Section
				BindFrame.BackgroundTransparency = 1
				BindFrame.Size = UDim2.new(1, 0, 0, 32)

				BindBG.Name = "Background1"
				BindBG.Parent = BindFrame
				BindBG.AnchorPoint = Vector2.new(0.5, 0.5)
				BindBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				BindBG.Size = UDim2.new(1, -8, 1, 0)
				BindBG.BackgroundColor3 = Color3.fromRGB(14, 18, 26)
				BindBG.BackgroundTransparency = 0.1

				BindBGCorner.CornerRadius = UDim.new(0, 6)
				BindBGCorner.Parent = BindBG

				local bindStroke = Instance.new("UIStroke", BindBG)
				bindStroke.Color = Color3.fromRGB(0, 210, 230)
				bindStroke.Thickness = 1
				bindStroke.Transparency = 0.7

				BindButtonTitle.Name = "TextColor"
				BindButtonTitle.Parent = BindBG
				BindButtonTitle.BackgroundTransparency = 1
				BindButtonTitle.Position = UDim2.new(0, 10, 0, 0)
				BindButtonTitle.Size = UDim2.new(1, -10, 1, 0)
				BindButtonTitle.Font = Enum.Font.GothamBold
				BindButtonTitle.Text = TitleText
				BindButtonTitle.TextSize = 12
				BindButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
				BindButtonTitle.TextColor3 = Color3.fromRGB(200, 215, 225)

				BindCor.Name = "Background2"
				BindCor.Parent = BindBG
				BindCor.AnchorPoint = Vector2.new(1, 0.5)
				BindCor.Position = UDim2.new(1, -6, 0.5, 0)
				BindCor.Size = UDim2.new(0, 70, 0, 20)
				BindCor.BackgroundColor3 = Color3.fromRGB(8, 12, 18)

				BindCorCorner.CornerRadius = UDim.new(0, 4)
				BindCorCorner.Parent = BindCor

				local keyStroke = Instance.new("UIStroke", BindCor)
				keyStroke.Color = Color3.fromRGB(0, 210, 230)
				keyStroke.Thickness = 1
				keyStroke.Transparency = 0.5

				Bindkey.Name = "Bindkey"
				Bindkey.Parent = BindCor
				Bindkey.BackgroundTransparency = 1
				Bindkey.Size = UDim2.new(1, 0, 1, 0)
				Bindkey.Font = Enum.Font.GothamBold
				Bindkey.Text = "[" .. CurrentKey .. "]"
				Bindkey.TextSize = 11
				Bindkey.TextColor3 = Color3.fromRGB(255, 210, 80)

				Bindkey.MouseButton1Click:Connect(function()
					if Picking then return end
					Picking = true
					Bindkey.Text = "[...]"
					TweenService:Create(keyStroke, TweenInfo.new(0.15), { Transparency = 0.1, Color = Color3.fromRGB(0, 255, 200) }):Play()
					task.wait(0.2)
					local Connection
					Connection = uis.InputBegan:Connect(function(input)
						if Picking then
							local Key
							if input.UserInputType == Enum.UserInputType.Keyboard then Key = input.KeyCode.Name
							elseif input.UserInputType == Enum.UserInputType.MouseButton1 then Key = "MouseLeft"
							elseif input.UserInputType == Enum.UserInputType.MouseButton2 then Key = "MouseRight" end
							if Key then
								Picking = false
								CurrentKey = Key
								Bindkey.Text = "[" .. Key .. "]"
								TweenService:Create(keyStroke, TweenInfo.new(0.15), { Transparency = 0.5, Color = Color3.fromRGB(0, 210, 230) }):Play()
								Connection:Disconnect()
							end
						end
					end)
				end)

				uis.InputBegan:Connect(function(input, gpe)
					if gpe or Picking then return end
					if uis:GetFocusedTextBox() then return end
					local pressedKey
					if input.UserInputType == Enum.UserInputType.Keyboard then pressedKey = input.KeyCode.Name
					elseif input.UserInputType == Enum.UserInputType.MouseButton1 then pressedKey = "MouseLeft"
					elseif input.UserInputType == Enum.UserInputType.MouseButton2 then pressedKey = "MouseRight" end
					if pressedKey == CurrentKey then
						if CurrentMode == "Toggle" then ToggleState = not ToggleState; pcall(Callback, ToggleState)
						elseif CurrentMode == "Hold" then HoldActive = true; pcall(Callback, true) end
					end
				end)

				uis.InputEnded:Connect(function(input)
					if Picking then return end
					if uis:GetFocusedTextBox() then return end
					local releasedKey
					if input.UserInputType == Enum.UserInputType.Keyboard then releasedKey = input.KeyCode.Name
					elseif input.UserInputType == Enum.UserInputType.MouseButton1 then releasedKey = "MouseLeft"
					elseif input.UserInputType == Enum.UserInputType.MouseButton2 then releasedKey = "MouseRight" end
					if releasedKey == CurrentKey and CurrentMode == "Hold" and HoldActive then
						HoldActive = false; pcall(Callback, false)
					end
				end)

				local controlData = {
					Name = TitleText, Section = Section, Element = BindFrame,
					SectionName = Section_Name, TabName = Page_Name, TabButton = PageNameControl
				}
				table.insert(getgenv().AllControls, controlData)

				local keybindFunction = {}
				function keybindFunction:Set(newKey) CurrentKey = GetKeyString(newKey); Bindkey.Text = "[" .. CurrentKey .. "]" end
				function keybindFunction:Get() return CurrentKey end
				function keybindFunction:SetMode(mode)
					if mode == "Hold" or mode == "Toggle" then CurrentMode = mode; ToggleState = false; HoldActive = false end
				end
				function keybindFunction:GetMode() return CurrentMode end
				return keybindFunction
			end

			-- ============================================================
			-- ADD SEPARATOR
			-- ============================================================
			function sectionFunction:AddSeperator(text)
				local SeparatorFrame = Instance.new("Frame")
				SeparatorFrame.Name = "Separator"
				SeparatorFrame.Parent = Section
				SeparatorFrame.BackgroundTransparency = 1
				SeparatorFrame.Size = UDim2.new(1, 0, 0, 22)

				if text and text ~= "" then
					local SeparatorLabel = Instance.new("TextLabel")
					SeparatorLabel.Parent = SeparatorFrame
					SeparatorLabel.BackgroundTransparency = 1
					SeparatorLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					SeparatorLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
					SeparatorLabel.AutomaticSize = Enum.AutomaticSize.X
					SeparatorLabel.Size = UDim2.new(0, 0, 1, 0)
					SeparatorLabel.Font = Enum.Font.GothamBold
					SeparatorLabel.Text = text
					SeparatorLabel.TextColor3 = Color3.fromRGB(0, 210, 230)
					SeparatorLabel.TextSize = 11

					local LeftLine = Instance.new("Frame")
					LeftLine.Parent = SeparatorFrame
					LeftLine.BackgroundColor3 = Color3.fromRGB(0, 180, 200)
					LeftLine.BorderSizePixel = 0
					LeftLine.AnchorPoint = Vector2.new(0, 0.5)
					LeftLine.Position = UDim2.new(0, 0, 0.5, 0)
					LeftLine.Size = UDim2.new(0.3, 0, 0, 1)

					local RightLine = Instance.new("Frame")
					RightLine.Parent = SeparatorFrame
					RightLine.BackgroundColor3 = Color3.fromRGB(0, 180, 200)
					RightLine.BorderSizePixel = 0
					RightLine.AnchorPoint = Vector2.new(1, 0.5)
					RightLine.Position = UDim2.new(1, 0, 0.5, 0)
					RightLine.Size = UDim2.new(0.3, 0, 0, 1)

					local LG = Instance.new("UIGradient")
					LG.Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)
					}
					LG.Parent = LeftLine

					local RG = Instance.new("UIGradient")
					RG.Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)
					}
					RG.Parent = RightLine
				else
					local SeparatorLine = Instance.new("Frame")
					SeparatorLine.Parent = SeparatorFrame
					SeparatorLine.BackgroundColor3 = Color3.fromRGB(0, 180, 200)
					SeparatorLine.BorderSizePixel = 0
					SeparatorLine.Position = UDim2.new(0, 8, 0.5, 0)
					SeparatorLine.Size = UDim2.new(1, -16, 0, 1)
					local LineGradient = Instance.new("UIGradient")
					LineGradient.Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(0.15, 0),
						NumberSequenceKeypoint.new(0.85, 0),
						NumberSequenceKeypoint.new(1, 1)
					}
					LineGradient.Parent = SeparatorLine
				end

				local controlData = {
					Name = text or "Separator", Section = Section, Element = SeparatorFrame,
					SectionName = Section_Name, TabName = Page_Name, TabButton = PageNameControl
				}
				table.insert(getgenv().AllControls, controlData)
			end

			-- DropdownSection alias
			function sectionFunction:AddDropdownSection(Setting)
				return self:AddDropdown(nil, Setting)
			end

			return sectionFunction
		end

		local pagefunc = {}
		function pagefunc:AddLeftGroupbox(name)
			return pageFunction:AddSection(name)
		end
		function pagefunc:AddRightGroupbox(name)
			return pageFunction:AddSection(name)
		end

		return pagefunc
	end

	return Main_Function
end

return Library
