--[[
    ██╗   ██╗ ██████╗ ██╗██████╗      ██████╗██████╗ ██╗   ██╗███████╗████████╗ █████╗ ██╗
    ██║   ██║██╔═══██╗██║██╔══██╗    ██╔════╝██╔══██╗╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔══██╗██║
    ██║   ██║██║   ██║██║██║  ██║    ██║     ██████╔╝ ╚████╔╝ ███████╗   ██║   ███████║██║
    ╚██╗ ██╔╝██║   ██║██║██║  ██║    ██║     ██╔══██╗  ╚██╔╝  ╚════██║   ██║   ██╔══██║██║
     ╚████╔╝ ╚██████╔╝██║██████╔╝    ╚██████╗██║  ██║   ██║   ███████║   ██║   ██║  ██║███████╗
      ╚═══╝   ╚═════╝ ╚═╝╚═════╝      ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝

    VOID CRYSTAL HUB v2.0
    Author  : HDanh Tool
    Game    : Blox Fruits
    Theme   : Void Crystal — Hologram Neon
    Rewrite : Banana-style Library pattern (CreateWindow → AddTab → AddSection → AddToggle/AddButton/AddSlider)
]]

-- ═══════════════════════════════════════════════════════════
--  GUARD — chống load trùng
-- ═══════════════════════════════════════════════════════════
if getgenv().VoidCrystalLoaded then
    local cg = game:GetService("CoreGui")
    for _, v in ipairs(cg:GetChildren()) do
        if string.find(tostring(v.Name), "VoidCrystal") then
            v:Destroy()
        end
    end
end
getgenv().VoidCrystalLoaded = true
getgenv().VoidAllControls   = {}
getgenv().VoidUIToggled     = false

-- ═══════════════════════════════════════════════════════════
--  SERVICES
-- ═══════════════════════════════════════════════════════════
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui          = game:GetService("CoreGui")
local LocalPlayer      = Players.LocalPlayer

local IsMobile = LocalPlayer.PlayerGui:FindFirstChild("TouchGui") ~= nil

-- ═══════════════════════════════════════════════════════════
--  THEME — Void Crystal colors (dùng như UIColor của Banana)
-- ═══════════════════════════════════════════════════════════
local UIColor = {
    ["BG Dark"]              = Color3.fromRGB(6,   4,  18),
    ["BG Mid"]               = Color3.fromRGB(12,  8,  32),
    ["BG Panel"]             = Color3.fromRGB(18, 12,  44),
    ["BG Section"]           = Color3.fromRGB(14, 10,  36),
    ["Accent1"]              = Color3.fromRGB(120,  60, 255),
    ["Accent2"]              = Color3.fromRGB(0,   220, 255),
    ["AccentGold"]           = Color3.fromRGB(255, 210,  60),
    ["Text Main"]            = Color3.fromRGB(230, 220, 255),
    ["Text Dim"]             = Color3.fromRGB(130, 120, 170),
    ["Text Accent"]          = Color3.fromRGB(160, 100, 255),
    ["Border"]               = Color3.fromRGB(80,  50, 160),
    ["Green"]                = Color3.fromRGB(60,  255, 140),
    ["Red"]                  = Color3.fromRGB(255,  70,  90),
    ["Toggle ON"]            = Color3.fromRGB(120,  60, 255),
    ["Toggle OFF"]           = Color3.fromRGB(40,  30,  70),
    ["Slider Fill"]          = Color3.fromRGB(120,  60, 255),
    ["Slider Track"]         = Color3.fromRGB(40,  30,  70),
    ["Button BG"]            = Color3.fromRGB(120,  60, 255),
    ["Tab Active"]           = Color3.fromRGB(120,  60, 255),
    ["Tab Inactive"]         = Color3.fromRGB(18,  12,  42),
    ["Tween Speed 1"]        = IsMobile and 0 or 0.18,
    ["Tween Speed 2"]        = IsMobile and 0 or 0.30,
    ["Tween Speed 3"]        = IsMobile and 0 or 0.10,
}
getgenv().VoidUIColor = UIColor

-- ═══════════════════════════════════════════════════════════
--  WINDOW CONFIG
-- ═══════════════════════════════════════════════════════════
local WIN_W     = 620
local WIN_H     = 420
local SIDEBAR_W = 136
local HEADER_H  = 48
local STATUS_H  = 26

-- ═══════════════════════════════════════════════════════════
--  LIBRARY TABLE
-- ═══════════════════════════════════════════════════════════
local Library          = {}
local Library_Internal = {}

-- ═══════════════════════════════════════════════════════════
--  UTILITIES (nội bộ)
-- ═══════════════════════════════════════════════════════════
local function Tween(obj, props, spd, style, dir)
    style = style or Enum.EasingStyle.Quart
    dir   = dir   or Enum.EasingDirection.Out
    TweenService:Create(obj, TweenInfo.new(spd or UIColor["Tween Speed 1"], style, dir), props):Play()
end

local function New(class, props, children)
    local o = Instance.new(class)
    for k, v in pairs(props or {}) do o[k] = v end
    for _, c in ipairs(children or {}) do c.Parent = o end
    return o
end

