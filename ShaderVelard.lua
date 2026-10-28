--[[
__     _______ _        _    ____  ____  
\ \   / / ____| |      / \  |  _ \|  _ \ 
 \ \ / /|  _| | |     / _ \ | |_) | | | |
  \ V / | |___| |___ / ___ \|  _ <| |_| |
 __\_/ _|_____|_____/_/__ \_\_|_\_\____/   
/ ___|| | | |  / \  |  _ \| ____|  _ \   
\___ \| |_| | / _ \ | | | |  _| | |_) |  
 ___) |  _  |/ ___ \| |_| | |___|  _ <   
|____/|_| |_/_/   \_\____/|_____|_| \_\  

--]]

local TweenService = game:GetService("TweenService")
local Players      = game:GetService("Players")
local lp           = Players.LocalPlayer
local pg           = lp:WaitForChild("PlayerGui")

local MENU_OPTIONS = {
    {
        number    = 1,
        name      = "Shader Velard",
        tag       = "(All)",
        desc      = "All features combined",
        available = true,
    },
    {
        number    = 2,
        name      = "Lite Shader",
        tag       = "",
        desc      = "Lightweight version for performance",
        available = false,
    },
    {
        number    = 3,
        name      = "Visual Accessories",
        tag       = "",
        desc      = "Collection of visual accessories & effects",
        available = false,
    },
}

local gui = Instance.new("ScreenGui")
gui.Name           = "VelardToolsLoader"
gui.ResetOnSpawn   = false
gui.IgnoreGuiInset = true
gui.DisplayOrder   = 999
gui.Parent         = pg

local overlay = Instance.new("Frame")
overlay.Size                   = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3       = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.35
overlay.BorderSizePixel        = 0
overlay.Parent                 = gui

local box = Instance.new("Frame")
box.AnchorPoint      = Vector2.new(0.5, 0.5)
box.Position         = UDim2.new(0.5, 0, 0.5, 0)
box.Size             = UDim2.new(0, 460, 0, 160)
box.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
box.BorderSizePixel  = 0
box.Parent           = overlay
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke")
stroke.Color        = Color3.fromRGB(60, 60, 60)
stroke.Thickness    = 1
stroke.Transparency = 0.2
stroke.Parent       = box

local title = Instance.new("TextLabel")
title.Size                   = UDim2.new(1, -40, 0, 30)
title.Position               = UDim2.new(0, 20, 0, 25)
title.BackgroundTransparency = 1
title.Text                   = "WELCOME TO"
title.TextColor3             = Color3.fromRGB(160, 160, 160)
title.Font                   = Enum.Font.GothamBold
title.TextSize               = 14
title.TextXAlignment         = Enum.TextXAlignment.Center
title.Parent                 = box

local titleBig = Instance.new("TextLabel")
titleBig.Size                   = UDim2.new(1, -40, 0, 50)
titleBig.Position               = UDim2.new(0, 20, 0, 50)
titleBig.BackgroundTransparency = 1
titleBig.Text                   = "VELARD TOOLS"
titleBig.TextColor3             = Color3.fromRGB(255, 255, 255)
titleBig.Font                   = Enum.Font.GothamBlack
titleBig.TextSize               = 34
titleBig.TextXAlignment         = Enum.TextXAlignment.Center
titleBig.Parent                 = box

local barBg = Instance.new("Frame")
barBg.Size             = UDim2.new(1, -40, 0, 6)
barBg.Position         = UDim2.new(0, 20, 0, 120)
barBg.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
barBg.BorderSizePixel  = 0
barBg.ClipsDescendants = true
barBg.Parent           = box
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame")
barFill.Size             = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
barFill.BorderSizePixel  = 0
barFill.Parent           = barBg
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

local pct = Instance.new("TextLabel")
pct.Size                   = UDim2.new(0, 100, 0, 16)
pct.Position               = UDim2.new(1, -120, 0, 130)
pct.BackgroundTransparency = 1
pct.Text                   = "0%"
pct.TextColor3             = Color3.fromRGB(200, 200, 200)
pct.Font                   = Enum.Font.GothamMedium
pct.TextSize               = 12
pct.TextXAlignment         = Enum.TextXAlignment.Right
pct.Parent                 = box

