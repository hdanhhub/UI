-- source shared by araujozwx 

if getgenv().Nousigi then 
	if game.CoreGui:FindFirstChild("HDanh Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name,  "HDanh Hub") then
				v:Destroy()
			end
		end
	end
end
getgenv().Nousigi = true

local DisableAnimation = game.Players.LocalPlayer.PlayerGui:FindFirstChild('TouchGui')

-- ============================================================
-- THEME: MODERN DARK BLUE - Xanh dương thanh lịch, nền tối
-- ============================================================
local T1UIColor = {
    ["Border Color"]                  = Color3.fromRGB(70, 130, 200),
    ["Click Effect Color"]            = Color3.fromRGB(100, 180, 255),
    ["Setting Icon Color"]            = Color3.fromRGB(200, 200, 210),
    ["Logo Image"]                    = "rbxassetid://123613996022560",
    ["Search Icon Color"]             = Color3.fromRGB(70, 130, 200),
    ["Search Icon Highlight Color"]   = Color3.fromRGB(100, 180, 255),
    ["GUI Text Color"]                = Color3.fromRGB(255, 255, 255),
    ["Text Color"]                    = Color3.fromRGB(240, 240, 245),
    ["Placeholder Text Color"]        = Color3.fromRGB(140, 140, 155),
    ["Title Text Color"]              = Color3.fromRGB(100, 180, 255),

    ["Background Main Color"]         = Color3.fromRGB(22, 24, 32),
    ["Background 1 Color"]            = Color3.fromRGB(33, 36, 46),
    ["Background 1 Transparency"]     = 0.05,
    ["Background 2 Color"]            = Color3.fromRGB(40, 44, 55),
    ["Background 3 Color"]            = Color3.fromRGB(35, 38, 48),
    ["Background Image"]              = "",

    ["Page Selected Color"]           = Color3.fromRGB(70, 130, 200),
    ["Section Text Color"]            = Color3.fromRGB(100, 180, 255),
    ["Section Underline Color"]       = Color3.fromRGB(70, 130, 200),
    ["Toggle Border Color"]           = Color3.fromRGB(90, 95, 110),
    ["Toggle Checked Color"]          = Color3.fromRGB(70, 130, 200),
    ["Toggle Desc Color"]             = Color3.fromRGB(180, 180, 190),

    ["Button Color"]                  = Color3.fromRGB(45, 50, 62),
    ["Label Color"]                   = Color3.fromRGB(33, 36, 46),
    ["Dropdown Icon Color"]           = Color3.fromRGB(70, 130, 200),
    ["Dropdown Selected Color"]       = Color3.fromRGB(70, 130, 200),
    ["Dropdown Selected Check Color"] = Color3.fromRGB(100, 180, 255),

    ["Textbox Highlight Color"]       = Color3.fromRGB(70, 130, 200),
    ["Box Highlight Color"]           = Color3.fromRGB(70, 130, 200),
    ["Slider Line Color"]             = Color3.fromRGB(60, 65, 78),
    ["Slider Highlight Color"]        = Color3.fromRGB(100, 180, 255),

    ["Tween Animation 1 Speed"]       = DisableAnimation and 0 or 0.25,
    ["Tween Animation 2 Speed"]       = DisableAnimation and 0 or 0.5,
    ["Tween Animation 3 Speed"]       = DisableAnimation and 0 or 0.1,
    ["Text Stroke Transparency"]      = .8
}

getgenv().UIColor = T1UIColor
getgenv().AllControls = {}
getgenv().UIToggled = false

local Library = {}
local Library_Function = {}
local TweenService = game:GetService('TweenService')
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ================== SCREEN GUIs ==================
Library_Function.Gui = Instance.new('ScreenGui')
Library_Function.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.Gui.Name = 'HDanh Hub GUI'
Library_Function.Gui.Enabled = false
Library_Function.Gui.Parent = game:GetService('CoreGui')

Library_Function.NotiGui = Instance.new('ScreenGui')
Library_Function.NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.NotiGui.Name = 'HDanh Hub Notification'
Library_Function.NotiGui.Parent = game:GetService('CoreGui')

-- ================== TOGGLE BUTTON (BANANA ICON) ==================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BananaToggleGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = game:GetService("CoreGui")

local mainButton = Instance.new("ImageButton")
mainButton.Parent = screenGui
mainButton.Size = UDim2.new(0, 60, 0, 60)
mainButton.Position = UDim2.new(0, 15, 0.5, -30)
mainButton.BackgroundColor3 = Color3.fromRGB(33, 36, 46)
mainButton.BackgroundTransparency = 0
mainButton.AutoButtonColor = false
mainButton.Image = "rbxassetid://123613996022560"
mainButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
mainButton.ScaleType = Enum.ScaleType.Fit
mainButton.ZIndex = 10
mainButton.ClipsDescendants = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = mainButton

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = mainButton
UIStroke.Color = Color3.fromRGB(70, 130, 200)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.7

-- ================== TOGGLE LOGIC ==================
local isToggled = true
local dragging = false
local dragStart
local startPos
local CLICK_DISTANCE = 6

Library_Function.Gui.Enabled = true -- Mặc định bật

mainButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        startPos = mainButton.Position
        dragging = true
    end
end)

