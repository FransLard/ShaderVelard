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



if _G.__SV_LOADED then
    return
end
_G.__SV_LOADED = true

local URL = "https://shadervelard-auth.shadervelard.workers.dev/load"

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- ==== GUI ====
local gui = Instance.new("ScreenGui")
gui.Name = "ShaderVelardLoader"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = lp:WaitForChild("PlayerGui")

local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.25
overlay.BorderSizePixel = 0
overlay.Parent = gui

local box = Instance.new("Frame")
box.AnchorPoint = Vector2.new(0.5, 0.5)
box.Position = UDim2.new(0.5, 0, 0.5, 0)
box.Size = UDim2.new(0, 460, 0, 150)
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
title.Size = UDim2.new(1, -40, 0, 24)
title.Position = UDim2.new(0, 20, 0, 20)
title.BackgroundTransparency = 1
title.Text = "SHADERVELARD"
title.TextColor3 = Color3.fromRGB(245, 245, 245)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = box

local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -40, 0, 1)
divider.Position = UDim2.new(0, 20, 0, 52)
divider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
divider.BorderSizePixel = 0
divider.Parent = box

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 16)
status.Position = UDim2.new(0, 20, 0, 62)
status.BackgroundTransparency = 1
status.Text = "Memuat..."
status.TextColor3 = Color3.fromRGB(160, 160, 160)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = box

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -40, 0, 8)
barBg.Position = UDim2.new(0, 20, 0, 88)
barBg.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
barBg.BorderSizePixel = 0
barBg.ClipsDescendants = true
barBg.Parent = box
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
barFill.BorderSizePixel = 0
barFill.Parent = barBg
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

local pct = Instance.new("TextLabel")
pct.Size = UDim2.new(0, 100, 0, 16)
pct.Position = UDim2.new(0, 20, 0, 104)
pct.BackgroundTransparency = 1
pct.Text = "0%"
pct.TextColor3 = Color3.fromRGB(200, 200, 200)
pct.Font = Enum.Font.GothamMedium
pct.TextSize = 12
pct.TextXAlignment = Enum.TextXAlignment.Left
pct.Parent = box

local brand = Instance.new("TextLabel")
brand.Size = UDim2.new(0, 100, 0, 16)
brand.Position = UDim2.new(1, -120, 0, 104)
brand.BackgroundTransparency = 1
brand.Text = "shadervelard"
brand.TextColor3 = Color3.fromRGB(110, 110, 110)
brand.Font = Enum.Font.Gotham
brand.TextSize = 11
brand.TextXAlignment = Enum.TextXAlignment.Right
brand.Parent = box

-- ==== ANIMASI 5 DETIK ====
local duration = 5
TweenService:Create(
    barFill,
    TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    { Size = UDim2.new(1, 0, 1, 0) }
):Play()

local t0 = tick()
task.spawn(function()
    while true do
        local p = math.clamp(math.floor(((tick() - t0) / duration) * 100), 0, 100)
        pct.Text = p .. "%"
        if p >= 100 then break end
        task.wait(0.03)
    end
end)

task.wait(duration)
pct.Text = "100%"
status.Text = "Memuat script..."

-- ==== FADE OUT ====
local fi = TweenInfo.new(0.3)
TweenService:Create(overlay, fi, { BackgroundTransparency = 1 }):Play()
TweenService:Create(box, fi, { BackgroundTransparency = 1 }):Play()
TweenService:Create(stroke, fi, { Transparency = 1 }):Play()
TweenService:Create(title, fi, { TextTransparency = 1 }):Play()
TweenService:Create(divider, fi, { BackgroundTransparency = 1 }):Play()
TweenService:Create(status, fi, { TextTransparency = 1 }):Play()
TweenService:Create(barBg, fi, { BackgroundTransparency = 1 }):Play()
TweenService:Create(pct, fi, { TextTransparency = 1 }):Play()
TweenService:Create(brand, fi, { TextTransparency = 1 }):Play()
task.wait(0.35)
gui:Destroy()

-- ==== LOAD DENGAN ERROR DI LAYAR ====
local function showError(msg)
    local e = Instance.new("ScreenGui")
    e.Name = "ShaderVelardError"
    e.ResetOnSpawn = false
    e.IgnoreGuiInset = true
    e.DisplayOrder = 1000
    e.Parent = lp:WaitForChild("PlayerGui")

    local f = Instance.new("Frame")
    f.AnchorPoint = Vector2.new(0.5, 0.5)
    f.Position = UDim2.new(0.5, 0, 0.5, 0)
    f.Size = UDim2.new(0, 500, 0, 200)
    f.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
    f.BorderSizePixel = 0
    f.Parent = e
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -20, 0, 30)
    t.Position = UDim2.new(0, 10, 0, 10)
    t.BackgroundTransparency = 1
    t.Text = "ShaderVelard — Error"
    t.TextColor3 = Color3.fromRGB(255, 120, 120)
    t.Font = Enum.Font.GothamBold
    t.TextSize = 16
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = f

    local m = Instance.new("TextLabel")
    m.Size = UDim2.new(1, -20, 1, -60)
    m.Position = UDim2.new(0, 10, 0, 40)
    m.BackgroundTransparency = 1
    m.Text = msg
    m.TextColor3 = Color3.fromRGB(230, 230, 230)
    m.Font = Enum.Font.Code
    m.TextSize = 12
    m.TextWrapped = true
    m.TextXAlignment = Enum.TextXAlignment.Left
    m.TextYAlignment = Enum.TextYAlignment.Top
    m.Parent = f

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 100, 0, 28)
    close.Position = UDim2.new(1, -110, 1, -38)
    close.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    close.Text = "Tutup"
    close.TextColor3 = Color3.new(1, 1, 1)
    close.Font = Enum.Font.Gotham
    close.TextSize = 13
    close.Parent = f
    Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)
    close.MouseButton1Click:Connect(function() e:Destroy() end)
end

-- Step 1: HttpGet
local ok1, body = pcall(function()
    return game:HttpGet(URL)
end)

if not ok1 then
    showError("HttpGet gagal:\n\n" .. tostring(body))
    return
end

if type(body) ~= "string" or #body < 10 then
    showError("Response kosong / terlalu pendek:\n\n" .. tostring(body))
    return
end

-- Step 2: cek apakah HTML
if body:sub(1, 1) == "<" then
    showError("Server mengembalikan HTML, bukan Lua.\nURL salah atau worker error.\n\nPreview:\n" .. body:sub(1, 300))
    return
end

-- Step 3: loadstring
local fn, compErr = loadstring(body)
if not fn then
    showError("Syntax error di script:\n\n" .. tostring(compErr) .. "\n\nPreview:\n" .. body:sub(1, 300))
    return
end

-- Step 4: jalankan
local ok2, runErr = pcall(fn)
if not ok2 then
    showError("Error saat menjalankan:\n\n" .. tostring(runErr))
    return
end