local status = Instance.new("TextLabel")
status.Size                   = UDim2.new(0, 200, 0, 16)
status.Position               = UDim2.new(0, 20, 0, 130)
status.BackgroundTransparency = 1
status.Text                   = "Loading..."
status.TextColor3             = Color3.fromRGB(160, 160, 160)
status.Font                   = Enum.Font.Gotham
status.TextSize               = 12
status.TextXAlignment         = Enum.TextXAlignment.Left
status.Parent                 = box

local DURATION = 5
TweenService:Create(barFill, TweenInfo.new(DURATION, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0) }):Play()

local t0 = tick()
task.spawn(function()
    while true do
        local p = math.clamp(math.floor(((tick() - t0) / DURATION) * 100), 0, 100)
        pct.Text = p .. "%"
        if p >= 100 then
            status.Text = "Preparing menu..."
            break
        end
        task.wait(0.03)
    end
end)

task.wait(DURATION)
pct.Text = "100%"

local fi = TweenInfo.new(0.25)
TweenService:Create(overlay, fi, { BackgroundTransparency = 1 }):Play()
TweenService:Create(box, fi, { BackgroundTransparency = 1 }):Play()
TweenService:Create(stroke, fi, { Transparency = 1 }):Play()
TweenService:Create(title, fi, { TextTransparency = 1 }):Play()
TweenService:Create(titleBig, fi, { TextTransparency = 1 }):Play()
TweenService:Create(barBg, fi, { BackgroundTransparency = 1 }):Play()
TweenService:Create(pct, fi, { TextTransparency = 1 }):Play()
TweenService:Create(status, fi, { TextTransparency = 1 }):Play()
task.wait(0.3)
overlay:Destroy()

local menu = Instance.new("Frame")
menu.AnchorPoint            = Vector2.new(0.5, 0.5)
menu.Position               = UDim2.new(0.5, 0, 0.5, 0)
menu.Size                   = UDim2.new(0, 420, 0, 400)
menu.BackgroundColor3       = Color3.fromRGB(14, 14, 14)
menu.BorderSizePixel        = 0
menu.BackgroundTransparency = 1
menu.Parent                 = gui
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 10)

local menuStroke = Instance.new("UIStroke")
menuStroke.Color        = Color3.fromRGB(60, 60, 60)
menuStroke.Thickness    = 1
menuStroke.Transparency = 1
menuStroke.Parent       = menu

local menuTitle = Instance.new("TextLabel")
menuTitle.Size                   = UDim2.new(1, -40, 0, 28)
menuTitle.Position               = UDim2.new(0, 20, 0, 22)
menuTitle.BackgroundTransparency = 1
menuTitle.Text                   = "VELARD TOOLS"
menuTitle.TextColor3             = Color3.fromRGB(255, 255, 255)
menuTitle.Font                   = Enum.Font.GothamBlack
menuTitle.TextSize               = 20
menuTitle.TextXAlignment         = Enum.TextXAlignment.Left
menuTitle.TextTransparency       = 1
menuTitle.Parent                 = menu

local menuSub = Instance.new("TextLabel")
menuSub.Size                   = UDim2.new(1, -40, 0, 16)
menuSub.Position               = UDim2.new(0, 20, 0, 50)
menuSub.BackgroundTransparency = 1
menuSub.Text                   = "Select a script to execute:"
menuSub.TextColor3             = Color3.fromRGB(150, 150, 150)
menuSub.Font                   = Enum.Font.Gotham
menuSub.TextSize               = 12
menuSub.TextXAlignment         = Enum.TextXAlignment.Left
menuSub.TextTransparency       = 1
menuSub.Parent                 = menu

local divider = Instance.new("Frame")
divider.Size             = UDim2.new(1, -40, 0, 1)
divider.Position         = UDim2.new(0, 20, 0, 74)
divider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
divider.BorderSizePixel  = 0
divider.BackgroundTransparency = 1
divider.Parent           = menu