local function Corner(parent, r)
    return New("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = parent })
end

local function Stroke(parent, color, thick)
    return New("UIStroke", {
        Color = color or UIColor["Border"],
        Thickness = thick or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
end

local function RoundFrame(parent, size, pos, r, color, name)
    local f = New("Frame", {
        Name = name or "RoundFrame",
        Size = size, Position = pos,
        BackgroundColor3 = color,
        BorderSizePixel  = 0,
        Parent = parent,
    })
    Corner(f, r)
    return f
end

local function Lbl(parent, text, size, pos, color, tsize, font, xalign, name)
    return New("TextLabel", {
        Name                   = name or "Lbl",
        Text                   = text,
        Size                   = size, Position = pos,
        BackgroundTransparency = 1,
        TextColor3             = color or UIColor["Text Main"],
        TextSize               = tsize  or 13,
        Font                   = font   or Enum.Font.GothamBold,
        TextXAlignment         = xalign or Enum.TextXAlignment.Left,
        Parent                 = parent,
    })
end

local function MakeBtn(parent, size, pos, r, color, name)
    local b = New("TextButton", {
        Name             = name or "Btn",
        Size             = size, Position = pos,
        BackgroundColor3 = color,
        BorderSizePixel  = 0,
        Text             = "",
        AutoButtonColor  = false,
        Parent           = parent,
    })
    Corner(b, r)
    return b
end

-- Ripple effect (giống Banana)
local function Ripple(parent, x, y)
    local rip = New("Frame", {
        AnchorPoint          = Vector2.new(0.5, 0.5),
        Position             = UDim2.new(0, x - parent.AbsolutePosition.X, 0, y - parent.AbsolutePosition.Y),
        Size                 = UDim2.new(0, 0, 0, 0),
        BackgroundColor3     = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.6,
        ZIndex               = 20,
        Parent               = parent,
    })
    Corner(rip, 100)
    local t = TweenService:Create(rip, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size                 = UDim2.new(2, 0, 2, 0),
        BackgroundTransparency = 1,
    })
    t:Play()
    t.Completed:Connect(function() rip:Destroy() end)
end

-- ═══════════════════════════════════════════════════════════
--  SCREEN GUIs
-- ═══════════════════════════════════════════════════════════
Library_Internal.MainGui = New("ScreenGui", {
    Name           = "VoidCrystalHub",
    ResetOnSpawn   = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder   = 999,
    Enabled        = false,
    Parent         = CoreGui,
})

Library_Internal.NotiGui = New("ScreenGui", {
    Name           = "VoidCrystalNoti",
    ResetOnSpawn   = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder   = 1000,
    Parent         = CoreGui,
})

Library_Internal.ToggleGui = New("ScreenGui", {
    Name           = "VoidCrystalToggle",
    ResetOnSpawn   = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder   = 1001,
    Parent         = CoreGui,
})

-- Ready flag (giống Banana ReadyForGuiLoaded)
getgenv().VoidReadyForGuiLoaded = false
spawn(function()
    repeat task.wait() until getgenv().VoidReadyForGuiLoaded
    if getgenv().VoidUIToggled then
        Library_Internal.MainGui.Enabled = true
    end
end)

-- ═══════════════════════════════════════════════════════════
--  NOTIFICATION SYSTEM (giữ kiểu Banana)
-- ═══════════════════════════════════════════════════════════
local NotiContainer = New("Frame", {
    Name                   = "NotiContainer",
    Size                   = UDim2.new(0, 270, 1, 0),
    Position               = UDim2.new(1, -280, 0, 0),
    BackgroundTransparency = 1,
    Parent                 = Library_Internal.NotiGui,
})
New("UIListLayout", {
    SortOrder         = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Bottom,
    Padding           = UDim.new(0, 5),
    Parent            = NotiContainer,
})
New("UIPadding", { PaddingBottom = UDim.new(0, 10), Parent = NotiContainer })

local function libCreateNoti(setting)
    local title    = setting.Title or "VOID CRYSTAL"
    local desc     = setting.Description or setting.Desc or setting.Content or ""
    local duration = setting.Duration or setting.Timeshow or 4
    local ntype    = setting.Type or "info"

    local col  = ntype == "success" and UIColor["Green"]
              or ntype == "error"   and UIColor["Red"]
              or ntype == "warn"    and UIColor["AccentGold"]
              or UIColor["Accent2"]
    local icon = ntype == "success" and "✔"
              or ntype == "error"   and "✕"
              or ntype == "warn"    and "⚠" or "ℹ"

    local card = RoundFrame(NotiContainer,
        UDim2.new(1, 0, 0, 58), UDim2.new(1, 0, 0, 0), 7,
        Color3.fromRGB(10, 8, 26), "NotiCard")
    Stroke(card, col, 1.5)
    card.BackgroundTransparency = 0.1

    local bar = New("Frame", {
        Size = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = col,
        BorderSizePixel  = 0,
        Parent = card,
    })
    Corner(bar, 3)

    Lbl(card, icon,  UDim2.new(0,18,0,18), UDim2.new(0, 8,0, 6),  col, 14, Enum.Font.GothamBold, Enum.TextXAlignment.Center)
    Lbl(card, title, UDim2.new(1,-44,0,16), UDim2.new(0,30,0, 6),  col, 12, Enum.Font.GothamBold)
    Lbl(card, desc,  UDim2.new(1,-44,0,26), UDim2.new(0,30,0,26), UIColor["Text Dim"], 10, Enum.Font.Gotham)

    -- Close button
    local closeBtn = MakeBtn(card, UDim2.new(0,18,0,18), UDim2.new(1,-22,0,4), 4,
        Color3.fromRGB(30,10,50), "NotiClose")
    Lbl(closeBtn, "✕", UDim2.new(1,0,1,0), UDim2.new(0,0,0,0),
        UIColor["Text Dim"], 10, Enum.Font.GothamBold, Enum.TextXAlignment.Center)

    local function removeNoti()
        Tween(card, { Position = UDim2.new(1, 10, 0, 0), BackgroundTransparency = 1 }, UIColor["Tween Speed 1"])
        task.delay(0.35, function() card:Destroy() end)
    end

    closeBtn.MouseButton1Click:Connect(removeNoti)

    card.Position = UDim2.new(1, 0, 0, 0)
    Tween(card, { Position = UDim2.new(0, 0, 0, 0) }, UIColor["Tween Speed 2"],
        Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    task.delay(duration, removeNoti)
end

function Library:Notify(setting)
    local ok, err = pcall(libCreateNoti, setting)
    if err then warn("[VoidCrystal Notify]", err) end
end

-- ═══════════════════════════════════════════════════════════
--  TOGGLE UI (giống Library.ToggleUI của Banana)
-- ═══════════════════════════════════════════════════════════
Library.ToggleUI = function()
    getgenv().VoidUIToggled = not getgenv().VoidUIToggled
    Library_Internal.MainGui.Enabled = getgenv().VoidUIToggled
end

Library.DestroyUI = function()
    for _, v in ipairs(CoreGui:GetChildren()) do
        if string.find(tostring(v.Name), "VoidCrystal") then v:Destroy() end
    end
    getgenv().VoidCrystalLoaded     = false
    getgenv().VoidUIToggled         = false
    getgenv().VoidAllControls       = {}
    getgenv().VoidReadyForGuiLoaded = false
end

-- ═══════════════════════════════════════════════════════════
--  FLOATING LOGO BUTTON (giống mainButton của Banana)
-- ═══════════════════════════════════════════════════════════
local logoIsToggled = true
local logoDragging  = false
local logoDragStart, logoStartPos
local CLICK_DIST = 6

local logoBtn = New("TextButton", {
    Name             = "VoidLogoBtn",
    Size             = UDim2.new(0, 52, 0, 52),
    Position         = UDim2.new(0, 14, 0.5, -26),
    BackgroundColor3 = UIColor["BG Panel"],
    BorderSizePixel  = 0,
    Text             = "",
    AutoButtonColor  = false,
    ZIndex           = 10,
    Parent           = Library_Internal.ToggleGui,
})
Corner(logoBtn, 100)

local logoStroke = Stroke(logoBtn, UIColor["Accent1"], 2)

New("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 14, 70)),
        ColorSequenceKeypoint.new(1, UIColor["BG Dark"]),
    }),
    Rotation = 135,
    Parent   = logoBtn,
})

local logoIcon = New("TextLabel", {
    Text                   = "◈",
    Size                   = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    TextColor3             = UIColor["Accent2"],
    TextSize               = 26,
    Font                   = Enum.Font.GothamBold,
    TextXAlignment         = Enum.TextXAlignment.Center,
    ZIndex                 = 11,
    Parent                 = logoBtn,
})