uis.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        if math.abs(delta.X) > CLICK_DISTANCE or math.abs(delta.Y) > CLICK_DISTANCE then
            mainButton.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end
end)

uis.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        if math.abs(delta.X) < CLICK_DISTANCE and math.abs(delta.Y) < CLICK_DISTANCE then
            isToggled = not isToggled
            getgenv().UIToggled = isToggled
            
            -- Cập nhật UI chính
            local gui = game.CoreGui:FindFirstChild("HDanh Hub GUI")
            if gui then
                gui.Enabled = isToggled
            end
            
            -- Animation
            if isToggled then
                TweenService:Create(mainButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(45, 50, 62) }):Play()
                TweenService:Create(mainButton, TweenInfo.new(0.1), { Size = UDim2.new(0, 55, 0, 55) }):Play()
                wait(0.1)
                TweenService:Create(mainButton, TweenInfo.new(0.1), { Size = UDim2.new(0, 60, 0, 60) }):Play()
            else
                TweenService:Create(mainButton, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(22, 24, 32) }):Play()
                TweenService:Create(mainButton, TweenInfo.new(0.1), { Size = UDim2.new(0, 55, 0, 55) }):Play()
                wait(0.1)
                TweenService:Create(mainButton, TweenInfo.new(0.1), { Size = UDim2.new(0, 60, 0, 60) }):Play()
            end
        end
        dragging = false
    end
end)

mainButton.MouseEnter:Connect(function()
    TweenService:Create(mainButton, TweenInfo.new(0.15), { Size = UDim2.new(0, 64, 0, 64) }):Play()
    TweenService:Create(UIStroke, TweenInfo.new(0.15), { Transparency = 0.4 }):Play()
end)

mainButton.MouseLeave:Connect(function()
    TweenService:Create(mainButton, TweenInfo.new(0.15), { Size = UDim2.new(0, 60, 0, 60) }):Play()
    TweenService:Create(UIStroke, TweenInfo.new(0.15), { Transparency = 0.7 }):Play()
end)

-- ================== NOTIFICATION SYSTEM ==================
local NotiContainer = Instance.new("Frame")
local NotiList = Instance.new("UIListLayout")

NotiContainer.Name = "NotiContainer"
NotiContainer.Parent = Library_Function.NotiGui
NotiContainer.AnchorPoint = Vector2.new(1, 1)
NotiContainer.BackgroundColor3 = Color3.fromRGB(33, 36, 46)
NotiContainer.BackgroundTransparency = 1.000
NotiContainer.Position = UDim2.new(1, -5, 1, -5)
NotiContainer.Size = UDim2.new(0, 350, 1, -10)

NotiList.Name = "NotiList"
NotiList.Parent = NotiContainer
NotiList.SortOrder = Enum.SortOrder.LayoutOrder
NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotiList.Padding = UDim.new(0, 5)