local optionsContainer = Instance.new("Frame")
optionsContainer.Size                   = UDim2.new(1, -40, 0, 240)
optionsContainer.Position               = UDim2.new(0, 20, 0, 92)
optionsContainer.BackgroundTransparency = 1
optionsContainer.Parent                 = menu

local list = Instance.new("UIListLayout")
list.Padding   = UDim.new(0, 8)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent    = optionsContainer

local footer = Instance.new("TextLabel")
footer.Size                   = UDim2.new(1, -40, 0, 16)
footer.Position               = UDim2.new(0, 20, 1, -34)
footer.BackgroundTransparency = 1
footer.Text                   = "Click a number to execute the script"
footer.TextColor3             = Color3.fromRGB(100, 100, 100)
footer.Font                   = Enum.Font.Gotham
footer.TextSize               = 11
footer.TextXAlignment         = Enum.TextXAlignment.Center
footer.TextTransparency       = 1
footer.Parent                 = menu

local function showMaintenanceNotif()
    local notif = Instance.new("Frame")
    notif.AnchorPoint            = Vector2.new(0.5, 1)
    notif.Position               = UDim2.new(0.5, 0, 1, -30)
    notif.Size                   = UDim2.new(0, 300, 0, 50)
    notif.BackgroundColor3       = Color3.fromRGB(14, 14, 14)
    notif.BorderSizePixel        = 0
    notif.BackgroundTransparency = 1
    notif.Parent                 = gui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)

    local ns = Instance.new("UIStroke")
    ns.Color        = Color3.fromRGB(60, 60, 60)
    ns.Thickness    = 1
    ns.Transparency = 1
    ns.Parent       = notif

    local nTitle = Instance.new("TextLabel")
    nTitle.Size                   = UDim2.new(1, -20, 0, 20)
    nTitle.Position               = UDim2.new(0, 10, 0, 8)
    nTitle.BackgroundTransparency = 1
    nTitle.Text                   = "UNDER MAINTENANCE"
    nTitle.TextColor3             = Color3.fromRGB(255, 255, 255)
    nTitle.Font                   = Enum.Font.GothamBold
    nTitle.TextSize               = 13
    nTitle.TextXAlignment         = Enum.TextXAlignment.Left
    nTitle.TextTransparency       = 1
    nTitle.Parent                 = notif

    local nDesc = Instance.new("TextLabel")
    nDesc.Size                   = UDim2.new(1, -20, 0, 16)
    nDesc.Position               = UDim2.new(0, 10, 0, 26)
    nDesc.BackgroundTransparency = 1
    nDesc.Text                   = "This feature is currently under maintenance."
    nDesc.TextColor3             = Color3.fromRGB(160, 160, 160)
    nDesc.Font                   = Enum.Font.Gotham
    nDesc.TextSize               = 11
    nDesc.TextXAlignment         = Enum.TextXAlignment.Left
    nDesc.TextTransparency       = 1
    nDesc.Parent                 = notif

    local fi2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(notif, fi2, { BackgroundTransparency = 0 }):Play()
    TweenService:Create(ns, fi2, { Transparency = 0.2 }):Play()
    TweenService:Create(nTitle, fi2, { TextTransparency = 0 }):Play()
    TweenService:Create(nDesc, fi2, { TextTransparency = 0 }):Play()

    task.delay(2.2, function()
        local fo = TweenInfo.new(0.3)
        TweenService:Create(notif, fo, { BackgroundTransparency = 1 }):Play()
        TweenService:Create(ns, fo, { Transparency = 1 }):Play()
        TweenService:Create(nTitle, fo, { TextTransparency = 1 }):Play()
        TweenService:Create(nDesc, fo, { TextTransparency = 1 }):Play()
        task.wait(0.35)
        notif:Destroy()
    end)
end

