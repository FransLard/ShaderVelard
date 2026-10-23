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

local latest = "https://raw.githubusercontent.com/FransLard/ShaderVelard/refs/heads/main/ShaderVelard.lua"
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer


local gui = Instance.new("ScreenGui")
gui.Name = "ShaderVelardLoader"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = lp:WaitForChild("PlayerGui")

-- Overlay gelap
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
overlay.BackgroundTransparency = 0.25
overlay.BorderSizePixel = 0
overlay.Parent = gui


local container = Instance.new("Frame")
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.new(0.5, 0, 0.5, 0)
container.Size = UDim2.new(0, 420, 0, 130)
container.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
container.BorderSizePixel = 0
container.Parent = overlay

Instance.new("UICorner", container).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(120, 80, 255)
stroke.Thickness = 1.5
stroke.Transparency = 0.35
stroke.Parent = container


local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -32, 0, 26)
title.Position = UDim2.new(0, 16, 0, 16)
title.BackgroundTransparency = 1
title.Text = "ShaderVelard"
title.TextColor3 = Color3.fromRGB(210, 190, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = container


local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -32, 0, 16)
status.Position = UDim2.new(0, 16, 0, 42)
status.BackgroundTransparency = 1
status.Text = "Mengarahkan ke versi terbaru..."
status.TextColor3 = Color3.fromRGB(150, 150, 170)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = container


local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -32, 0, 12)
barBg.Position = UDim2.new(0, 16, 0, 72)
barBg.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
barBg.BorderSizePixel = 0
barBg.ClipsDescendants = true
barBg.Parent = container

Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBg

Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

local barGradient = Instance.new("UIGradient")
barGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 80, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 200)),
})
barGradient.Parent = barFill


local pctLabel = Instance.new("TextLabel")
pctLabel.Size = UDim2.new(1, -32, 0, 16)
pctLabel.Position = UDim2.new(0, 16, 0, 92)
pctLabel.BackgroundTransparency = 1
pctLabel.Text = "0%"
pctLabel.TextColor3 = Color3.fromRGB(190, 190, 210)
pctLabel.Font = Enum.Font.GothamMedium
pctLabel.TextSize = 12
pctLabel.TextXAlignment = Enum.TextXAlignment.Right
pctLabel.Parent = container


local duration = 3
local tween = TweenService:Create(
    barFill,
    TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    { Size = UDim2.new(1, 0, 1, 0) }
)
tween:Play()


local startTime = tick()
local running = true
task.spawn(function()
    while running do
        local elapsed = tick() - startTime
        local pct = math.clamp(math.floor((elapsed / duration) * 100), 0, 100)
        pctLabel.Text = pct .. "%"
        task.wait(0.03)
    end
end)

task.wait(duration)
running = false
pctLabel.Text = "100%"
status.Text = "Memuat script..."


task.spawn(function()
    TweenService:Create(overlay, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(container, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(stroke, TweenInfo.new(0.3), { Transparency = 1 }):Play()
    TweenService:Create(title, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
    TweenService:Create(status, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
    TweenService:Create(pctLabel, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
    TweenService:Create(barBg, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
end)
task.wait(0.3)
gui:Destroy()


local ok, err = pcall(function()
    loadstring(game:HttpGet(latest))()
end)

if not ok then
    warn("[ShaderVelard] Gagal load versi terbaru, fallback ke auth loader...")
    pcall(function()
        loadstring(game:HttpGet("https://shadervelard-auth.shadervelard.workers.dev/load"))()
    end)
end