function Library_Function.Getcolor(color)
    return {
        math.floor(color.r * 255),
        math.floor(color.g * 255),
        math.floor(color.b * 255)
    }
end

local function libCreateNoti(Setting)
    local Title = Setting.Title or ""
    local Description = Setting.Description or Setting.Desc or Setting.Content or ""
    local Duration = Setting.Duration or 5

    local NotiFrame = Instance.new("Frame")
    NotiFrame.Name = "NotiFrame"
    NotiFrame.Parent = NotiContainer
    NotiFrame.BackgroundColor3 = Color3.fromRGB(33, 36, 46)
    NotiFrame.BackgroundTransparency = 1.000
    NotiFrame.ClipsDescendants = true
    NotiFrame.Size = UDim2.new(1, 0, 0, 0)
    NotiFrame.AutomaticSize = Enum.AutomaticSize.Y

    local Noticontainer = Instance.new("Frame")
    Noticontainer.Name = "Noticontainer"
    Noticontainer.Parent = NotiFrame
    Noticontainer.Position = UDim2.new(1, 0, 0, 0)
    Noticontainer.Size = UDim2.new(1, 0, 1, 6)
    Noticontainer.AutomaticSize = Enum.AutomaticSize.Y
    Noticontainer.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Noticontainer

    local Topnoti = Instance.new("Frame")
    Topnoti.Name = "Topnoti"
    Topnoti.Parent = Noticontainer
    Topnoti.BackgroundColor3 = Color3.fromRGB(33, 36, 46)
    Topnoti.BackgroundTransparency = 1.000
    Topnoti.Position = UDim2.new(0, 0, 0, 5)
    Topnoti.Size = UDim2.new(1, 0, 0, 25)

    local Ruafimg = Instance.new("ImageLabel")
    Ruafimg.Name = "Ruafimg"
    Ruafimg.Parent = Topnoti
    Ruafimg.BackgroundColor3 = Color3.fromRGB(33, 36, 46)
    Ruafimg.BackgroundTransparency = 1.000
    Ruafimg.Position = UDim2.new(0, 5, 0, 0)
    Ruafimg.Size = UDim2.new(0, 25, 0, 25)
    Ruafimg.Image = getgenv().UIColor["Logo Image"]
    
    local RuafimgCorner = Instance.new("UICorner")
    RuafimgCorner.CornerRadius = UDim.new(1, 0)
    RuafimgCorner.Parent = Ruafimg

    local TextLabelNoti = Instance.new("TextLabel")
    TextLabelNoti.Name = "TextLabelNoti"
    TextLabelNoti.Parent = Topnoti
    TextLabelNoti.BackgroundColor3 = Color3.fromRGB(33, 36, 46)
    TextLabelNoti.BackgroundTransparency = 1.000
    TextLabelNoti.Position = UDim2.new(0, 35, 0, 0)
    TextLabelNoti.Size = UDim2.new(1, -35, 1, 0)
    TextLabelNoti.Font = Enum.Font.GothamBold
    TextLabelNoti.TextSize = 14.000
    TextLabelNoti.TextWrapped = true
    TextLabelNoti.TextXAlignment = Enum.TextXAlignment.Left
    TextLabelNoti.RichText = true
    TextLabelNoti.TextColor3 = getgenv().UIColor["GUI Text Color"]
    TextLabelNoti.Text = "<font color=\"rgb(100,180,255)\">HDanh Hub</font> " .. Title

    local CloseContainer = Instance.new("Frame")
    CloseContainer.Name = "CloseContainer"
    CloseContainer.Parent = Topnoti
    CloseContainer.AnchorPoint = Vector2.new(1, 0.5)
    CloseContainer.BackgroundColor3 = Color3.fromRGB(33, 36, 46)
    CloseContainer.BackgroundTransparency = 1.000
    CloseContainer.Position = UDim2.new(1, -4, 0.5, 0)
    CloseContainer.Size = UDim2.new(0, 22, 0, 22)

    local CloseImage = Instance.new("ImageLabel")
    CloseImage.Name = "CloseImage"
    CloseImage.Parent = CloseContainer
    CloseImage.BackgroundColor3 = Color3.fromRGB(33, 36, 46)
    CloseImage.BackgroundTransparency = 1.000
    CloseImage.Size = UDim2.new(1, 0, 1, 0)
    CloseImage.Image = "rbxassetid://3926305904"
    CloseImage.ImageRectOffset = Vector2.new(284, 4)
    CloseImage.ImageRectSize = Vector2.new(24, 24)
    CloseImage.ImageColor3 = getgenv().UIColor["Search Icon Color"]

    local TextButton = Instance.new("TextButton")
    TextButton.Parent = CloseContainer
    TextButton.BackgroundColor3 = Color3.fromRGB(33, 36, 46)
    TextButton.BackgroundTransparency = 1.000
    TextButton.Size = UDim2.new(1, 0, 1, 0)
    TextButton.Font = Enum.Font.SourceSans
    TextButton.Text = ""
    TextButton.TextColor3 = Color3.fromRGB(255, 240, 180)
    TextButton.TextSize = 14.000

    if Description and Description ~= "" then
        local TextLabelNoti2 = Instance.new("TextLabel")
        TextLabelNoti2.Name = 'TextColor'
        TextLabelNoti2.Parent = Noticontainer
        TextLabelNoti2.BackgroundColor3 = Color3.fromRGB(33, 36, 46)
        TextLabelNoti2.BackgroundTransparency = 1.000
        TextLabelNoti2.Position = UDim2.new(0, 10, 0, 35)
        TextLabelNoti2.Size = UDim2.new(1, -15, 0, 0)
        TextLabelNoti2.Font = Enum.Font.GothamBold
        TextLabelNoti2.Text = Description
        TextLabelNoti2.TextSize = 14.000
        TextLabelNoti2.TextXAlignment = Enum.TextXAlignment.Left
        TextLabelNoti2.RichText = true
        TextLabelNoti2.TextColor3 = getgenv().UIColor["Text Color"]
        TextLabelNoti2.AutomaticSize = Enum.AutomaticSize.Y
        TextLabelNoti2.TextWrapped = true
    end

    local function remove()
        TweenService:Create(Noticontainer, TweenInfo.new(0.25), {
            Position = UDim2.new(1, 0, 0, 0)
        }):Play()
        wait(.25)
        NotiFrame:Destroy()
    end

    TweenService:Create(Noticontainer, TweenInfo.new(0.25), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()

    TextButton.MouseEnter:Connect(function()
        TweenService:Create(CloseImage, TweenInfo.new(0.2), {
            ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
        }):Play()
    end)

    TextButton.MouseLeave:Connect(function()
        TweenService:Create(CloseImage, TweenInfo.new(0.2), {
            ImageColor3 = getgenv().UIColor["Search Icon Color"]
        }):Play()
    end)

    TextButton.MouseButton1Click:Connect(function()
        remove()
    end)

    spawn(function()
        wait(Duration)
        remove()
    end)
end

function Library:Notify(Setting, bypass)
    if not getgenv().Config or bypass then
        local s, e = pcall(function()
            libCreateNoti(Setting)
        end)
        if e then
            print(e)
        end
    end
end

-- ================== KÉO THẢ ==================
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
            object.Position = UDim2.new(
                startPosition.X.Scale, 
                startPosition.X.Offset + delta.X, 
                startPosition.Y.Scale, 
                startPosition.Y.Offset + delta.Y
            )
        end
    end)