local function fadeOutMenuAndDestroy()
    local ft = TweenInfo.new(0.25)
    TweenService:Create(menu, ft, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(menuStroke, ft, { Transparency = 1 }):Play()
    TweenService:Create(menuTitle, ft, { TextTransparency = 1 }):Play()
    TweenService:Create(menuSub, ft, { TextTransparency = 1 }):Play()
    TweenService:Create(divider, ft, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(footer, ft, { TextTransparency = 1 }):Play()

    for _, el in ipairs(optionsContainer:GetChildren()) do
        if el:IsA("TextButton") then
            TweenService:Create(el, ft, { BackgroundTransparency = 1 }):Play()
            for _, c in ipairs(el:GetChildren()) do
                if c:IsA("TextLabel") then
                    TweenService:Create(c, ft, { TextTransparency = 1 }):Play()
                elseif c:IsA("UIStroke") then
                    TweenService:Create(c, ft, { Transparency = 1 }):Play()
                elseif c:IsA("Frame") then
                    TweenService:Create(c, ft, { BackgroundTransparency = 1 }):Play()
                    for _, cc in ipairs(c:GetChildren()) do
                        if cc:IsA("TextLabel") then
                            TweenService:Create(cc, ft, { TextTransparency = 1 }):Play()
                        end
                    end
                end
            end
        end
    end

    task.wait(0.3)
    gui:Destroy()
end

local function createOptionButton(opt)
    local isAvailable = opt.available

    local btn = Instance.new("TextButton")
    btn.Size                   = UDim2.new(1, 0, 0, 66)
    btn.BackgroundColor3       = isAvailable and Color3.fromRGB(22, 22, 22) or Color3.fromRGB(16, 16, 16)
    btn.BorderSizePixel        = 0
    btn.AutoButtonColor        = false
    btn.Text                   = ""
    btn.LayoutOrder            = opt.number
    btn.BackgroundTransparency = 1
    btn.Parent                 = optionsContainer

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local s = Instance.new("UIStroke")
    s.Color        = Color3.fromRGB(50, 50, 50)
    s.Thickness    = 1
    s.Transparency = 1
    s.Parent       = btn

    local numBox = Instance.new("Frame")
    numBox.Size                   = UDim2.new(0, 40, 0, 40)
    numBox.Position               = UDim2.new(0, 14, 0.5, -20)
    numBox.BackgroundColor3       = isAvailable and Color3.fromRGB(240, 240, 240) or Color3.fromRGB(30, 30, 30)
    numBox.BorderSizePixel        = 0
    numBox.BackgroundTransparency = 1
    numBox.Parent                 = btn
    Instance.new("UICorner", numBox).CornerRadius = UDim.new(0, 6)

    local numLbl = Instance.new("TextLabel")
    numLbl.Size                   = UDim2.new(1, 0, 1, 0)
    numLbl.BackgroundTransparency = 1
    numLbl.Text                   = tostring(opt.number)
    numLbl.TextColor3             = isAvailable and Color3.fromRGB(14, 14, 14) or Color3.fromRGB(120, 120, 120)
    numLbl.Font                   = Enum.Font.GothamBlack
    numLbl.TextSize               = 18
    numLbl.TextTransparency       = 1
    numLbl.Parent                 = numBox

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size                   = UDim2.new(1, -80, 0, 22)
    nameLbl.Position               = UDim2.new(0, 68, 0, 12)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text                   = opt.name
    nameLbl.TextColor3             = isAvailable and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    nameLbl.Font                   = Enum.Font.GothamBold
    nameLbl.TextSize               = 15
    nameLbl.TextXAlignment         = Enum.TextXAlignment.Left
    nameLbl.TextTransparency       = 1
    nameLbl.Parent                 = btn

    local descLbl = Instance.new("TextLabel")
    descLbl.Size                   = UDim2.new(1, -80, 0, 16)
    descLbl.Position               = UDim2.new(0, 68, 0, 36)
    descLbl.BackgroundTransparency = 1
    descLbl.Text                   = isAvailable and opt.desc or "Under maintenance"
    descLbl.TextColor3             = isAvailable and Color3.fromRGB(140, 140, 140) or Color3.fromRGB(100, 100, 100)
    descLbl.Font                   = Enum.Font.Gotham
    descLbl.TextSize               = 11
    descLbl.TextXAlignment         = Enum.TextXAlignment.Left
    descLbl.TextTransparency       = 1
    descLbl.Parent                 = btn

    if opt.tag and opt.tag ~= "" then
        local tagLbl = Instance.new("TextLabel")
        tagLbl.Size                   = UDim2.new(0, 40, 0, 16)
        tagLbl.Position               = UDim2.new(0, 160, 0, 15)
        tagLbl.BackgroundColor3       = Color3.fromRGB(240, 240, 240)
        tagLbl.BorderSizePixel        = 0
        tagLbl.Text                   = opt.tag
        tagLbl.TextColor3             = Color3.fromRGB(14, 14, 14)
        tagLbl.Font                   = Enum.Font.GothamBold
        tagLbl.TextSize               = 10
        tagLbl.TextTransparency       = 1
        tagLbl.BackgroundTransparency = 1
        tagLbl.Parent                 = btn
        Instance.new("UICorner", tagLbl).CornerRadius = UDim.new(0, 4)
    end

    if not isAvailable then
        local badge = Instance.new("TextLabel")
        badge.AnchorPoint            = Vector2.new(1, 0.5)
        badge.Position               = UDim2.new(1, -14, 0.5, 0)
        badge.Size                   = UDim2.new(0, 100, 0, 20)
        badge.BackgroundColor3       = Color3.fromRGB(40, 40, 40)
        badge.BorderSizePixel        = 0
        badge.Text                   = "MAINTENANCE"
        badge.TextColor3             = Color3.fromRGB(200, 200, 200)
        badge.Font                   = Enum.Font.GothamBold
        badge.TextSize               = 9
        badge.TextTransparency       = 1
        badge.BackgroundTransparency = 1
        badge.Parent                 = btn
        Instance.new("UICorner", badge).CornerRadius = UDim.new(0, 4)
    end

    if isAvailable then
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(32, 32, 32) }):Play()
            TweenService:Create(s,   TweenInfo.new(0.15), { Color = Color3.fromRGB(130, 130, 130) }):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(22, 22, 22) }):Play()
            TweenService:Create(s,   TweenInfo.new(0.15), { Color = Color3.fromRGB(50, 50, 50) }):Play()
        end)

        btn.MouseButton1Click:Connect(function()
            fadeOutMenuAndDestroy()
            local ok, err = pcall(function()
                loadstring(game:HttpGet("https://shadervelard-auth.shadervelard.workers.dev/load"))()
            end)
            if not ok then
                warn("[Velard Tools] Error: " .. tostring(err))
            end
        end)
    else
        btn.MouseButton1Click:Connect(function()
            showMaintenanceNotif()
        end)
    end

    return btn
