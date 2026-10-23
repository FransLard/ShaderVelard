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


if _G.__SHADERVELARD then
    return warn("[ShaderVelard] already loaded!")
end
_G.__SHADERVELARD = true

if typeof(getgenv) == "function" then
    local g = getgenv()
    if g.__SHADERVELARD_LOADED then
        return warn("[ShaderVelard] already loaded (genv)!")
    end
    g.__SHADERVELARD_LOADED = true
end

local latest = "https://shadervelard-auth.shadervelard.workers.dev/load"

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- ==== GUI ====
local gui = Instance.new("ScreenGui")
gui.Name = "ShaderVelardLoader"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.Parent = lp:WaitForChild("PlayerGui")

local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.25
overlay.BorderSizePixel = 0
overlay.Parent = gui

local container = Instance.new("Frame")
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.new(0.5, 0, 0.5, 0)
container.Size = UDim2.new(0, 460, 0, 150)
container.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
container.BorderSizePixel = 0
container.Parent = overlay
Instance.new("UICorner", container).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(60, 60, 60)
stroke.Thickness = 1
stroke.Transparency = 0.2
stroke.Parent = container

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 24)
title.Position = UDim2.new(0, 20, 0, 20)
title.BackgroundTransparency = 1
title.Text = "SHADERVELARD"
title.TextColor3 = Color3.fromRGB(245, 245, 245)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = container

local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -40, 0, 1)
divider.Position = UDim2.new(0, 20, 0, 52)
divider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
divider.BorderSizePixel = 0
divider.Parent = container

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 16)
status.Position = UDim2.new(0, 20, 0, 62)
status.BackgroundTransparency = 1
status.Text = "Mengarahkan ke versi terbaru..."
status.TextColor3 = Color3.fromRGB(160, 160, 160)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = container

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -40, 0, 8)
barBg.Position = UDim2.new(0, 20, 0, 88)
barBg.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
barBg.BorderSizePixel = 0
barBg.ClipsDescendants = true
barBg.Parent = container
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
barFill.BorderSizePixel = 0
barFill.Parent = barBg
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

local pctLabel = Instance.new("TextLabel")
pctLabel.Size = UDim2.new(0, 100, 0, 16)
pctLabel.Position = UDim2.new(0, 20, 0, 104)
pctLabel.BackgroundTransparency = 1
pctLabel.Text = "0%"
pctLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
pctLabel.Font = Enum.Font.GothamMedium
pctLabel.TextSize = 12
pctLabel.TextXAlignment = Enum.TextXAlignment.Left
pctLabel.Parent = container

local brandLabel = Instance.new("TextLabel")
brandLabel.Size = UDim2.new(0, 100, 0, 16)
brandLabel.Position = UDim2.new(1, -120, 0, 104)
brandLabel.BackgroundTransparency = 1
brandLabel.Text = "shadervelard"
brandLabel.TextColor3 = Color3.fromRGB(110, 110, 110)
brandLabel.Font = Enum.Font.Gotham
brandLabel.TextSize = 11
brandLabel.TextXAlignment = Enum.TextXAlignment.Right
brandLabel.Parent = container

-- ==== ANIMASI 5 DETIK ====
local duration = 5
TweenService:Create(
    barFill,
    TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    { Size = UDim2.new(1, 0, 1, 0) }
):Play()

local startTime = tick()
local running = true
task.spawn(function()
    while running do
        local pct = math.clamp(math.floor(((tick() - startTime) / duration) * 100), 0, 100)
        pctLabel.Text = pct .. "%"
        if pct >= 100 then
            status.Text = "Memuat script..."
            break
        end
        task.wait(0.03)
    end
end)

task.wait(duration)
running = false
pctLabel.Text = "100%"
status.Text = "Memuat script..."

-- ==== FADE OUT ====
local fi = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
task.spawn(function()
    TweenService:Create(overlay, fi, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(container, fi, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(stroke, fi, { Transparency = 1 }):Play()
    TweenService:Create(title, fi, { TextTransparency = 1 }):Play()
    TweenService:Create(divider, fi, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(status, fi, { TextTransparency = 1 }):Play()
    TweenService:Create(barBg, fi, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(pctLabel, fi, { TextTransparency = 1 }):Play()
    TweenService:Create(brandLabel, fi, { TextTransparency = 1 }):Play()
end)
task.wait(0.3)
gui:Destroy()

-- ==== REDIRECT KE AUTH WORKER (dengan debug) ====
warn("[SV] Memuat: " .. latest)

local body, err = pcall(function()
    return game:HttpGet(latest)
end)

if not body then
    warn("[SV] HttpGet GAGAL: " .. tostring(err))
    _G.__SHADERVELARD = false
    if typeof(getgenv) == "function" then getgenv().__SHADERVELARD_LOADED = false end
    return
end

warn("[SV] HttpGet OK, " .. #tostring(body) .. " byte")
warn("[SV] Preview: " .. tostring(body):sub(1, 200))

local ok, err2 = pcall(function()
    loadstring(tostring(body))()
end)

if not ok then
    warn("[SV] Loadstring GAGAL: " .. tostring(err2))
    _G.__SHADERVELARD = false
    if typeof(getgenv) == "function" then getgenv().__SHADERVELARD_LOADED = false end
else
    warn("[SV] Auth worker BERHASIL dijalankan")
end