end

-- ================== MAIN WINDOW ==================
function Library:CreateWindow(Setting)
    local TitleNameMain = Setting.Title or "HDanh Hub"
    getgenv().MainDesc = Setting.Desc or Setting.Subtitle or ""
    
    if Setting.Image then
        getgenv().UIColor["Logo Image"] = Setting.Image
    end

    -- Main container
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = Library_Function.Gui
    Main.BackgroundColor3 = getgenv().UIColor["Background Main Color"]
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Size = UDim2.new(0, 650, 0, 450)
    Main.BorderSizePixel = 0

    -- Corner
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = Main

    -- Shadow effect
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = Main
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://5028857084"
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(24, 24, 276, 276)

    -- Border stroke
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Parent = Main
    MainStroke.Color = getgenv().UIColor["Border Color"]
    MainStroke.Thickness = 1.5
    MainStroke.Transparency = 0.5

    -- Top bar (drag handle)
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BorderSizePixel = 0
    
    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 10)
    TopBarCorner.Parent = TopBar

    makeDraggable(TopBar, Main)

    -- Logo
    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Parent = TopBar
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0, 10, 0.5, -12)
    Logo.Size = UDim2.new(0, 24, 0, 24)
    Logo.Image = getgenv().UIColor["Logo Image"]
    Logo.ScaleType = Enum.ScaleType.Fit

    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Parent = TopBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 40, 0, 0)
    TitleLabel.Size = UDim2.new(0, 200, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 16
    TitleLabel.TextColor3 = getgenv().UIColor["GUI Text Color"]
    TitleLabel.Text = TitleNameMain
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.RichText = true

    -- Tab container (horizontal scroll)
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = TopBar
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 250, 0, 0)
    TabContainer.Size = UDim2.new(1, -260, 1, 0)
    TabContainer.ScrollingDirection = Enum.ScrollingDirection.X
    TabContainer.ScrollBarThickness = 0
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContainer.BorderSizePixel = 0
    TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.X

    local TabList = Instance.new("UIListLayout")
    TabList.Name = "TabList"
    TabList.Parent = TabContainer
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    TabList.VerticalAlignment = Enum.VerticalAlignment.Center

    -- Content area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "Content"
    ContentArea.Parent = Main
    ContentArea.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
    ContentArea.Position = UDim2.new(0, 0, 0, 40)
    ContentArea.Size = UDim2.new(1, 0, 1, -40)
    ContentArea.BorderSizePixel = 0
    ContentArea.ClipsDescendants = true
    
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 10)
    ContentCorner.Parent = ContentArea

    -- Page container
    local PageContainer = Instance.new("Frame")
    PageContainer.Name = "PageContainer"
    PageContainer.Parent = ContentArea
    PageContainer.BackgroundTransparency = 1
    PageContainer.Size = UDim2.new(1, 0, 1, 0)
    PageContainer.ClipsDescendants = true

    local UIPage = Instance.new("UIPageLayout")
    UIPage.Name = "UIPage"
    UIPage.Parent = PageContainer
    UIPage.FillDirection = Enum.FillDirection.Vertical
    UIPage.SortOrder = Enum.SortOrder.LayoutOrder
    UIPage.EasingDirection = Enum.EasingDirection.InOut
    UIPage.EasingStyle = Enum.EasingStyle.Quart
    UIPage.TweenTime = getgenv().UIColor["Tween Animation 1 Speed"]

    getgenv().ReadyForGuiLoaded = true

    -- Tab pages storage
    local TabPages = {}
    local FirstTab = true

    -- AddTab function
    local function AddTab(PageName, IconId)
        -- Tab button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = PageName .. "_TabBtn"
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
        TabButton.BackgroundTransparency = 0.5
        TabButton.Size = UDim2.new(0, 100, 0, 30)
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextSize = 14
        TabButton.Text = PageName
        TabButton.TextColor3 = getgenv().UIColor["Text Color"]
        TabButton.AutoButtonColor = false
        TabButton.BorderSizePixel = 0
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 8)
        BtnCorner.Parent = TabButton

        -- Page frame
        local Page = Instance.new("ScrollingFrame")
        Page.Name = PageName .. "_Page"
        Page.Parent = PageContainer
        Page.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
        Page.BackgroundTransparency = 0.2
        Page.Size = UDim2.new(1, -10, 1, -10)
        Page.Position = UDim2.new(0, 5, 0, 5)
        Page.BorderSizePixel = 0
        Page.ScrollBarThickness = 4
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.Visible = false
        Page.ScrollingEnabled = true
        Page.VerticalScrollBarInset = Enum.ScrollBarInset.Always

        local PageList = Instance.new("UIListLayout")
        PageList.Name = "PageList"
        PageList.Parent = Page
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 8)
        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
        end)

        -- Tab click handler
        TabButton.MouseButton1Click:Connect(function()
            for _, p in pairs(PageContainer:GetChildren()) do
                if p:IsA("ScrollingFrame") then 
                    p.Visible = false 
                end
            end
            Page.Visible = true
            
            for _, btn in pairs(TabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    TweenService:Create(btn, TweenInfo.new(0.2), { 
                        BackgroundTransparency = 0.5,
                        TextColor3 = getgenv().UIColor["Text Color"]
                    }):Play()
                end
            end
            TweenService:Create(TabButton, TweenInfo.new(0.2), { 
                BackgroundTransparency = 0.2,
                TextColor3 = getgenv().UIColor["Title Text Color"]
            }):Play()
        end)

        -- Select first tab
        if FirstTab then
            FirstTab = false
            Page.Visible = true
            TweenService:Create(TabButton, TweenInfo.new(0), { 
                BackgroundTransparency = 0.2,
                TextColor3 = getgenv().UIColor["Title Text Color"]
            }):Play()
        end

        -- ============== PAGE FUNCTIONS ==============
        local pageFunction = {}

        function pageFunction:AddSection(SectionName, Toggleable)
            local Section = Instance.new("Frame")
            Section.Name = SectionName .. "_Section"
            Section.Parent = Page
            Section.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
            Section.BackgroundTransparency = 0.3
            Section.Size = UDim2.new(1, 0, 0, 30)
            Section.AutomaticSize = Enum.AutomaticSize.Y
            Section.BorderSizePixel = 0
            
            local SecCorner = Instance.new("UICorner")
            SecCorner.CornerRadius = UDim.new(0, 8)
            SecCorner.Parent = Section

            -- Section title
            local SecTitle = Instance.new("TextLabel")
            SecTitle.Name = "Title"
            SecTitle.Parent = Section
            SecTitle.BackgroundTransparency = 1
            SecTitle.Position = UDim2.new(0, 10, 0, 5)
            SecTitle.Size = UDim2.new(1, -20, 0, 20)
            SecTitle.Font = Enum.Font.GothamBold
            SecTitle.TextSize = 14
            SecTitle.TextColor3 = getgenv().UIColor["Section Text Color"]
            SecTitle.Text = SectionName
            SecTitle.TextXAlignment = Enum.TextXAlignment.Left

            local SecList = Instance.new("UIListLayout")
            SecList.Name = "SecList"
            SecList.Parent = Section
            SecList.SortOrder = Enum.SortOrder.LayoutOrder
            SecList.Padding = UDim.new(0, 5)
            SecList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Section.Size = UDim2.new(1, 0, 0, SecList.AbsoluteContentSize.Y + 35)
            end)

            local sectionFunction = {}

            function sectionFunction:AddToggle(idk, Setting)
                local Title = tostring(Setting.Text or Setting.Title) or ""
                local Desc = Setting.Desc or Setting.Description
                local Default = Setting.Default or false
                local Callback = Setting.Callback

                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = Title .. "_Toggle"
                ToggleFrame.Parent = Section
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
                ToggleFrame.BorderSizePixel = 0

                -- Toggle background
                local ToggleBg = Instance.new("Frame")
                ToggleBg.Name = "ToggleBg"
                ToggleBg.Parent = ToggleFrame
                ToggleBg.Position = UDim2.new(0, 10, 0.5, -10)
                ToggleBg.Size = UDim2.new(0, 40, 0, 20)
                ToggleBg.BackgroundColor3 = Default and getgenv().UIColor["Toggle Checked Color"] or getgenv().UIColor["Toggle Border Color"]
                ToggleBg.BorderSizePixel = 0
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 10)
                ToggleCorner.Parent = ToggleBg

                -- Check circle
                local Check = Instance.new("Frame")
                Check.Name = "Check"
                Check.Parent = ToggleBg
                Check.Size = UDim2.new(0, 16, 0, 16)
                Check.Position = Default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Check.BorderSizePixel = 0
                
                local CheckCorner = Instance.new("UICorner")
                CheckCorner.CornerRadius = UDim.new(1, 0)
                CheckCorner.Parent = Check

                -- Title
                local ToggleTitle = Instance.new("TextLabel")
                ToggleTitle.Name = "Title"
                ToggleTitle.Parent = ToggleFrame
                ToggleTitle.BackgroundTransparency = 1
                ToggleTitle.Position = UDim2.new(0, 60, 0, 0)
                ToggleTitle.Size = UDim2.new(1, -60, 1, 0)
                ToggleTitle.Font = Enum.Font.GothamMedium
                ToggleTitle.TextSize = 14
                ToggleTitle.TextColor3 = getgenv().UIColor["Text Color"]
                ToggleTitle.Text = Title
                ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

                -- Button
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Name = "Button"
                ToggleButton.Parent = ToggleFrame
                ToggleButton.BackgroundTransparency = 1
                ToggleButton.Size = UDim2.new(1, 0, 1, 0)
                ToggleButton.Text = ""
                ToggleButton.BorderSizePixel = 0

                local function setState(on)
                    ToggleBg.BackgroundColor3 = on and getgenv().UIColor["Toggle Checked Color"] or getgenv().UIColor["Toggle Border Color"]
                    local targetPos = on and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    TweenService:Create(Check, TweenInfo.new(0.2), { Position = targetPos }):Play()
                end

                ToggleButton.MouseButton1Click:Connect(function()
                    Default = not Default
                    setState(Default)
                    if Callback then
                        pcall(Callback, Default)
                    end
                end)

                table.insert(getgenv().AllControls, {
                    Name = Title,
                    Section = Section,
                    Element = ToggleFrame,
                    SectionName = SectionName,
                    TabName = PageName,
                    TabButton = TabButton
                })

                return {
                    SetStage = function(v) 
                        if v ~= Default then
                            Default = v
                            setState(v)
                            if Callback then Callback(v) end
                        end
                    end
                }
            end

            function sectionFunction:AddButton(Setting, Callback)
                local Title = Setting.Title or Setting.Text or "Button"
                local Desc = Setting.Desc or Setting.Description
                local Callback = Setting.Callback or Setting.Func or function() end

                local ButtonFrame = Instance.new("Frame")
                ButtonFrame.Name = Title .. "_Button"
                ButtonFrame.Parent = Section
                ButtonFrame.BackgroundTransparency = 1
                ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
                ButtonFrame.BorderSizePixel = 0

                local Btn = Instance.new("TextButton")
                Btn.Name = "Btn"
                Btn.Parent = ButtonFrame
                Btn.AnchorPoint = Vector2.new(0.5, 0.5)
                Btn.Position = UDim2.new(0.5, 0, 0.5, 0)
                Btn.Size = UDim2.new(1, -20, 0, 30)
                Btn.BackgroundColor3 = getgenv().UIColor["Button Color"]
                Btn.TextColor3 = getgenv().UIColor["GUI Text Color"]
                Btn.Font = Enum.Font.GothamBold
                Btn.TextSize = 14
                Btn.Text = Title
                Btn.AutoButtonColor = false
                Btn.BorderSizePixel = 0
                
                local BtnCorner = Instance.new("UICorner")
                BtnCorner.CornerRadius = UDim.new(0, 8)
                BtnCorner.Parent = Btn

                Btn.MouseEnter:Connect(function()
                    TweenService:Create(Btn, TweenInfo.new(0.2), { 
                        BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    }):Play()
                end)
                
                Btn.MouseLeave:Connect(function()
                    TweenService:Create(Btn, TweenInfo.new(0.2), { 
                        BackgroundColor3 = getgenv().UIColor["Button Color"]
                    }):Play()
                end)

                Btn.MouseButton1Click:Connect(function()
                    -- Ripple effect
                    local ripple = Instance.new("Frame")
                    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
                    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
                    ripple.Size = UDim2.new(0, 0, 0, 0)
                    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ripple.BackgroundTransparency = 0.6
                    ripple.ZIndex = 20
                    ripple.Parent = Btn
                    
                    local rippleCorner = Instance.new("UICorner")
                    rippleCorner.CornerRadius = BtnCorner.CornerRadius
                    rippleCorner.Parent = ripple
                    
                    TweenService:Create(ripple, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.new(2, 0, 2, 0),
                        BackgroundTransparency = 1
                    }):Play()
                    
                    spawn(function()
                        wait(0.35)
                        ripple:Destroy()
                    end)
                    
                    Callback()
                end)

                table.insert(getgenv().AllControls, {
                    Name = Title,
                    Section = Section,
                    Element = ButtonFrame,
                    SectionName = SectionName,
                    TabName = PageName,
                    TabButton = TabButton
                })

                return { SetTitle = function(t) Btn.Text = t end }
            end

            function sectionFunction:AddLabel(text)
                local LabelFrame = Instance.new("Frame")
                LabelFrame.Name = "LabelFrame"
                LabelFrame.Parent = Section
                LabelFrame.BackgroundTransparency = 1
                LabelFrame.Size = UDim2.new(1, 0, 0, 25)
                LabelFrame.BorderSizePixel = 0

                local Label = Instance.new("TextLabel")
                Label.Name = "Label"
                Label.Parent = LabelFrame
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 10, 0, 0)
                Label.Size = UDim2.new(1, -20, 1, 0)
                Label.Font = Enum.Font.GothamMedium
                Label.TextSize = 14
                Label.TextColor3 = getgenv().UIColor["Text Color"]
                Label.Text = text
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextWrapped = true

                table.insert(getgenv().AllControls, {
                    Name = text,
                    Section = Section,
                    Element = LabelFrame,
                    SectionName = SectionName,
                    TabName = PageName,
                    TabButton = TabButton
                })

                return {
                    SetText = function(t) Label.Text = t end,
                    SetColor = function(c) Label.TextColor3 = c end
                }
            end

            function sectionFunction:AddSeperator(text)
                local Sep = Instance.new("Frame")
                Sep.Name = "Separator"
                Sep.Parent = Section
                Sep.BackgroundTransparency = 1
                Sep.Size = UDim2.new(1, 0, 0, 20)
                Sep.BorderSizePixel = 0

                if text and text ~= "" then
                    local Label = Instance.new("TextLabel")
                    Label.Parent = Sep
                    Label.BackgroundTransparency = 1
                    Label.AnchorPoint = Vector2.new(0.5, 0.5)
                    Label.Position = UDim2.new(0.5, 0, 0.5, 0)
                    Label.Size = UDim2.new(0, 0, 1, 0)
                    Label.AutomaticSize = Enum.AutomaticSize.X
                    Label.Font = Enum.Font.GothamBold
                    Label.TextSize = 12
                    Label.TextColor3 = getgenv().UIColor["Section Text Color"]
                    Label.Text = text
                else
                    local Line = Instance.new("Frame")
                    Line.Parent = Sep
                    Line.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
                    Line.BorderSizePixel = 0
                    Line.Position = UDim2.new(0, 0, 0.5, 0)
                    Line.Size = UDim2.new(1, 0, 0, 1)
                    Line.BackgroundTransparency = 0.5
                end

                table.insert(getgenv().AllControls, {
                    Name = text or "Separator",
                    Section = Section,
                    Element = Sep,
                    SectionName = SectionName,
                    TabName = PageName,
                    TabButton = TabButton
                })
            end

            return sectionFunction
        end

        table.insert(TabPages, { Button = TabButton, Page = Page, Func = pageFunction })
        return pageFunction
    end

    return { AddTab = AddTab }
end

-- ================== DESTROY ==================
Library.DestroyUI = function()
    if game.CoreGui:FindFirstChild("HDanh Hub GUI") then
        for i, v in ipairs(game.CoreGui:GetChildren()) do
            if string.find(v.Name, "HDanh Hub") then
                v:Destroy()
            end
        end
    end
    
    local toggleGui = game.CoreGui:FindFirstChild("BananaToggleGui")
    if toggleGui then
        toggleGui:Destroy()
    end
    
    getgenv().Nousigi = false
    getgenv().UIToggled = false
    getgenv().AllControls = {}
    getgenv().ReadyForGuiLoaded = false
end

return Library