end

for _, opt in ipairs(MENU_OPTIONS) do
    createOptionButton(opt)
end

task.spawn(function()
    local ft = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(menu, ft, { BackgroundTransparency = 0 }):Play()
    TweenService:Create(menuStroke, ft, { Transparency = 0.2 }):Play()
    TweenService:Create(menuTitle, ft, { TextTransparency = 0 }):Play()
    TweenService:Create(menuSub, ft, { TextTransparency = 0 }):Play()
    TweenService:Create(divider, ft, { BackgroundTransparency = 0 }):Play()
    TweenService:Create(footer, ft, { TextTransparency = 0 }):Play()

    task.wait(0.15)

    for _, el in ipairs(optionsContainer:GetChildren()) do
        if el:IsA("TextButton") then
            TweenService:Create(el, ft, { BackgroundTransparency = 0 }):Play()
            for _, c in ipairs(el:GetChildren()) do
                if c:IsA("TextLabel") then
                    TweenService:Create(c, ft, { TextTransparency = 0 }):Play()
                elseif c:IsA("UIStroke") then
                    TweenService:Create(c, ft, { Transparency = 0 }):Play()
                elseif c:IsA("Frame") then
                    TweenService:Create(c, ft, { BackgroundTransparency = 0 }):Play()
                    for _, cc in ipairs(c:GetChildren()) do
                        if cc:IsA("TextLabel") then
                            TweenService:Create(cc, ft, { TextTransparency = 0 }):Play()
                        end
                    end
                end
            end
        end
    end
end)
