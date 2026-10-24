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
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")


local gui = Instance.new("ScreenGui")
gui.Name = "VelardToolsLoader"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = pg

local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.35
overlay.BorderSizePixel = 0
overlay.Parent = gui

local box = Instance.new("Frame")
box.AnchorPoint = Vector2.new(0.5, 0.5)
box.Position = UDim2.new(0.5, 0, 0.5, 0)
box.Size = UDim2.new(0, 460, 0, 160)
box.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
box.BorderSizePixel = 0
box.Parent = overlay
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(60, 60, 60)
stroke.Thickness = 1
stroke.Transparency = 0.2
stroke.Parent = box


local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 20, 0, 25)
title.BackgroundTransparency = 1
title.Text = "WELCOME TO"
title.TextColor3 = Color3.fromRGB(160, 160, 160)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = box

local titleBig = Instance.new("TextLabel")
titleBig.Size = UDim2.new(1, -40, 0, 50)
titleBig.Position = UDim2.new(0, 20, 0, 50)
titleBig.BackgroundTransparency = 1
titleBig.Text = "VELARD TOOLS"
titleBig.TextColor3 = Color3.fromRGB(255, 255, 255) -- Teks Putih Bersih
titleBig.Font = Enum.Font.GothamBlack
titleBig.TextSize = 34
titleBig.TextXAlignment = Enum.TextXAlignment.Center
titleBig.Parent = box


local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -40, 0, 6)
barBg.Position = UDim2.new(0, 20, 0, 120)
barBg.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
barBg.BorderSizePixel = 0
barBg.ClipsDescendants = true
barBg.Parent = box
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(240, 240, 240) -- Putih
barFill.BorderSizePixel = 0
barFill.Parent = barBg
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

local pct = Instance.new("TextLabel")
pct.Size = UDim2.new(0, 100, 0, 16)
pct.Position = UDim2.new(1, -120, 0, 130)
pct.BackgroundTransparency = 1
pct.Text = "0%"
pct.TextColor3 = Color3.fromRGB(200, 200, 200)
pct.Font = Enum.Font.GothamMedium
pct.TextSize = 12
pct.TextXAlignment = Enum.TextXAlignment.Right
pct.Parent = box

local status = Instance.new("TextLabel")
status.Size = UDim2.new(0, 200, 0, 16)
status.Position = UDim2.new(0, 20, 0, 130)
status.BackgroundTransparency = 1
status.Text = "loading..."
status.TextColor3 = Color3.fromRGB(160, 160, 160)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = box


local DURATION = 5
TweenService:Create(
    barFill,
    TweenInfo.new(DURATION, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    { Size = UDim2.new(1, 0, 1, 0) }
):Play()

local t0 = tick()
task.spawn(function()
    while true do
        local p = math.clamp(math.floor(((tick() - t0) / DURATION) * 100), 0, 100)
        pct.Text = p .. "%"
        if p >= 100 then
            status.Text = "Menyiapkan script..."
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
gui:Destroy()


loadstring(game:HttpGet("https://shadervelard-auth.shadervelard.workers.dev/load"))()