-- pulse animation logo
spawn(function()
    while logoBtn and logoBtn.Parent do
        Tween(logoStroke, { Thickness = 3 }, 1.0, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        Tween(logoIcon, { TextColor3 = UIColor["Accent1"] }, 1.0, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        task.wait(1.0)
        Tween(logoStroke, { Thickness = 1.5 }, 1.0, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        Tween(logoIcon, { TextColor3 = UIColor["Accent2"] }, 1.0, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        task.wait(1.0)
    end
end)

-- hover / press (giống Banana)
logoBtn.MouseEnter:Connect(function()
    Tween(logoBtn, { Size = UDim2.new(0, 56, 0, 56) }, 0.15, Enum.EasingStyle.Quad)
    Tween(logoStroke, { Transparency = 0.2 }, 0.15, Enum.EasingStyle.Quad)
end)
logoBtn.MouseLeave:Connect(function()
    Tween(logoBtn, { Size = UDim2.new(0, 52, 0, 52) }, 0.15, Enum.EasingStyle.Quad)
    Tween(logoStroke, { Transparency = 0.5 }, 0.15, Enum.EasingStyle.Quad)
end)
logoBtn.MouseButton1Down:Connect(function()
    Tween(logoBtn, { Size = UDim2.new(0, 48, 0, 48) }, 0.1, Enum.EasingStyle.Quad)
end)

-- drag logo (giống Banana mainButton drag)
logoBtn.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1
    or inp.UserInputType == Enum.UserInputType.Touch then
        logoDragStart = inp.Position
        logoStartPos  = logoBtn.Position
        logoDragging  = true
    end
end)
UserInputService.InputChanged:Connect(function(inp)
    if logoDragging and (
        inp.UserInputType == Enum.UserInputType.MouseMovement
     or inp.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = inp.Position - logoDragStart
        if math.abs(delta.X) > CLICK_DIST or math.abs(delta.Y) > CLICK_DIST then
            logoBtn.Position = UDim2.new(
                logoStartPos.X.Scale, logoStartPos.X.Offset + delta.X,
                logoStartPos.Y.Scale, logoStartPos.Y.Offset + delta.Y
            )
        end
    end
end)
UserInputService.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1
    or inp.UserInputType == Enum.UserInputType.Touch then
        if logoDragging then
            local delta = inp.Position - (logoDragStart or inp.Position)
            if math.abs(delta.X) < CLICK_DIST and math.abs(delta.Y) < CLICK_DIST then
                Library.ToggleUI()
                logoIsToggled = getgenv().VoidUIToggled
                local col = logoIsToggled and UIColor["Accent2"] or UIColor["AccentGold"]
                Tween(logoIcon, { TextColor3 = col }, UIColor["Tween Speed 1"])
            end
        end
        logoDragging = false
        Tween(logoBtn, { Size = UDim2.new(0, 52, 0, 52) }, 0.1, Enum.EasingStyle.Quad)
    end
end)

-- ═══════════════════════════════════════════════════════════
--  FPS STATE (global, diễn giải trong RunService)
-- ═══════════════════════════════════════════════════════════
Library_Internal.FPSState = {
    Enabled    = false,
    FrameCount = 0,
    Display    = 0,
    LastTime   = tick(),
}

-- ═══════════════════════════════════════════════════════════
--  CREATE WINDOW  ← entry point giống Library:CreateWindow()
-- ═══════════════════════════════════════════════════════════
function Library:CreateWindow(setting)
    local hubName  = setting.Title   or "VOID CRYSTAL"
    local subTitle = setting.Desc    or setting.Subtitle or "Blox Fruits Script Hub"
    local version  = setting.Version or "v2.0"
    local toggleKey = setting.ToggleKey or Enum.KeyCode.RightControl

    -- ───────────────────────────────────────────────────────
    --  MAIN WINDOW FRAME
    -- ───────────────────────────────────────────────────────
    local MainWindow = RoundFrame(
        Library_Internal.MainGui,
        UDim2.new(0, WIN_W, 0, WIN_H),
        UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2),
        14, UIColor["BG Dark"], "MainWindow"
    )
    Stroke(MainWindow, UIColor["Accent1"], 1.5)
    New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   UIColor["BG Dark"]),
            ColorSequenceKeypoint.new(0.5, UIColor["BG Mid"]),
            ColorSequenceKeypoint.new(1,   Color3.fromRGB(8, 4, 24)),
        }),
        Rotation = 135,
        Parent   = MainWindow,
    })

    -- Glow pulse (giống Banana border pulse)
    local glowStroke = New("UIStroke", {
        Color           = UIColor["Accent1"],
        Thickness       = 2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent          = MainWindow,
    })
    spawn(function()
        while MainWindow and MainWindow.Parent do
            Tween(glowStroke, { Thickness = 3 }, 1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(1.2)
            Tween(glowStroke, { Thickness = 1.5 }, 1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(1.2)
        end
    end)

    -- ───────────────────────────────────────────────────────
    --  HEADER BAR
    -- ───────────────────────────────────────────────────────
    local Header = New("TextButton", {
        Name             = "Header",
        Size             = UDim2.new(1, 0, 0, HEADER_H),
        Position         = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = UIColor["BG Panel"],
        BorderSizePixel  = 0,
        Text             = "",
        AutoButtonColor  = false,
        ClipsDescendants = false,
        Parent           = MainWindow,
    })
    Corner(Header, 14)
    -- patch bo thẳng góc dưới header
    New("Frame", {
        Size             = UDim2.new(1, 0, 0.5, 0),
        Position         = UDim2.new(0, 0, 0.5, 0),
        BackgroundColor3 = UIColor["BG Panel"],
        BorderSizePixel  = 0,
        Parent           = Header,
    })
    New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 14, 70)),
            ColorSequenceKeypoint.new(1, UIColor["BG Panel"]),
        }),
        Parent = Header,
    })

    -- logo icon
    Lbl(Header, "◈",
        UDim2.new(0,34,0,34), UDim2.new(0,10,0,7),
        UIColor["Accent2"], 26, Enum.Font.GothamBold, Enum.TextXAlignment.Center)
    -- hub name
    Lbl(Header, hubName,
        UDim2.new(0,200,0,20), UDim2.new(0,48,0,7),
        UIColor["Text Main"], 16, Enum.Font.GothamBold)
    -- subtitle + version
    Lbl(Header, subTitle .. "  " .. version,
        UDim2.new(0,260,0,13), UDim2.new(0,48,0,28),
        UIColor["Text Dim"], 10, Enum.Font.Gotham)

    -- FPS badge
    local FPSBadge = RoundFrame(Header,
        UDim2.new(0,68,0,24), UDim2.new(1,-148,0.5,-12),
        6, Color3.fromRGB(10,6,30), "FPSBadge")
    Stroke(FPSBadge, UIColor["Accent2"], 1)
    local FPSBadgeLbl = Lbl(FPSBadge, "FPS: 0",
        UDim2.new(1,0,1,0), UDim2.new(0,0,0,0),
        UIColor["Accent2"], 11, Enum.Font.GothamBold, Enum.TextXAlignment.Center)

    -- Hide/Close buttons
    local function HideMenu()
        getgenv().VoidUIToggled = false
        Tween(MainWindow, { Size = UDim2.new(0, WIN_W, 0, 0) }, UIColor["Tween Speed 2"])
        task.delay(UIColor["Tween Speed 2"] + 0.02, function()
            Library_Internal.MainGui.Enabled = false
            MainWindow.Size = UDim2.new(0, WIN_W, 0, WIN_H)
        end)
        Tween(logoIcon, { TextColor3 = UIColor["AccentGold"] }, UIColor["Tween Speed 1"])
    end

    local function OpenMenu()
        getgenv().VoidUIToggled = true
        Library_Internal.MainGui.Enabled = true
        MainWindow.Size = UDim2.new(0, WIN_W, 0, 0)
        Tween(MainWindow, { Size = UDim2.new(0, WIN_W, 0, WIN_H) }, UIColor["Tween Speed 2"],
            Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        Tween(logoIcon, { TextColor3 = UIColor["Accent2"] }, UIColor["Tween Speed 1"])
    end

    -- patch logoBtn click gọi đúng Open/HideMenu của window này
    -- (ghi đè InputEnded đã connect ở trên bằng cách dùng flag)
    Library_Internal.OpenMenu  = OpenMenu
    Library_Internal.HideMenu  = HideMenu

    local MinBtn = MakeBtn(Header,
        UDim2.new(0,26,0,26), UDim2.new(1,-68,0.5,-13),
        6, Color3.fromRGB(30,90,180), "MinBtn")
    Lbl(MinBtn,"—",UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),
        Color3.fromRGB(255,255,255),13,Enum.Font.GothamBold,Enum.TextXAlignment.Center)
    MinBtn.MouseButton1Click:Connect(HideMenu)

    local CloseBtn = MakeBtn(Header,
        UDim2.new(0,26,0,26), UDim2.new(1,-36,0.5,-13),
        6, Color3.fromRGB(180,30,60), "CloseBtn")
    Lbl(CloseBtn,"✕",UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),
        Color3.fromRGB(255,255,255),13,Enum.Font.GothamBold,Enum.TextXAlignment.Center)
    CloseBtn.MouseButton1Click:Connect(HideMenu)

    -- Hover effects header buttons (giống Banana)
    for _, b in ipairs({ MinBtn, CloseBtn }) do
        local origCol = b.BackgroundColor3
        b.MouseEnter:Connect(function()
            Tween(b, { BackgroundTransparency = 0.3 }, UIColor["Tween Speed 3"])
        end)
        b.MouseLeave:Connect(function()
            Tween(b, { BackgroundTransparency = 0 }, UIColor["Tween Speed 3"])
        end)
    end

    -- Keyboard toggle
    UserInputService.InputBegan:Connect(function(inp, gp)
        if gp then return end
        if inp.KeyCode == toggleKey then
            if getgenv().VoidUIToggled then HideMenu() else OpenMenu() end
        end
    end)

    -- ───────────────────────────────────────────────────────
    --  SIDEBAR
    -- ───────────────────────────────────────────────────────
    local Sidebar = RoundFrame(MainWindow,
        UDim2.new(0, SIDEBAR_W, 1, -(HEADER_H+STATUS_H+4)),
        UDim2.new(0, 6, 0, HEADER_H+4),
        8, UIColor["BG Panel"], "Sidebar")
    Stroke(Sidebar, UIColor["Border"], 1)

    local SideList = New("Frame", {
        Size                 = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent               = Sidebar,
    })
    New("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding   = UDim.new(0, 3),
        Parent    = SideList,
    })
    New("UIPadding", {
        PaddingTop   = UDim.new(0, 6),
        PaddingLeft  = UDim.new(0, 5),
        PaddingRight = UDim.new(0, 5),
        Parent       = SideList,
    })

    -- ───────────────────────────────────────────────────────
    --  CONTENT AREA
    -- ───────────────────────────────────────────────────────
    local ContentArea = New("Frame", {
        Name                 = "ContentArea",
        Size                 = UDim2.new(1, -(SIDEBAR_W+16), 1, -(HEADER_H+STATUS_H+8)),
        Position             = UDim2.new(0, SIDEBAR_W+14, 0, HEADER_H+4),
        BackgroundTransparency = 1,
        ClipsDescendants     = true,
        Parent               = MainWindow,
    })

    -- ───────────────────────────────────────────────────────
    --  STATUS BAR
    -- ───────────────────────────────────────────────────────
    local StatusBar = RoundFrame(MainWindow,
        UDim2.new(1,0,0,STATUS_H), UDim2.new(0,0,1,-STATUS_H),
        8, UIColor["BG Panel"], "StatusBar")
    New("Frame", {
        Size             = UDim2.new(1,0,0.5,0),
        BackgroundColor3 = UIColor["BG Panel"],
        BorderSizePixel  = 0,
        Parent           = StatusBar,
    })
    local statusDot = New("Frame", {
        Size             = UDim2.new(0,7,0,7),
        Position         = UDim2.new(0,9,0.5,-3),
        BackgroundColor3 = UIColor["Green"],
        BorderSizePixel  = 0,
        Parent           = StatusBar,
    })
    Corner(statusDot, 100)
    Lbl(StatusBar,
        "● ONLINE  |  " .. hubName .. "  |  " .. LocalPlayer.Name,
        UDim2.new(0.6,0,1,0), UDim2.new(0,20,0,0),
        UIColor["Text Dim"], 10, Enum.Font.Gotham)
    local timeLbl = Lbl(StatusBar, "",
        UDim2.new(0.4,-8,1,0), UDim2.new(0.6,0,0,0),
        UIColor["Text Dim"], 10, Enum.Font.Gotham, Enum.TextXAlignment.Right, "TimeLbl")

    -- dot pulse
    spawn(function()
        while statusDot and statusDot.Parent do
            Tween(statusDot, { BackgroundTransparency = 0.6 }, 0.6, Enum.EasingStyle.Sine)
            task.wait(0.6)
            Tween(statusDot, { BackgroundTransparency = 0 }, 0.6, Enum.EasingStyle.Sine)
            task.wait(0.6)
        end
    end)
    -- clock
    spawn(function()
        while timeLbl and timeLbl.Parent do
            local t = os.date("*t")
            timeLbl.Text = string.format("🕐 %02d:%02d:%02d", t.hour, t.min, t.sec)
            task.wait(1)
        end
    end)

    -- FPS overlay
    local FPSOvl = RoundFrame(Library_Internal.NotiGui,
        UDim2.new(0,88,0,26), UDim2.new(0,8,0,8),
        6, Color3.fromRGB(6,4,18), "FPSOverlay")
    FPSOvl.BackgroundTransparency = 0.2
    Stroke(FPSOvl, UIColor["Accent2"], 1)
    local FPSOvlLbl = Lbl(FPSOvl, "FPS: 0",
        UDim2.new(1,0,1,0), UDim2.new(0,0,0,0),
        UIColor["Accent2"], 12, Enum.Font.GothamBold, Enum.TextXAlignment.Center)
    FPSOvl.Visible = false

    -- FPS counter (RunService)
    RunService.RenderStepped:Connect(function()
        local s = Library_Internal.FPSState
        s.FrameCount = s.FrameCount + 1
        local now = tick()
        if now - s.LastTime >= 0.5 then
            s.Display    = math.floor(s.FrameCount / (now - s.LastTime))
            s.FrameCount = 0
            s.LastTime   = now
            local fps = s.Display
            local col = fps >= 55 and UIColor["Green"]
                     or fps >= 30 and UIColor["AccentGold"]
                     or UIColor["Red"]
            FPSBadgeLbl.Text       = "FPS: " .. fps
            FPSBadgeLbl.TextColor3 = col
            FPSOvlLbl.Text         = "⚡ " .. fps .. " FPS"
            FPSOvlLbl.TextColor3   = col
        end
        FPSOvl.Visible = Library_Internal.FPSState.Enabled
    end)

    -- ───────────────────────────────────────────────────────
    --  TAB STATE
    -- ───────────────────────────────────────────────────────
    local TabButtons  = {}
    local TabPages    = {}
    local ActiveTab   = nil
    local LayoutOrder = 0

    local function SwitchTab(name)
        if ActiveTab == name then return end
        ActiveTab = name
        for tname, btn in pairs(TabButtons) do
            local isActive = (tname == name)
            local tabDef   = btn._tabDef
            Tween(btn, {
                BackgroundColor3     = isActive and tabDef.Color or UIColor["Tab Inactive"],
            }, UIColor["Tween Speed 1"])
            local lbl = btn:FindFirstChildWhichIsA("TextLabel")
            if lbl then
                Tween(lbl, {
                    TextColor3 = isActive and Color3.fromRGB(255,255,255) or UIColor["Text Dim"]
                }, UIColor["Tween Speed 1"])
            end
        end
        for tname, page in pairs(TabPages) do
            page.Visible = (tname == name)
        end
    end

    -- ───────────────────────────────────────────────────────
    --  Main_Function — giống Banana Main_Function
    -- ───────────────────────────────────────────────────────
    local Main_Function = {}
    local firstTab = true

    -- ────────────────────────────────────────────────────
    --  AddTab  (= Banana Main_Function:AddTab)
    -- ────────────────────────────────────────────────────
    function Main_Function:AddTab(tabName, tabColor)
        local tColor = tabColor or UIColor["Accent1"]

        -- tab button
        local btn = New("TextButton", {
            Name             = "Tab_" .. tabName,
            Size             = UDim2.new(1, 0, 0, 32),
            BackgroundColor3 = UIColor["Tab Inactive"],
            BorderSizePixel  = 0,
            Text             = "",
            AutoButtonColor  = false,
            LayoutOrder      = LayoutOrder,
            Parent           = SideList,
        })
        Corner(btn, 6)
        btn._tabDef = { Color = tColor }

        local btnLbl = Lbl(btn, tabName,
            UDim2.new(1,-8,1,0), UDim2.new(0,10,0,0),
            UIColor["Text Dim"], 11, Enum.Font.GothamBold)

        -- hover effect (giống Banana tab hover)
        btn.MouseEnter:Connect(function()
            if ActiveTab ~= tabName then
                Tween(btn, { BackgroundColor3 = Color3.fromRGB(28,18,58) }, UIColor["Tween Speed 3"])
            end
        end)
        btn.MouseLeave:Connect(function()
            if ActiveTab ~= tabName then
                Tween(btn, { BackgroundColor3 = UIColor["Tab Inactive"] }, UIColor["Tween Speed 3"])
            end
        end)

        -- scroll page
        local page = New("ScrollingFrame", {
            Name                   = tabName,
            Size                   = UDim2.new(1,0,1,0),
            Position               = UDim2.new(0,0,0,0),
            BackgroundTransparency = 1,
            ScrollBarThickness     = 3,
            ScrollBarImageColor3   = UIColor["Accent1"],
            BorderSizePixel        = 0,
            CanvasSize             = UDim2.new(0,0,0,0),
            AutomaticCanvasSize    = Enum.AutomaticSize.Y,
            Visible                = false,
            Parent                 = ContentArea,
        })
        New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,4), Parent = page })
        New("UIPadding", {
            PaddingTop   = UDim.new(0,5),
            PaddingLeft  = UDim.new(0,4),
            PaddingRight = UDim.new(0,4),
            Parent       = page,
        })

        TabButtons[tabName] = btn
        TabPages[tabName]   = page
        LayoutOrder         = LayoutOrder + 1

        btn.MouseButton1Click:Connect(function() SwitchTab(tabName) end)

        if firstTab then
            firstTab = false
            task.defer(function() SwitchTab(tabName) end)
        end

        -- ────────────────────────────────────────────────
        --  pageFunction — giống Banana pageFunction
        -- ────────────────────────────────────────────────
        local pageFunction = {}
        local Tab_Name = tabName

        -- ──────────────────────────────────────────────
        --  AddSection  (= Banana pageFunction:AddSection)
        -- ──────────────────────────────────────────────
        function pageFunction:AddSection(sectionName)
            local Sec_Name = sectionName

            -- Section header frame
            local Section = New("Frame", {
                Name             = Sec_Name .. "_Dot",
                Size             = UDim2.new(1,-8,0,30),
                BackgroundColor3 = UIColor["BG Section"],
                BackgroundTransparency = 0.1,
                ClipsDescendants = true,
                Parent           = page,
            })
            Corner(Section, 7)
            Stroke(Section, UIColor["Border"], 1)

            -- Section gradient (giống Banana)
            New("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 14, 70)),
                    ColorSequenceKeypoint.new(1, UIColor["BG Section"]),
                }),
                Rotation = 90,
                Parent   = Section,
            })

            -- Section title bar
            local Topsec = New("Frame", {
                Name             = "Topsec",
                Size             = UDim2.new(1,0,0,28),
                BackgroundColor3 = Color3.fromRGB(20,12,48),
                BackgroundTransparency = 0.3,
                BorderSizePixel  = 0,
                Parent           = Section,
            })

            -- underline accent
            New("Frame", {
                Size             = UDim2.new(1,0,0,1),
                Position         = UDim2.new(0,0,1,-1),
                BackgroundColor3 = UIColor["Accent1"],
                BackgroundTransparency = 0.4,
                BorderSizePixel  = 0,
                Parent           = Topsec,
            })

            Lbl(Topsec, "▸  " .. sectionName,
                UDim2.new(1,-8,1,0), UDim2.new(0,6,0,0),
                UIColor["Text Accent"], 11, Enum.Font.GothamBold)

            -- toggle section open/close
            local secToggleBtn = New("TextButton", {
                Size             = UDim2.new(1,0,0,28),
                BackgroundTransparency = 1,
                Text             = "",
                AutoButtonColor  = false,
                Parent           = Topsec,
            })

            -- content list inside section
            local SectionList = New("Frame", {
                Name                   = "SectionContent",
                Size                   = UDim2.new(1,0,0,0),
                BackgroundTransparency = 1,
                AutomaticSize          = Enum.AutomaticSize.Y,
                ClipsDescendants       = false,
                Parent                 = Section,
            })
            New("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding   = UDim.new(0,2),
                Parent    = SectionList,
            })
            New("UIPadding", {
                PaddingTop    = UDim.new(0,2),
                PaddingBottom = UDim.new(0,4),
                PaddingLeft   = UDim.new(0,4),
                PaddingRight  = UDim.new(0,4),
                Parent        = SectionList,
            })

            -- Auto-size section (giống Banana AutomaticSize section)
            local function RefreshSection()
                local contentH = SectionList:FindFirstChildWhichIsA("UIListLayout")
                if contentH then
                    Section.Size = UDim2.new(1,-8,0, 28 + contentH.AbsoluteContentSize.Y + 8)
                end
            end
            SectionList:GetPropertyChangedSignal("AbsoluteSize"):Connect(RefreshSection)

            -- collapse / expand
            local isOpen = true
            secToggleBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                SectionList.Visible = isOpen
                RefreshSection()
            end)

            -- ──────────────────────────────────────────
            --  sectionFunction (giống Banana sectionFunction)
            -- ──────────────────────────────────────────
            local sectionFunction = {}

            -- ────────────────────────────────────────
            --  AddToggle
            -- ────────────────────────────────────────
            function sectionFunction:AddToggle(setting)
                local Title    = setting.Title or setting.Text or ""
                local Default  = setting.Default or false
                local Callback = setting.Callback or function() end
                local Desc     = setting.Desc or setting.Description

                local rowH = (Desc and Desc ~= "") and 0 or 34

                local ToggleFrame = New("Frame", {
                    Name                   = "ToggleFrame",
                    BackgroundTransparency = 1,
                    AutomaticSize          = (Desc and Desc ~= "") and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
                    Size                   = UDim2.new(1,0,0,rowH),
                    Parent                 = SectionList,
                })

                local RowBG = New("Frame", {
                    Name             = "RowBG",
                    AnchorPoint      = Vector2.new(0.5,0.5),
                    Position         = UDim2.new(0.5,0,0.5,0),
                    BackgroundColor3 = UIColor["BG Panel"],
                    BackgroundTransparency = 0.05,
                    Size             = UDim2.new(1,0,1,0),
                    AutomaticSize    = (Desc and Desc ~= "") and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
                    Parent           = ToggleFrame,
                })
                Corner(RowBG, 7)
                Stroke(RowBG, UIColor["Border"], 1)

                -- title
                local titlePos  = (Desc and Desc ~= "") and UDim2.new(0,8,0,5)  or UDim2.new(0,8,0,0)
                local titleSize = (Desc and Desc ~= "") and UDim2.new(1,-52,0,18) or UDim2.new(1,-52,1,0)
                Lbl(RowBG, Title, titleSize, titlePos, UIColor["Text Main"], 12, Enum.Font.GothamBold)

                -- desc
                if Desc and Desc ~= "" then
                    local descLbl = Lbl(RowBG, Desc,
                        UDim2.new(1,-52,0,0), UDim2.new(0,8,0,24),
                        UIColor["Text Dim"], 9, Enum.Font.Gotham)
                    descLbl.AutomaticSize = Enum.AutomaticSize.Y
                    descLbl.TextWrapped   = true
                    New("UIPadding", {
                        PaddingTop    = UDim.new(0,5),
                        PaddingBottom = UDim.new(0,5),
                        Parent        = RowBG,
                    })
                end

                -- checkbox (giống Banana — dot bên trong border image)
                local Checkbox = New("ImageLabel", {
                    Name                   = "Checkbox",
                    AnchorPoint            = Vector2.new(1,0.5),
                    Position               = UDim2.new(1,-8,0.5,0),
                    Size                   = UDim2.new(0,20,0,20),
                    BackgroundTransparency = 1,
                    Image                  = "rbxassetid://4552505888",
                    ImageColor3            = UIColor["Border"],
                    Parent                 = RowBG,
                })

                local CheckDot = New("Frame", {
                    Name        = "CheckDot",
                    AnchorPoint = Vector2.new(0.5,0.5),
                    Position    = UDim2.new(0.5,0,0.5,0),
                    Size        = UDim2.new(0,0,0,0),
                    BackgroundColor3 = UIColor["Accent1"],
                    Parent      = Checkbox,
                })
                Corner(CheckDot, 100)
                -- gradient dot (giống Banana checkGradient)
                New("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, UIColor["Accent2"]),
                        ColorSequenceKeypoint.new(1, UIColor["Accent1"]),
                    }),
                    Rotation = 135,
                    Parent   = CheckDot,
                })

                -- click overlay button
                local ToggleBtn = New("TextButton", {
                    Name             = "ToggleBtn",
                    Size             = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                    Text             = "",
                    AutoButtonColor  = false,
                    Parent           = RowBG,
                })

                local toggled = Default

                local function ChangeStage(val)
                    local sz  = val and UDim2.new(0.6,0,0.6,0) or UDim2.new(0,0,0,0)
                    Tween(CheckDot, { Size = sz }, UIColor["Tween Speed 1"])
                    Tween(Checkbox, {
                        ImageColor3 = val and UIColor["Accent1"] or UIColor["Border"]
                    }, UIColor["Tween Speed 1"])
                    -- row highlight
                    Tween(RowBG, {
                        BackgroundColor3 = val and Color3.fromRGB(20,10,50) or UIColor["BG Panel"]
                    }, UIColor["Tween Speed 1"])
                end

                ChangeStage(Default)
                if Default and Callback then pcall(Callback, Default) end

                local function ButtonClick()
                    toggled = not toggled
                    ChangeStage(toggled)
                    pcall(Callback, toggled)
                end

                ToggleBtn.MouseButton1Click:Connect(ButtonClick)

                -- hover (giống Banana rowHover)
                ToggleBtn.MouseEnter:Connect(function()
                    Tween(RowBG, { BackgroundTransparency = 0 }, UIColor["Tween Speed 3"])
                end)
                ToggleBtn.MouseLeave:Connect(function()
                    Tween(RowBG, { BackgroundTransparency = 0.05 }, UIColor["Tween Speed 3"])
                end)

                -- AllControls (giống Banana)
                table.insert(getgenv().VoidAllControls, {
                    Name        = Title,
                    Section     = Section,
                    Element     = ToggleFrame,
                    SectionName = Sec_Name,
                    TabName     = Tab_Name,
                    TabButton   = TabButtons[Tab_Name],
                })

                local toggleFunction = {}
                function toggleFunction:SetStage(val)
                    if val ~= toggled then ButtonClick() end
                end
                function toggleFunction:GetStage() return toggled end
                return toggleFunction
            end

            -- ────────────────────────────────────────
            --  AddButton
            -- ────────────────────────────────────────
            function sectionFunction:AddButton(setting)
                local Title    = setting.Title or setting.Text or ""
                local Desc     = setting.Desc or setting.Description
                local Callback = setting.Callback or setting.Func or function() end
                local Icon     = setting.Icon or ""

                local BtnFrame = New("Frame", {
                    Name                   = "BtnFrame",
                    BackgroundTransparency = 1,
                    Size                   = (Desc and Desc ~= "") and UDim2.new(1,0,0,0) or UDim2.new(1,0,0,34),
                    AutomaticSize          = (Desc and Desc ~= "") and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
                    Parent                 = SectionList,
                })

                local RowBG = New("Frame", {
                    Name             = "RowBG",
                    AnchorPoint      = Vector2.new(0.5,0.5),
                    Position         = UDim2.new(0.5,0,0.5,0),
                    BackgroundColor3 = UIColor["BG Panel"],
                    BackgroundTransparency = 0.05,
                    Size             = UDim2.new(1,0,1,0),
                    AutomaticSize    = (Desc and Desc ~= "") and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
                    Parent           = BtnFrame,
                })
                Corner(RowBG, 7)
                Stroke(RowBG, UIColor["Border"], 1)

                -- title
                local tX = Icon ~= "" and UDim2.new(0,30,0,0) or UDim2.new(0,8,0,0)
                local tS = (Desc and Desc ~= "") and UDim2.new(1,-110,0,18) or UDim2.new(1,-110,1,0)
                local tP = (Desc and Desc ~= "") and UDim2.new(0,30,0,5) or tX
                Lbl(RowBG, Title, tS, tP, UIColor["Text Main"], 12, Enum.Font.GothamBold)

                if Icon ~= "" then
                    Lbl(RowBG, Icon, UDim2.new(0,22,1,0), UDim2.new(0,5,0,0),
                        Color3.fromRGB(255,255,255), 14, Enum.Font.GothamBold, Enum.TextXAlignment.Center)
                end

                if Desc and Desc ~= "" then
                    local descLbl = Lbl(RowBG, Desc,
                        UDim2.new(1,-110,0,0), UDim2.new(0,30,0,22),
                        UIColor["Text Dim"], 9, Enum.Font.Gotham)
                    descLbl.AutomaticSize = Enum.AutomaticSize.Y
                    descLbl.TextWrapped   = true
                    New("UIPadding", {
                        PaddingTop    = UDim.new(0,5),
                        PaddingBottom = UDim.new(0,5),
                        Parent        = RowBG,
                    })
                end

                -- Click area (giống Banana ClickArea với gradient + ripple)
                local ClickArea = New("Frame", {
                    Name             = "ClickArea",
                    AnchorPoint      = Vector2.new(1,0.5),
                    Position         = UDim2.new(1,-6,0.5,0),
                    Size             = UDim2.new(0,70,0,26),
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    ClipsDescendants = true,
                    Parent           = RowBG,
                })
                Corner(ClickArea, 10)
                New("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, UIColor["Accent2"]),
                        ColorSequenceKeypoint.new(1, UIColor["Accent1"]),
                    }),
                    Rotation = 90,
                    Parent   = ClickArea,
                })

                -- gloss
                New("Frame", {
                    AnchorPoint      = Vector2.new(0.5,0),
                    Position         = UDim2.new(0.5,0,0,2),
                    Size             = UDim2.new(1,-6,0,8),
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    BackgroundTransparency = 0.8,
                    ZIndex           = 2,
                    Parent           = ClickArea,
                })

                local ClickBtn = New("TextButton", {
                    Size             = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                    Text             = "Click",
                    TextColor3       = Color3.fromRGB(255,255,255),
                    Font             = Enum.Font.GothamBold,
                    TextSize         = 12,
                    AutoButtonColor  = false,
                    ZIndex           = 3,
                    Parent           = ClickArea,
                })

                -- UIScale hover (giống Banana)
                local UIScale = New("UIScale", { Parent = ClickArea })
                local scaleUp   = TweenService:Create(UIScale, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1.06 })
                local scaleDown = TweenService:Create(UIScale, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1 })
                ClickBtn.MouseEnter:Connect(function() scaleUp:Play() end)
                ClickBtn.MouseLeave:Connect(function() scaleDown:Play() end)

                -- ripple + callback (giống Banana)
                ClickBtn.MouseButton1Down:Connect(function(x, y)
                    Ripple(ClickArea, x, y)
                    pcall(Callback)
                end)

                -- row hover
                ClickBtn.MouseEnter:Connect(function()
                    Tween(RowBG, { BackgroundTransparency = 0 }, UIColor["Tween Speed 3"])
                end)
                ClickBtn.MouseLeave:Connect(function()
                    Tween(RowBG, { BackgroundTransparency = 0.05 }, UIColor["Tween Speed 3"])
                end)

                table.insert(getgenv().VoidAllControls, {
                    Name        = Title,
                    Section     = Section,
                    Element     = BtnFrame,
                    SectionName = Sec_Name,
                    TabName     = Tab_Name,
                    TabButton   = TabButtons[Tab_Name],
                })

                local f = {}
                function f:SetTitle(v)
                    -- find TextLabel in RowBG
                    for _, c in ipairs(RowBG:GetChildren()) do
                        if c:IsA("TextLabel") and c.Text == Title then c.Text = v; Title = v end
                    end
                end
                return f
            end

            -- ────────────────────────────────────────
            --  AddSlider
            -- ────────────────────────────────────────
            function sectionFunction:AddSlider(setting)
                local Title    = setting.Title or setting.Text or ""
                local Min      = tonumber(setting.Min)     or 0
                local Max      = tonumber(setting.Max)     or 100
                local Default  = tonumber(setting.Default) or Min
                local Callback = setting.Callback          or function() end
                local Rounding = setting.Rounding or setting.Rouding  -- accept both spellings

                local SliderFrame = New("Frame", {
                    Name                   = "SliderFrame",
                    BackgroundTransparency = 1,
                    Size                   = UDim2.new(1,0,0,50),
                    Parent                 = SectionList,
                })

                local SliderBG = New("Frame", {
                    Name             = "SliderBG",
                    AnchorPoint      = Vector2.new(0.5,0.5),
                    Position         = UDim2.new(0.5,0,0.5,0),
                    BackgroundColor3 = UIColor["BG Panel"],
                    BackgroundTransparency = 0.05,
                    Size             = UDim2.new(1,0,1,0),
                    Parent           = SliderFrame,
                })
                Corner(SliderBG, 7)
                Stroke(SliderBG, UIColor["Border"], 1)

                -- title
                Lbl(SliderBG, Title,
                    UDim2.new(0.65,-10,0,22), UDim2.new(0,10,0,2),
                    UIColor["Text Main"], 12, Enum.Font.GothamBold)

                -- value textbox (giống Banana Sliderboxframe)
                local ValBox = New("Frame", {
                    Name             = "ValBox",
                    AnchorPoint      = Vector2.new(1,0),
                    Position         = UDim2.new(1,-8,0,4),
                    Size             = UDim2.new(0.28,0,0,22),
                    BackgroundColor3 = UIColor["BG Mid"],
                    Parent           = SliderBG,
                })
                Corner(ValBox, 4)
                Stroke(ValBox, UIColor["Accent2"], 1)

                local ValTB = New("TextBox", {
                    Size             = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                    Text             = tostring(Default),
                    TextColor3       = UIColor["Accent2"],
                    Font             = Enum.Font.GothamBold,
                    TextSize         = 12,
                    TextXAlignment   = Enum.TextXAlignment.Center,
                    Parent           = ValBox,
                })

                -- track
                local TrackBG = New("Frame", {
                    Name             = "TrackBG",
                    AnchorPoint      = Vector2.new(0.5,1),
                    Position         = UDim2.new(0.5,0,1,-6),
                    Size             = UDim2.new(0.9,0,0,5),
                    BackgroundColor3 = UIColor["Slider Track"],
                    Parent           = SliderBG,
                })
                Corner(TrackBG, 100)

                local Fill = New("Frame", {
                    Name             = "Fill",
                    Size             = UDim2.new((Default-Min)/(Max-Min),0,1,0),
                    BackgroundColor3 = UIColor["Slider Fill"],
                    Parent           = TrackBG,
                })
                Corner(Fill, 100)
                New("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, UIColor["Accent1"]),
                        ColorSequenceKeypoint.new(1, UIColor["Accent2"]),
                    }),
                    Parent = Fill,
                })

                -- thumb (giống Banana thumb knob)
                local Thumb = New("Frame", {
                    Name             = "Thumb",
                    AnchorPoint      = Vector2.new(0.5,0.5),
                    Position         = UDim2.new((Default-Min)/(Max-Min),0,0.5,0),
                    Size             = UDim2.new(0,10,0,10),
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    Parent           = TrackBG,
                })
                Corner(Thumb, 100)
                Stroke(Thumb, UIColor["Accent2"], 1)

                -- invisible drag button over entire slider area
                local SliderBtn = New("TextButton", {
                    Size             = UDim2.new(1,0,0,26),
                    AnchorPoint      = Vector2.new(0.5,1),
                    Position         = UDim2.new(0.5,0,1,0),
                    BackgroundTransparency = 1,
                    Text             = "",
                    Parent           = SliderBG,
                })

                local currentVal = Default
                local dragging   = false

                local function callBack(v)
                    if Rounding then
                        v = tonumber(string.format("%." .. Rounding .. "f", v))
                    else
                        v = math.floor(v)
                    end
                    v = math.clamp(v, Min, Max)
                    currentVal   = v
                    ValTB.Text   = tostring(v)
                    local rel    = (v - Min) / (Max - Min)
                    Fill.Size    = UDim2.new(rel, 0, 1, 0)
                    Thumb.Position = UDim2.new(rel, 0, 0.5, 0)
                    pcall(Callback, v)
                end

                -- giống Banana RenderStepped slider drag
                local holdStarted = 0
                local dragInput

                SliderBtn.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1
                    or inp.UserInputType == Enum.UserInputType.Touch then
                        holdStarted = tick()
                        inp.Changed:Connect(function()
                            if inp.UserInputState == Enum.UserInputState.End then
                                dragging    = false
                                holdStarted = 0
                            end
                        end)
                    end
                end)
                SliderBtn.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1
                    or inp.UserInputType == Enum.UserInputType.Touch then
                        dragging    = false
                        holdStarted = 0
                    end
                end)
                SliderBtn.InputChanged:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseMovement
                    or inp.UserInputType == Enum.UserInputType.Touch then
                        dragInput = inp
                    end
                end)

                RunService.RenderStepped:Connect(function()
                    if holdStarted > 0 and not dragging then
                        dragging = true
                    end
                    if dragging and dragInput then
                        local rel = math.clamp(
                            (dragInput.Position.X - TrackBG.AbsolutePosition.X) / TrackBG.AbsoluteSize.X,
                            0, 1
                        )
                        callBack(Min + (Max - Min) * rel)
                    end
                end)

                ValTB.FocusLost:Connect(function()
                    callBack(tonumber(ValTB.Text) or currentVal)
                end)

                callBack(Default)

                table.insert(getgenv().VoidAllControls, {
                    Name        = Title,
                    Section     = Section,
                    Element     = SliderFrame,
                    SectionName = Sec_Name,
                    TabName     = Tab_Name,
                    TabButton   = TabButtons[Tab_Name],
                })

                local sliderFunction = {}
                function sliderFunction:SetValue(v) callBack(v) end
                function sliderFunction:GetValue() return currentVal end
                return sliderFunction
            end

            -- ────────────────────────────────────────
            --  AddLabel
            -- ────────────────────────────────────────
            function sectionFunction:AddLabel(text)
                local LblFrame = New("Frame", {
                    Name                   = "LblFrame",
                    BackgroundTransparency = 1,
                    AutomaticSize          = Enum.AutomaticSize.Y,
                    Size                   = UDim2.new(1,0,0,0),
                    Parent                 = SectionList,
                })
                local LblBG = New("Frame", {
                    Name             = "LblBG",
                    BackgroundColor3 = UIColor["BG Panel"],
                    BackgroundTransparency = 0.3,
                    AutomaticSize    = Enum.AutomaticSize.Y,
                    Size             = UDim2.new(1,0,0,0),
                    Parent           = LblFrame,
                })
                Corner(LblBG, 6)
                local textLbl = Lbl(LblBG, text,
                    UDim2.new(1,-12,0,0), UDim2.new(0,6,0,4),
                    UIColor["Text Dim"], 11, Enum.Font.Gotham)
                textLbl.AutomaticSize = Enum.AutomaticSize.Y
                textLbl.TextWrapped   = true
                New("UIPadding", { PaddingBottom = UDim.new(0,4), Parent = LblBG })

                local f = {}
                function f:SetText(v) textLbl.Text = v end
                return f
            end

            -- ────────────────────────────────────────
            --  AddDivider (= Banana AddSeperator)
            -- ────────────────────────────────────────
            function sectionFunction:AddDivider(text)
                local DivFrame = New("Frame", {
                    Name                   = "Divider",
                    BackgroundTransparency = 1,
                    Size                   = UDim2.new(1,0,0, text and text ~= "" and 20 or 10),
                    Parent                 = SectionList,
                })

                if text and text ~= "" then
                    local sepLbl = Lbl(DivFrame, text,
                        UDim2.new(0,0,1,0), UDim2.new(0.5,0,0,0),
                        UIColor["Text Dim"], 9, Enum.Font.GothamBold, Enum.TextXAlignment.Center)
                    sepLbl.AnchorPoint = Vector2.new(0.5,0.5)
                    sepLbl.Position    = UDim2.new(0.5,0,0.5,0)
                    sepLbl.AutomaticSize = Enum.AutomaticSize.X

                    local LeftLine = New("Frame", {
                        AnchorPoint      = Vector2.new(1,0.5),
                        Position         = UDim2.new(0.5,-4,0.5,0),
                        Size             = UDim2.new(0.4,0,0,1),
                        BackgroundColor3 = UIColor["Border"],
                        BorderSizePixel  = 0,
                        Parent           = DivFrame,
                    })
                    New("UIGradient", {
                        Rotation     = 180,
                        Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 0),
                            NumberSequenceKeypoint.new(1, 0.8),
                        }),
                        Parent = LeftLine,
                    })

                    local RightLine = New("Frame", {
                        AnchorPoint      = Vector2.new(0,0.5),
                        Position         = UDim2.new(0.5,4,0.5,0),
                        Size             = UDim2.new(0.4,0,0,1),
                        BackgroundColor3 = UIColor["Border"],
                        BorderSizePixel  = 0,
                        Parent           = DivFrame,
                    })
                    New("UIGradient", {
                        Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 0),
                            NumberSequenceKeypoint.new(1, 0.8),
                        }),
                        Parent = RightLine,
                    })
                else
                    local line = New("Frame", {
                        Position         = UDim2.new(0,6,0.5,0),
                        Size             = UDim2.new(1,-12,0,1),
                        BackgroundColor3 = UIColor["Border"],
                        BorderSizePixel  = 0,
                        Parent           = DivFrame,
                    })
                    New("UIGradient", {
                        Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0,   1),
                            NumberSequenceKeypoint.new(0.2, 0),
                            NumberSequenceKeypoint.new(0.8, 0),
                            NumberSequenceKeypoint.new(1,   1),
                        }),
                        Parent = line,
                    })
                end

                table.insert(getgenv().VoidAllControls, {
                    Name        = text or "Divider",
                    Section     = Section,
                    Element     = DivFrame,
                    SectionName = Sec_Name,
                    TabName     = Tab_Name,
                    TabButton   = TabButtons[Tab_Name],
                })
            end

            -- compat aliases (giống Banana pagefunc AddLeftGroupbox/AddRightGroupbox)
            function sectionFunction:AddLeftGroupbox(name)  return self:AddSection(name) end
            function sectionFunction:AddRightGroupbox(name) return self:AddSection(name) end

            return sectionFunction
        end -- AddSection

        -- compat aliases
        local pagefunc = {}
        function pagefunc:AddSection(name)         return pageFunction:AddSection(name) end
        function pagefunc:AddLeftGroupbox(name)    return pageFunction:AddSection(name) end
        function pagefunc:AddRightGroupbox(name)   return pageFunction:AddSection(name) end
        return pagefunc
    end -- AddTab

    -- ───────────────────────────────────────────────────────
    --  OPEN ANIMATION
    -- ───────────────────────────────────────────────────────
    getgenv().VoidReadyForGuiLoaded = true
    getgenv().VoidUIToggled         = true
    Library_Internal.MainGui.Enabled = true

    MainWindow.Size = UDim2.new(0, WIN_W, 0, 0)
    Tween(MainWindow, { Size = UDim2.new(0, WIN_W, 0, WIN_H) }, UIColor["Tween Speed 2"],
        Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    task.delay(0.6, function()
        Library:Notify({
            Title       = hubName,
            Description = "Chào mừng " .. LocalPlayer.Name .. "! Hub đã tải xong.",
            Type        = "success",
            Duration    = 5,
        })
    end)

    return Main_Function
end -- CreateWindow

return Library

--[[
═══════════════════════════════════════════════════════════
  CÁCH SỬ DỤNG (Banana-style API)
═══════════════════════════════════════════════════════════

local Library = loadstring(...)()  -- hoặc require

local Window = Library:CreateWindow({
    Title      = "VOID CRYSTAL",
    Subtitle   = "Blox Fruits Script Hub",
    Version    = "v2.0",
    ToggleKey  = Enum.KeyCode.RightControl,
})

local Tab = Window:AddTab("Main", Color3.fromRGB(0, 220, 255))
local Sec = Tab:AddSection("⚔  Combat")

Sec:AddToggle({
    Title    = "Auto Farm",
    Default  = false,
    Desc     = "Tự động farm NPC",
    Callback = function(val) end,
})

Sec:AddButton({
    Title    = "Rejoin",
    Icon     = "🔄",
    Callback = function() end,
})

Sec:AddSlider({
    Title    = "Walk Speed",
    Min      = 16, Max = 200, Default = 16,
    Callback = function(val) end,
})

Library:Notify({
    Title       = "Info",
    Description = "Hello World",
    Type        = "success",   -- "info" | "success" | "error" | "warn"
    Duration    = 4,
})

Library.ToggleUI()    -- toggle menu
Library.DestroyUI()   -- hủy toàn bộ
]]
