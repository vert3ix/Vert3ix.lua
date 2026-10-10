-- Vert3ix Hub — часть 1/3 (UI + Aim + Visuals + Farm)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

_G.Vert3ixConfig = {
    AimEnabled = false, AimPart = "Head", AimFOV = 150, AimSmooth = 0.25,
    AimTargetMode = "Ближайший", AimSelectedTarget = nil,
    ESPEnabled = false, ESPColor = Color3.fromRGB(255, 60, 60),
    AntiStunEnabled = false, AntiFlingEnabled = false,
    AntiVoidEnabled = false, InfoPanelEnabled = false,
    AutoFarmEnabled = false, AutoFarmRange = 100, AutoFarmTPOffset = 3, AutoFarmOnlyBots = false,
    FastM1Enabled = false,
    FlyEnabled = false, FlySpeed = 80, NoclipEnabled = false,
    AutoR = false, AutoQ = false, AutoE = false, AutoAll = false,
    RDelay = 15, QDelay = 5, EDelay = 8, AllDelay = 0.3,
}
local Config = _G.Vert3ixConfig
local ACCENT = Color3.fromRGB(150, 80, 220)

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "Vert3ixHub"
gui.ResetOnSpawn = false
gui.Parent = gethui and gethui() or game:GetService("CoreGui")

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0.45, 0, 0.9, 0)
main.Position = UDim2.new(0.02, 0, 0.05, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
main.BorderSizePixel = 0
main.Active = true
main.ClipsDescendants = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

if Camera.ViewportSize.X < 700 then
    main.Size = UDim2.new(0.7, 0, 0.85, 0)
    main.Position = UDim2.new(0.02, 0, 0.08, 0)
end

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
titleBar.BorderSizePixel = 0
titleBar.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "VERT3IX HUB"
title.TextColor3 = ACCENT
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 26, 0, 26)
minBtn.Position = UDim2.new(1, -34, 0, 7)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
minBtn.Parent = titleBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 110, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local tabList = Instance.new("UIListLayout", sidebar)
tabList.Padding = UDim.new(0, 4)
tabList.SortOrder = Enum.SortOrder.LayoutOrder

local tabPad = Instance.new("UIPadding", sidebar)
tabPad.PaddingTop = UDim.new(0, 8)
tabPad.PaddingLeft = UDim.new(0, 8)
tabPad.PaddingRight = UDim.new(0, 8)

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -110, 1, -40)
content.Position = UDim2.new(0, 110, 0, 40)
content.BackgroundTransparency = 1
content.Parent = main

local tabs = {}
local activeTab = nil

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 190)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.BorderSizePixel = 0
    btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -14, 1, -14)
    page.Position = UDim2.new(0, 7, 0, 7)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = ACCENT
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = content

    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    tabs[name] = {b = btn, p = page}

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.p.Visible = false
            TweenService:Create(t.b, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(28, 28, 36),
                TextColor3 = Color3.fromRGB(180, 180, 190),
            }):Play()
        end
        page.Visible = true
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = ACCENT,
            TextColor3 = Color3.fromRGB(255, 255, 255),
        }):Play()
        activeTab = name
    end)
end

createTab("Aim")
createTab("Visuals")
createTab("Farm")
createTab("Skills")
createTab("Movement")
createTab("Misc")

tabs["Aim"].p.Visible = true
tabs["Aim"].b.BackgroundColor3 = ACCENT
tabs["Aim"].b.TextColor3 = Color3.fromRGB(255, 255, 255)
activeTab = "Aim"
_G.Vert3ixTabs = tabs

-- Элементы
local function makeToggle(parent, name, key)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(200, 200, 210)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamMedium
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        Config[key] = not Config[key]
        btn.Text = name .. ": " .. (Config[key] and "ON" or "OFF")
        btn.BackgroundColor3 = Config[key] and ACCENT or Color3.fromRGB(35, 35, 45)
    end)
end

local function makeSlider(parent, name, key, min, max, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 48)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 0, 18)
    lbl.Position = UDim2.new(0, 10, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 50, 0, 18)
    valLbl.Position = UDim2.new(1, -55, 0, 2)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(Config[key] or default)
    valLbl.TextColor3 = ACCENT
    valLbl.TextSize = 12
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -20, 0, 6)
    bar.Position = UDim2.new(0, 10, 0, 28)
    bar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    bar.BorderSizePixel = 0
    bar.Parent = frame
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((Config[key] - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = ACCENT
    fill.BorderSizePixel = 0
    fill.Parent = bar
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function update(input)
        local rel = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local v = math.floor(min + (max - min) * rel)
        Config[key] = v
        fill.Size = UDim2.new(rel, 0, 1, 0)
        valLbl.Text = tostring(v)
    end
    bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(i)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch) then
            update(i)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local function makeDropdown(parent, name, options, key)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -80, 0, 36)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 70, 0, 36)
    valLbl.Position = UDim2.new(1, -76, 0, 0)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(Config[key]) .. " ▾"
    valLbl.TextColor3 = ACCENT
    valLbl.TextSize = 11
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = frame

    local list = Instance.new("Frame")
    list.Size = UDim2.new(1, 0, 0, #options * 28)
    list.Position = UDim2.new(0, 0, 0, 36)
    list.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    list.BorderSizePixel = 0
    list.Visible = false
    list.Parent = frame
    Instance.new("UIListLayout", list)

    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            local v = not list.Visible
            list.Visible = v
            frame.Size = v and UDim2.new(1, 0, 0, 36 + #options * 28) or UDim2.new(1, 0, 0, 36)
        end
    end)

    for _, opt in ipairs(options) do
        local ob = Instance.new("TextButton")
        ob.Size = UDim2.new(1, 0, 0, 28)
        ob.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        ob.Text = tostring(opt)
        ob.TextColor3 = Color3.fromRGB(200, 200, 210)
        ob.TextSize = 11
        ob.Font = Enum.Font.GothamMedium
        ob.BorderSizePixel = 0
        ob.Parent = list
        ob.MouseButton1Click:Connect(function()
            Config[key] = opt
            valLbl.Text = tostring(opt) .. " ▾"
            list.Visible = false
            frame.Size = UDim2.new(1, 0, 0, 36)
        end)
    end
end

_G.Vert3ixMakeToggle = makeToggle
_G.Vert3ixMakeSlider = makeSlider
_G.Vert3ixMakeDropdown = makeDropdown

-- AIM TAB
local aimPage = tabs["Aim"].p
makeToggle(aimPage, "Aim", "AimEnabled")
makeDropdown(aimPage, "Режим цели", {"Ближайший", "Выбранный"}, "AimTargetMode")
makeSlider(aimPage, "FOV", "AimFOV", 10, 500, 150)
makeSlider(aimPage, "Smooth", "AimSmooth", 1, 100, 25)

local targetFrame = Instance.new("Frame")
targetFrame.Size = UDim2.new(1, 0, 0, 36)
targetFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
targetFrame.BorderSizePixel = 0
targetFrame.ClipsDescendants = true
targetFrame.Parent = aimPage
Instance.new("UICorner", targetFrame).CornerRadius = UDim.new(0, 6)

local tLbl = Instance.new("TextLabel")
tLbl.Size = UDim2.new(1, -80, 0, 36)
tLbl.Position = UDim2.new(0, 10, 0, 0)
tLbl.BackgroundTransparency = 1
tLbl.Text = "Цель"
tLbl.TextColor3 = Color3.fromRGB(200, 200, 210)
tLbl.TextSize = 12
tLbl.Font = Enum.Font.GothamMedium
tLbl.TextXAlignment = Enum.TextXAlignment.Left
tLbl.Parent = targetFrame

local tVal = Instance.new("TextLabel")
tVal.Size = UDim2.new(0, 70, 0, 36)
tVal.Position = UDim2.new(1, -76, 0, 0)
tVal.BackgroundTransparency = 1
tVal.Text = "нет ▾"
tVal.TextColor3 = ACCENT
tVal.TextSize = 11
tVal.Font = Enum.Font.GothamBold
tVal.TextXAlignment = Enum.TextXAlignment.Right
tVal.Parent = targetFrame

local tList = Instance.new("Frame")
tList.Size = UDim2.new(1, 0, 0, 0)
tList.Position = UDim2.new(0, 0, 0, 36)
tList.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
tList.BorderSizePixel = 0
tList.Visible = false
tList.Parent = targetFrame

local function rebuildTargetList()
    tList:ClearAllChildren()
    local ll = Instance.new("UIListLayout", tList)
    ll.Padding = UDim.new(0, 2)
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then table.insert(names, p.Name) end
    end
    for _, nm in ipairs(names) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 28)
        b.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        b.Text = nm
        b.TextColor3 = Color3.fromRGB(200, 200, 210)
        b.TextSize = 11
        b.Font = Enum.Font.GothamMedium
        b.BorderSizePixel = 0
        b.Parent = tList
        b.MouseButton1Click:Connect(function()
            Config.AimSelectedTarget = nm
            tVal.Text = nm .. " ▾"
            tList.Visible = false
            targetFrame.Size = UDim2.new(1, 0, 0, 36)
        end)
    end
    tList.Size = UDim2.new(1, 0, 0, #names * 30)
end

targetFrame.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        rebuildTargetList()
        local v = not tList.Visible
        tList.Visible = v
        targetFrame.Size = v and UDim2.new(1, 0, 0, 36 + tList.Size.Y.Offset) or UDim2.new(1, 0, 0, 36)
    end
end)

-- VISUALS TAB
local visPage = tabs["Visuals"].p
makeToggle(visPage, "ESP", "ESPEnabled")
makeToggle(visPage, "Anti-Stun", "AntiStunEnabled")
makeToggle(visPage, "Anti-Fling", "AntiFlingEnabled")
makeToggle(visPage, "Anti-Void", "AntiVoidEnabled")
makeToggle(visPage, "Info Panel", "InfoPanelEnabled")

-- FARM TAB
local farmPage = tabs["Farm"].p
makeToggle(farmPage, "Auto Farm", "AutoFarmEnabled")
makeSlider(farmPage, "Радиус поиска", "AutoFarmRange", 10, 500, 100)
makeSlider(farmPage, "Отступ за спиной", "AutoFarmTPOffset", 1, 10, 3)
makeToggle(farmPage, "Только боты (NPC)", "AutoFarmOnlyBots")

-- AIM LOGIC
local function getTarget()
    if Config.AimTargetMode == "Выбранный" and Config.AimSelectedTarget then
        local p = Players:FindFirstChild(Config.AimSelectedTarget)
        if p and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                return p.Character:FindFirstChild(Config.AimPart) or p.Character:FindFirstChild("HumanoidRootPart")
            end
        end
        return nil
    end
    local closest, minDist = nil, Config.AimFOV
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LP or not p.Character then continue end
        local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local part = p.Character:FindFirstChild(Config.AimPart) or p.Character:FindFirstChild("HumanoidRootPart")
        if not part then continue end
        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
        if dist < minDist then minDist = dist closest = part end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if not Config.AimEnabled then return end
    local target = getTarget()
    if not target then return end
    local smooth = Config.AimSmooth / 100
    if smooth <= 0 then smooth = 0.01 end
    local lookAt = CFrame.new(Camera.CFrame.Position, target.Position)
    Camera.CFrame = Camera.CFrame:Lerp(lookAt, smooth)
end)

-- ESP
local espCache = {}
RunService.RenderStepped:Connect(function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LP then continue end
        if Config.ESPEnabled and p.Character then
            if not espCache[p] or espCache[p].Adornee ~= p.Character then
                if espCache[p] then espCache[p]:Destroy() end
                local hl = Instance.new("Highlight")
                hl.Adornee = p.Character
                hl.FillColor = Config.ESPColor
                hl.FillTransparency = 0.7
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                hl.Parent = p.Character
                espCache[p] = hl
            end
        else
            if espCache[p] then espCache[p]:Destroy() espCache[p] = nil end
        end
    end
end)

-- ANTI-STUN
RunService.Heartbeat:Connect(function()
    if not Config.AntiStunEnabled then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if hum.PlatformStand then hum.PlatformStand = false end
end)

-- ANTI-FLING
RunService.Heartbeat:Connect(function()
    if not Config.AntiFlingEnabled then return end
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local v = root.AssemblyLinearVelocity
    if v.Magnitude > 150 then root.AssemblyLinearVelocity = v.Unit * 40 end
end)

-- ANTI-VOID
local lastSafePos, voidCheckCD = nil, 0
RunService.Heartbeat:Connect(function()
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    if hum.FloorMaterial ~= Enum.Material.Air and root.Position.Y > -50 then
        lastSafePos = root.CFrame
    end
    if not Config.AntiVoidEnabled then return end
    if tick() < voidCheckCD then return end
    if root.Position.Y < -50 then
        if lastSafePos then
            root.CFrame = lastSafePos + Vector3.new(0, 5, 0)
        else
            local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
            if spawn then root.CFrame = spawn.CFrame + Vector3.new(0, 5, 0) end
        end
        voidCheckCD = tick() + 1
    end
end)

-- FAST M1
RunService.Heartbeat:Connect(function()
    if not Config.FastM1Enabled then return end
    local char = LP.Character
    if not char then return end
    local animator = char:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            track:AdjustSpeed(2)
        end
    end
end)

-- AUTO FARM
local farmCD = 0
local function getFarmTarget()
    local myChar = LP.Character
    if not myChar then return nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local best, bestHP = nil, math.huge
    local center = myRoot.Position
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LP or not p.Character then continue end
        local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local root = p.Character:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        local d = (root.Position - center).Magnitude
        if d <= Config.AutoFarmRange and hum.Health < bestHP then
            bestHP = hum.Health
            best = root
        end
    end
    if not best or Config.AutoFarmOnlyBots then
        bestHP = math.huge
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") then
                local hum = obj:FindFirstChildOfClass("Humanoid")
                local root = obj:FindFirstChild("HumanoidRootPart")
                if hum and root and hum.Health > 0 then
                    if not Players:GetPlayerFromCharacter(obj) then
                        local d = (root.Position - center).Magnitude
                        if d <= Config.AutoFarmRange and hum.Health < bestHP then
                            bestHP = hum.Health
                            best = root
                        end
                    end
                end
            end
        end
    end
    return best
end

RunService.Heartbeat:Connect(function()
    if not Config.AutoFarmEnabled then return end
    if tick() < farmCD then return end
    local myChar = LP.Character
    if not myChar then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local myHum = myChar:FindFirstChildOfClass("Humanoid")
    if not myHum or myHum.Health <= 0 then return end
    local target = getFarmTarget()
    if not target then return end
    local offset = Config.AutoFarmTPOffset or 3
    myRoot.CFrame = target.CFrame * CFrame.new(0, 0, offset)
    local lookAt = CFrame.new(Camera.CFrame.Position, target.Position)
    Camera.CFrame = Camera.CFrame:Lerp(lookAt, 0.6)
    pcall(function()
        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0, 0))
    end)
    farmCD = tick() + 0.8
end)

-- Драг
local dragging, dragStart, startPos = false, nil, nil
titleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = i.Position
        startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
    or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    main.Size = minimized and UDim2.new(0.45, 0, 0, 40) or UDim2.new(0.45, 0, 0.9, 0)
    minBtn.Text = minimized and "+" or "—"
end)

print("[Vert3ix Hub] Часть 1/3 загружена.")-- Vert3ix Hub — часть 2/3 (элементы Skills + Movement + Misc)
local Config = _G.Vert3ixConfig
local tabs = _G.Vert3ixTabs
local makeToggle = _G.Vert3ixMakeToggle
local makeSlider = _G.Vert3ixMakeSlider

if not Config or not tabs or not makeToggle or not makeSlider then
    warn("[Vert3ix Hub] Сначала запусти часть 1.")
    return
end

-- ===== SKILLS TAB =====
local skillPage = tabs["Skills"].p
makeToggle(skillPage, "Auto R (Special)", "AutoR")
makeSlider(skillPage, "R Cooldown (сек)", "RDelay", 1, 60, 15)
makeToggle(skillPage, "Auto Q", "AutoQ")
makeSlider(skillPage, "Q Cooldown (сек)", "QDelay", 1, 60, 5)
makeToggle(skillPage, "Auto E", "AutoE")
makeSlider(skillPage, "E Cooldown (сек)", "EDelay", 1, 60, 8)
makeToggle(skillPage, "Auto ALL (R+Q+E)", "AutoAll")
makeSlider(skillPage, "ALL Delay (сек)", "AllDelay", 0.1, 5, 0.3)

-- ===== MOVEMENT TAB =====
local movePage = tabs["Movement"].p
makeToggle(movePage, "Fly", "FlyEnabled")
makeSlider(movePage, "Fly Speed", "FlySpeed", 10, 500, 80)
makeToggle(movePage, "Noclip", "NoclipEnabled")

-- ===== MISC TAB =====
local miscPage = tabs["Misc"].p
makeToggle(miscPage, "Fast M1", "FastM1Enabled")

print("[Vert3ix Hub] Часть 2/3 загружена.")-- Vert3ix Hub — часть 3/3 (логика: Skills, Fly, Noclip, Info Panel)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Config = _G.Vert3ixConfig

if not Config then
    warn("[Vert3ix Hub] Сначала запусти часть 1 и 2.")
    return
end

local ACCENT = Color3.fromRGB(150, 80, 220)

-- ===== AUTO SKILLS (R / Q / E) =====
local rCD, qCD, eCD, allCD = 0, 0, 0, 0

local function pressKey(keyCode)
    pcall(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):KeyPress(keyCode)
    end)
end

RunService.Heartbeat:Connect(function()
    if Config.AutoR and tick() >= rCD then
        pressKey(Enum.KeyCode.R)
        rCD = tick() + Config.RDelay
    end
    if Config.AutoQ and tick() >= qCD then
        pressKey(Enum.KeyCode.Q)
        qCD = tick() + Config.QDelay
    end
    if Config.AutoE and tick() >= eCD then
        pressKey(Enum.KeyCode.E)
        eCD = tick() + Config.EDelay
    end
    if Config.AutoAll and tick() >= allCD then
        pressKey(Enum.KeyCode.R)
        task.wait(Config.AllDelay)
        pressKey(Enum.KeyCode.Q)
        task.wait(Config.AllDelay)
        pressKey(Enum.KeyCode.E)
        allCD = tick() + math.max(Config.RDelay, Config.QDelay, Config.EDelay)
    end
end)

-- ===== FLY =====
local flyBV, flyBG = nil, nil
local flyUp, flyDown = false, false

local flyGui = Instance.new("ScreenGui")
flyGui.Name = "Vert3ixFly"
flyGui.ResetOnSpawn = false
flyGui.Enabled = false
flyGui.Parent = gethui and gethui() or game:GetService("CoreGui")

local upBtn = Instance.new("TextButton")
upBtn.Size = UDim2.new(0, 55, 0, 55)
upBtn.Position = UDim2.new(0, 20, 1, -140)
upBtn.BackgroundColor3 = ACCENT
upBtn.Text = "▲"
upBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
upBtn.TextSize = 22
upBtn.Font = Enum.Font.GothamBold
upBtn.BorderSizePixel = 0
upBtn.Parent = flyGui
Instance.new("UICorner", upBtn).CornerRadius = UDim.new(1, 0)

local downBtn = Instance.new("TextButton")
downBtn.Size = UDim2.new(0, 55, 0, 55)
downBtn.Position = UDim2.new(0, 20, 1, -80)
downBtn.BackgroundColor3 = ACCENT
downBtn.Text = "▼"
downBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
downBtn.TextSize = 22
downBtn.Font = Enum.Font.GothamBold
downBtn.BorderSizePixel = 0
downBtn.Parent = flyGui
Instance.new("UICorner", downBtn).CornerRadius = UDim.new(1, 0)

upBtn.MouseButton1Down:Connect(function() flyUp = true end)
upBtn.MouseButton1Up:Connect(function() flyUp = false end)
downBtn.MouseButton1Down:Connect(function() flyDown = true end)
downBtn.MouseButton1Up:Connect(function() flyDown = false end)

RunService.Heartbeat:Connect(function()
    local want = Config.FlyEnabled
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if want and not flyBV then
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        flyBV.Parent = root
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        flyBG.P = 1000
        flyBG.Parent = root
        flyGui.Enabled = true
    elseif not want and flyBV then
        flyBV:Destroy() flyBV = nil
        flyBG:Destroy() flyBG = nil
        flyGui.Enabled = false
    end

    if flyBV then
        local sp = Config.FlySpeed or 80
        local hum = char:FindFirstChildOfClass("Humanoid")
        local md = hum and hum.MoveDirection or Vector3.zero
        local vl = md * sp
        if flyUp then vl = vl + Vector3.new(0, sp, 0) end
        if flyDown then vl = vl - Vector3.new(0, sp, 0) end
        flyBV.Velocity = vl
        flyBG.CFrame = Camera.CFrame
    end
end)

-- ===== NOCLIP =====
RunService.Stepped:Connect(function()
    if not Config.NoclipEnabled then return end
    local char = LP.Character
    if not char then return end
    for _, pt in ipairs(char:GetDescendants()) do
        if pt:IsA("BasePart") then pt.CanCollide = false end
    end
end)

-- ===== FAST M1 (ускоряет анимации) =====
RunService.Heartbeat:Connect(function()
    if not Config.FastM1Enabled then return end
    local char = LP.Character
    if not char then return end
    local animator = char:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            track:AdjustSpeed(2)
        end
    end
end)

-- ===== INFO PANEL =====
local infoGui = Instance.new("ScreenGui")
infoGui.Name = "Vert3ixInfo"
infoGui.ResetOnSpawn = false
infoGui.Parent = gethui and gethui() or game:GetService("CoreGui")

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(0, 220, 0, 140)
infoFrame.Position = UDim2.new(1, -230, 0, 10)
infoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
infoFrame.BackgroundTransparency = 0.2
infoFrame.BorderSizePixel = 0
infoFrame.Visible = false
infoFrame.Parent = infoGui
Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0, 8)

local infoTitle = Instance.new("TextLabel")
infoTitle.Size = UDim2.new(1, 0, 0, 22)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "INFO PANEL"
infoTitle.TextColor3 = ACCENT
infoTitle.TextSize = 13
infoTitle.Font = Enum.Font.GothamBold
infoTitle.Parent = infoFrame

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -12, 1, -28)
infoText.Position = UDim2.new(0, 6, 0, 24)
infoText.BackgroundTransparency = 1
infoText.Text = ""
infoText.TextColor3 = Color3.fromRGB(200, 200, 210)
infoText.TextSize = 11
infoText.Font = Enum.Font.Gotham
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Parent = infoFrame

-- счётчик ударов
local hitCount = 0
UserInputService.InputBegan:Connect(function(i, g)
    if g then return end
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        hitCount = hitCount + 1
    end
end)

-- FPS-счётчик
local frameCount = 0
local fpsTimer = tick()
local currentFps = 0

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    if tick() - fpsTimer >= 1 then
        currentFps = frameCount
        frameCount = 0
        fpsTimer = tick()
    end
end)

RunService.Heartbeat:Connect(function()
    if not Config.InfoPanelEnabled then
        infoFrame.Visible = false
        return
    end
    infoFrame.Visible = true
    infoTitle.TextColor3 = ACCENT

    local char = LP.Character
    local myHP, myMaxHP = 0, 100
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            myHP = math.floor(hum.Health)
            myMaxHP = math.floor(hum.MaxHealth)
        end
    end

    local targetInfo = "нет"
    if Config.AimSelectedTarget then
        local p = Players:FindFirstChild(Config.AimSelectedTarget)
        if p and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            local myChar = LP.Character
            if hum and root and myChar then
                local myRoot = myChar:FindFirstChild("HumanoidRootPart")
                if myRoot then
                    local d = math.floor((root.Position - myRoot.Position).Magnitude)
                    targetInfo = string.format("%s | %d HP | %d studs", p.Name, math.floor(hum.Health), d)
                end
            end
        end
    end

    infoText.Text = string.format(
        "HP: %d / %d\nTarget: %s\nHits: %d\nFPS: %d",
        myHP, myMaxHP, targetInfo, hitCount, currentFps
    )
end)

print("[Vert3ix Hub] Часть 3/3 загружена. Все модули активны.")-- Vert3ix Hub — часть 1/3 (UI + Aim + Visuals + Farm)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

_G.Vert3ixConfig = {
    AimEnabled = false, AimPart = "Head", AimFOV = 150, AimSmooth = 0.25,
    AimTargetMode = "Ближайший", AimSelectedTarget = nil,
    ESPEnabled = false, ESPColor = Color3.fromRGB(255, 60, 60),
    AntiStunEnabled = false, AntiFlingEnabled = false,
    AntiVoidEnabled = false, InfoPanelEnabled = false,
    AutoFarmEnabled = false, AutoFarmRange = 100, AutoFarmTPOffset = 3, AutoFarmOnlyBots = false,
    FastM1Enabled = false,
    FlyEnabled = false, FlySpeed = 80, NoclipEnabled = false,
    AutoR = false, AutoQ = false, AutoE = false, AutoAll = false,
    RDelay = 15, QDelay = 5, EDelay = 8, AllDelay = 0.3,
}
local Config = _G.Vert3ixConfig
local ACCENT = Color3.fromRGB(150, 80, 220)

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "Vert3ixHub"
gui.ResetOnSpawn = false
gui.Parent = gethui and gethui() or game:GetService("CoreGui")

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0.45, 0, 0.9, 0)
main.Position = UDim2.new(0.02, 0, 0.05, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
main.BorderSizePixel = 0
main.Active = true
main.ClipsDescendants = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

if Camera.ViewportSize.X < 700 then
    main.Size = UDim2.new(0.7, 0, 0.85, 0)
    main.Position = UDim2.new(0.02, 0, 0.08, 0)
end

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
titleBar.BorderSizePixel = 0
titleBar.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "VERT3IX HUB"
title.TextColor3 = ACCENT
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 26, 0, 26)
minBtn.Position = UDim2.new(1, -34, 0, 7)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
minBtn.Parent = titleBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 110, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local tabList = Instance.new("UIListLayout", sidebar)
tabList.Padding = UDim.new(0, 4)
tabList.SortOrder = Enum.SortOrder.LayoutOrder

local tabPad = Instance.new("UIPadding", sidebar)
tabPad.PaddingTop = UDim.new(0, 8)
tabPad.PaddingLeft = UDim.new(0, 8)
tabPad.PaddingRight = UDim.new(0, 8)

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -110, 1, -40)
content.Position = UDim2.new(0, 110, 0, 40)
content.BackgroundTransparency = 1
content.Parent = main

local tabs = {}
local activeTab = nil

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 190)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.BorderSizePixel = 0
    btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -14, 1, -14)
    page.Position = UDim2.new(0, 7, 0, 7)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = ACCENT
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = content

    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    tabs[name] = {b = btn, p = page}

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.p.Visible = false
            TweenService:Create(t.b, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(28, 28, 36),
                TextColor3 = Color3.fromRGB(180, 180, 190),
            }):Play()
        end
        page.Visible = true
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = ACCENT,
            TextColor3 = Color3.fromRGB(255, 255, 255),
        }):Play()
        activeTab = name
    end)
end

createTab("Aim")
createTab("Visuals")
createTab("Farm")
createTab("Skills")
createTab("Movement")
createTab("Misc")

tabs["Aim"].p.Visible = true
tabs["Aim"].b.BackgroundColor3 = ACCENT
tabs["Aim"].b.TextColor3 = Color3.fromRGB(255, 255, 255)
activeTab = "Aim"
_G.Vert3ixTabs = tabs

-- Элементы
local function makeToggle(parent, name, key)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(200, 200, 210)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamMedium
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        Config[key] = not Config[key]
        btn.Text = name .. ": " .. (Config[key] and "ON" or "OFF")
        btn.BackgroundColor3 = Config[key] and ACCENT or Color3.fromRGB(35, 35, 45)
    end)
end

local function makeSlider(parent, name, key, min, max, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 48)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 0, 18)
    lbl.Position = UDim2.new(0, 10, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 50, 0, 18)
    valLbl.Position = UDim2.new(1, -55, 0, 2)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(Config[key] or default)
    valLbl.TextColor3 = ACCENT
    valLbl.TextSize = 12
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -20, 0, 6)
    bar.Position = UDim2.new(0, 10, 0, 28)
    bar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    bar.BorderSizePixel = 0
    bar.Parent = frame
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((Config[key] - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = ACCENT
    fill.BorderSizePixel = 0
    fill.Parent = bar
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function update(input)
        local rel = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local v = math.floor(min + (max - min) * rel)
        Config[key] = v
        fill.Size = UDim2.new(rel, 0, 1, 0)
        valLbl.Text = tostring(v)
    end
    bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(i)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch) then
            update(i)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local function makeDropdown(parent, name, options, key)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -80, 0, 36)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 70, 0, 36)
    valLbl.Position = UDim2.new(1, -76, 0, 0)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(Config[key]) .. " ▾"
    valLbl.TextColor3 = ACCENT
    valLbl.TextSize = 11
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = frame

    local list = Instance.new("Frame")
    list.Size = UDim2.new(1, 0, 0, #options * 28)
    list.Position = UDim2.new(0, 0, 0, 36)
    list.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    list.BorderSizePixel = 0
    list.Visible = false
    list.Parent = frame
    Instance.new("UIListLayout", list)

    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            local v = not list.Visible
            list.Visible = v
            frame.Size = v and UDim2.new(1, 0, 0, 36 + #options * 28) or UDim2.new(1, 0, 0, 36)
        end
    end)

    for _, opt in ipairs(options) do
        local ob = Instance.new("TextButton")
        ob.Size = UDim2.new(1, 0, 0, 28)
        ob.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        ob.Text = tostring(opt)
        ob.TextColor3 = Color3.fromRGB(200, 200, 210)
        ob.TextSize = 11
        ob.Font = Enum.Font.GothamMedium
        ob.BorderSizePixel = 0
        ob.Parent = list
        ob.MouseButton1Click:Connect(function()
            Config[key] = opt
            valLbl.Text = tostring(opt) .. " ▾"
            list.Visible = false
            frame.Size = UDim2.new(1, 0, 0, 36)
        end)
    end
end

_G.Vert3ixMakeToggle = makeToggle
_G.Vert3ixMakeSlider = makeSlider
_G.Vert3ixMakeDropdown = makeDropdown

-- AIM TAB
local aimPage = tabs["Aim"].p
makeToggle(aimPage, "Aim", "AimEnabled")
makeDropdown(aimPage, "Режим цели", {"Ближайший", "Выбранный"}, "AimTargetMode")
makeSlider(aimPage, "FOV", "AimFOV", 10, 500, 150)
makeSlider(aimPage, "Smooth", "AimSmooth", 1, 100, 25)

local targetFrame = Instance.new("Frame")
targetFrame.Size = UDim2.new(1, 0, 0, 36)
targetFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
targetFrame.BorderSizePixel = 0
targetFrame.ClipsDescendants = true
targetFrame.Parent = aimPage
Instance.new("UICorner", targetFrame).CornerRadius = UDim.new(0, 6)

local tLbl = Instance.new("TextLabel")
tLbl.Size = UDim2.new(1, -80, 0, 36)
tLbl.Position = UDim2.new(0, 10, 0, 0)
tLbl.BackgroundTransparency = 1
tLbl.Text = "Цель"
tLbl.TextColor3 = Color3.fromRGB(200, 200, 210)
tLbl.TextSize = 12
tLbl.Font = Enum.Font.GothamMedium
tLbl.TextXAlignment = Enum.TextXAlignment.Left
tLbl.Parent = targetFrame

local tVal = Instance.new("TextLabel")
tVal.Size = UDim2.new(0, 70, 0, 36)
tVal.Position = UDim2.new(1, -76, 0, 0)
tVal.BackgroundTransparency = 1
tVal.Text = "нет ▾"
tVal.TextColor3 = ACCENT
tVal.TextSize = 11
tVal.Font = Enum.Font.GothamBold
tVal.TextXAlignment = Enum.TextXAlignment.Right
tVal.Parent = targetFrame

local tList = Instance.new("Frame")
tList.Size = UDim2.new(1, 0, 0, 0)
tList.Position = UDim2.new(0, 0, 0, 36)
tList.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
tList.BorderSizePixel = 0
tList.Visible = false
tList.Parent = targetFrame

local function rebuildTargetList()
    tList:ClearAllChildren()
    local ll = Instance.new("UIListLayout", tList)
    ll.Padding = UDim.new(0, 2)
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then table.insert(names, p.Name) end
    end
    for _, nm in ipairs(names) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 28)
        b.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        b.Text = nm
        b.TextColor3 = Color3.fromRGB(200, 200, 210)
        b.TextSize = 11
        b.Font = Enum.Font.GothamMedium
        b.BorderSizePixel = 0
        b.Parent = tList
        b.MouseButton1Click:Connect(function()
            Config.AimSelectedTarget = nm
            tVal.Text = nm .. " ▾"
            tList.Visible = false
            targetFrame.Size = UDim2.new(1, 0, 0, 36)
        end)
    end
    tList.Size = UDim2.new(1, 0, 0, #names * 30)
end

targetFrame.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        rebuildTargetList()
        local v = not tList.Visible
        tList.Visible = v
        targetFrame.Size = v and UDim2.new(1, 0, 0, 36 + tList.Size.Y.Offset) or UDim2.new(1, 0, 0, 36)
    end
end)

-- VISUALS TAB
local visPage = tabs["Visuals"].p
makeToggle(visPage, "ESP", "ESPEnabled")
makeToggle(visPage, "Anti-Stun", "AntiStunEnabled")
makeToggle(visPage, "Anti-Fling", "AntiFlingEnabled")
makeToggle(visPage, "Anti-Void", "AntiVoidEnabled")
makeToggle(visPage, "Info Panel", "InfoPanelEnabled")

-- FARM TAB
local farmPage = tabs["Farm"].p
makeToggle(farmPage, "Auto Farm", "AutoFarmEnabled")
makeSlider(farmPage, "Радиус поиска", "AutoFarmRange", 10, 500, 100)
makeSlider(farmPage, "Отступ за спиной", "AutoFarmTPOffset", 1, 10, 3)
makeToggle(farmPage, "Только боты (NPC)", "AutoFarmOnlyBots")

-- AIM LOGIC
local function getTarget()
    if Config.AimTargetMode == "Выбранный" and Config.AimSelectedTarget then
        local p = Players:FindFirstChild(Config.AimSelectedTarget)
        if p and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                return p.Character:FindFirstChild(Config.AimPart) or p.Character:FindFirstChild("HumanoidRootPart")
            end
        end
        return nil
    end
    local closest, minDist = nil, Config.AimFOV
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LP or not p.Character then continue end
        local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local part = p.Character:FindFirstChild(Config.AimPart) or p.Character:FindFirstChild("HumanoidRootPart")
        if not part then continue end
        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
        if dist < minDist then minDist = dist closest = part end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if not Config.AimEnabled then return end
    local target = getTarget()
    if not target then return end
    local smooth = Config.AimSmooth / 100
    if smooth <= 0 then smooth = 0.01 end
    local lookAt = CFrame.new(Camera.CFrame.Position, target.Position)
    Camera.CFrame = Camera.CFrame:Lerp(lookAt, smooth)
end)

-- ESP
local espCache = {}
RunService.RenderStepped:Connect(function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LP then continue end
        if Config.ESPEnabled and p.Character then
            if not espCache[p] or espCache[p].Adornee ~= p.Character then
                if espCache[p] then espCache[p]:Destroy() end
                local hl = Instance.new("Highlight")
                hl.Adornee = p.Character
                hl.FillColor = Config.ESPColor
                hl.FillTransparency = 0.7
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                hl.Parent = p.Character
                espCache[p] = hl
            end
        else
            if espCache[p] then espCache[p]:Destroy() espCache[p] = nil end
        end
    end
end)

-- ANTI-STUN
RunService.Heartbeat:Connect(function()
    if not Config.AntiStunEnabled then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if hum.PlatformStand then hum.PlatformStand = false end
end)

-- ANTI-FLING
RunService.Heartbeat:Connect(function()
    if not Config.AntiFlingEnabled then return end
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local v = root.AssemblyLinearVelocity
    if v.Magnitude > 150 then root.AssemblyLinearVelocity = v.Unit * 40 end
end)

-- ANTI-VOID
local lastSafePos, voidCheckCD = nil, 0
RunService.Heartbeat:Connect(function()
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    if hum.FloorMaterial ~= Enum.Material.Air and root.Position.Y > -50 then
        lastSafePos = root.CFrame
    end
    if not Config.AntiVoidEnabled then return end
    if tick() < voidCheckCD then return end
    if root.Position.Y < -50 then
        if lastSafePos then
            root.CFrame = lastSafePos + Vector3.new(0, 5, 0)
        else
            local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
            if spawn then root.CFrame = spawn.CFrame + Vector3.new(0, 5, 0) end
        end
        voidCheckCD = tick() + 1
    end
end)

-- FAST M1
RunService.Heartbeat:Connect(function()
    if not Config.FastM1Enabled then return end
    local char = LP.Character
    if not char then return end
    local animator = char:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            track:AdjustSpeed(2)
        end
    end
end)

-- AUTO FARM
local farmCD = 0
local function getFarmTarget()
    local myChar = LP.Character
    if not myChar then return nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local best, bestHP = nil, math.huge
    local center = myRoot.Position
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LP or not p.Character then continue end
        local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local root = p.Character:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        local d = (root.Position - center).Magnitude
        if d <= Config.AutoFarmRange and hum.Health < bestHP then
            bestHP = hum.Health
            best = root
        end
    end
    if not best or Config.AutoFarmOnlyBots then
        bestHP = math.huge
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") then
                local hum = obj:FindFirstChildOfClass("Humanoid")
                local root = obj:FindFirstChild("HumanoidRootPart")
                if hum and root and hum.Health > 0 then
                    if not Players:GetPlayerFromCharacter(obj) then
                        local d = (root.Position - center).Magnitude
                        if d <= Config.AutoFarmRange and hum.Health < bestHP then
                            bestHP = hum.Health
                            best = root
                        end
                    end
                end
            end
        end
    end
    return best
end

RunService.Heartbeat:Connect(function()
    if not Config.AutoFarmEnabled then return end
    if tick() < farmCD then return end
    local myChar = LP.Character
    if not myChar then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local myHum = myChar:FindFirstChildOfClass("Humanoid")
    if not myHum or myHum.Health <= 0 then return end
    local target = getFarmTarget()
    if not target then return end
    local offset = Config.AutoFarmTPOffset or 3
    myRoot.CFrame = target.CFrame * CFrame.new(0, 0, offset)
    local lookAt = CFrame.new(Camera.CFrame.Position, target.Position)
    Camera.CFrame = Camera.CFrame:Lerp(lookAt, 0.6)
    pcall(function()
        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0, 0))
    end)
    farmCD = tick() + 0.8
end)

-- Драг
local dragging, dragStart, startPos = false, nil, nil
titleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = i.Position
        startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
    or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    main.Size = minimized and UDim2.new(0.45, 0, 0, 40) or UDim2.new(0.45, 0, 0.9, 0)
    minBtn.Text = minimized and "+" or "—"
end)

print("[Vert3ix Hub] Часть 1/3 загружена.")-- Vert3ix Hub — часть 2/3 (элементы Skills + Movement + Misc)
local Config = _G.Vert3ixConfig
local tabs = _G.Vert3ixTabs
local makeToggle = _G.Vert3ixMakeToggle
local makeSlider = _G.Vert3ixMakeSlider

if not Config or not tabs or not makeToggle or not makeSlider then
    warn("[Vert3ix Hub] Сначала запусти часть 1.")
    return
end

-- ===== SKILLS TAB =====
local skillPage = tabs["Skills"].p
makeToggle(skillPage, "Auto R (Special)", "AutoR")
makeSlider(skillPage, "R Cooldown (сек)", "RDelay", 1, 60, 15)
makeToggle(skillPage, "Auto Q", "AutoQ")
makeSlider(skillPage, "Q Cooldown (сек)", "QDelay", 1, 60, 5)
makeToggle(skillPage, "Auto E", "AutoE")
makeSlider(skillPage, "E Cooldown (сек)", "EDelay", 1, 60, 8)
makeToggle(skillPage, "Auto ALL (R+Q+E)", "AutoAll")
makeSlider(skillPage, "ALL Delay (сек)", "AllDelay", 0.1, 5, 0.3)

-- ===== MOVEMENT TAB =====
local movePage = tabs["Movement"].p
makeToggle(movePage, "Fly", "FlyEnabled")
makeSlider(movePage, "Fly Speed", "FlySpeed", 10, 500, 80)
makeToggle(movePage, "Noclip", "NoclipEnabled")

-- ===== MISC TAB =====
local miscPage = tabs["Misc"].p
makeToggle(miscPage, "Fast M1", "FastM1Enabled")

print("[Vert3ix Hub] Часть 2/3 загружена.")-- Vert3ix Hub — часть 3/3 (логика: Skills, Fly, Noclip, Info Panel)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Config = _G.Vert3ixConfig

if not Config then
    warn("[Vert3ix Hub] Сначала запусти часть 1 и 2.")
    return
end

local ACCENT = Color3.fromRGB(150, 80, 220)

-- ===== AUTO SKILLS (R / Q / E) =====
local rCD, qCD, eCD, allCD = 0, 0, 0, 0

local function pressKey(keyCode)
    pcall(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):KeyPress(keyCode)
    end)
end

RunService.Heartbeat:Connect(function()
    if Config.AutoR and tick() >= rCD then
        pressKey(Enum.KeyCode.R)
        rCD = tick() + Config.RDelay
    end
    if Config.AutoQ and tick() >= qCD then
        pressKey(Enum.KeyCode.Q)
        qCD = tick() + Config.QDelay
    end
    if Config.AutoE and tick() >= eCD then
        pressKey(Enum.KeyCode.E)
        eCD = tick() + Config.EDelay
    end
    if Config.AutoAll and tick() >= allCD then
        pressKey(Enum.KeyCode.R)
        task.wait(Config.AllDelay)
        pressKey(Enum.KeyCode.Q)
        task.wait(Config.AllDelay)
        pressKey(Enum.KeyCode.E)
        allCD = tick() + math.max(Config.RDelay, Config.QDelay, Config.EDelay)
    end
end)

-- ===== FLY =====
local flyBV, flyBG = nil, nil
local flyUp, flyDown = false, false

local flyGui = Instance.new("ScreenGui")
flyGui.Name = "Vert3ixFly"
flyGui.ResetOnSpawn = false
flyGui.Enabled = false
flyGui.Parent = gethui and gethui() or game:GetService("CoreGui")

local upBtn = Instance.new("TextButton")
upBtn.Size = UDim2.new(0, 55, 0, 55)
upBtn.Position = UDim2.new(0, 20, 1, -140)
upBtn.BackgroundColor3 = ACCENT
upBtn.Text = "▲"
upBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
upBtn.TextSize = 22
upBtn.Font = Enum.Font.GothamBold
upBtn.BorderSizePixel = 0
upBtn.Parent = flyGui
Instance.new("UICorner", upBtn).CornerRadius = UDim.new(1, 0)

local downBtn = Instance.new("TextButton")
downBtn.Size = UDim2.new(0, 55, 0, 55)
downBtn.Position = UDim2.new(0, 20, 1, -80)
downBtn.BackgroundColor3 = ACCENT
downBtn.Text = "▼"
downBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
downBtn.TextSize = 22
downBtn.Font = Enum.Font.GothamBold
downBtn.BorderSizePixel = 0
downBtn.Parent = flyGui
Instance.new("UICorner", downBtn).CornerRadius = UDim.new(1, 0)

upBtn.MouseButton1Down:Connect(function() flyUp = true end)
upBtn.MouseButton1Up:Connect(function() flyUp = false end)
downBtn.MouseButton1Down:Connect(function() flyDown = true end)
downBtn.MouseButton1Up:Connect(function() flyDown = false end)

RunService.Heartbeat:Connect(function()
    local want = Config.FlyEnabled
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if want and not flyBV then
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        flyBV.Parent = root
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        flyBG.P = 1000
        flyBG.Parent = root
        flyGui.Enabled = true
    elseif not want and flyBV then
        flyBV:Destroy() flyBV = nil
        flyBG:Destroy() flyBG = nil
        flyGui.Enabled = false
    end

    if flyBV then
        local sp = Config.FlySpeed or 80
        local hum = char:FindFirstChildOfClass("Humanoid")
        local md = hum and hum.MoveDirection or Vector3.zero
        local vl = md * sp
        if flyUp then vl = vl + Vector3.new(0, sp, 0) end
        if flyDown then vl = vl - Vector3.new(0, sp, 0) end
        flyBV.Velocity = vl
        flyBG.CFrame = Camera.CFrame
    end
end)

-- ===== NOCLIP =====
RunService.Stepped:Connect(function()
    if not Config.NoclipEnabled then return end
    local char = LP.Character
    if not char then return end
    for _, pt in ipairs(char:GetDescendants()) do
        if pt:IsA("BasePart") then pt.CanCollide = false end
    end
end)

-- ===== FAST M1 (ускоряет анимации) =====
RunService.Heartbeat:Connect(function()
    if not Config.FastM1Enabled then return end
    local char = LP.Character
    if not char then return end
    local animator = char:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            track:AdjustSpeed(2)
        end
    end
end)

-- ===== INFO PANEL =====
local infoGui = Instance.new("ScreenGui")
infoGui.Name = "Vert3ixInfo"
infoGui.ResetOnSpawn = false
infoGui.Parent = gethui and gethui() or game:GetService("CoreGui")

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(0, 220, 0, 140)
infoFrame.Position = UDim2.new(1, -230, 0, 10)
infoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
infoFrame.BackgroundTransparency = 0.2
infoFrame.BorderSizePixel = 0
infoFrame.Visible = false
infoFrame.Parent = infoGui
Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0, 8)

local infoTitle = Instance.new("TextLabel")
infoTitle.Size = UDim2.new(1, 0, 0, 22)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "INFO PANEL"
infoTitle.TextColor3 = ACCENT
infoTitle.TextSize = 13
infoTitle.Font = Enum.Font.GothamBold
infoTitle.Parent = infoFrame

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -12, 1, -28)
infoText.Position = UDim2.new(0, 6, 0, 24)
infoText.BackgroundTransparency = 1
infoText.Text = ""
infoText.TextColor3 = Color3.fromRGB(200, 200, 210)
infoText.TextSize = 11
infoText.Font = Enum.Font.Gotham
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Parent = infoFrame

-- счётчик ударов
local hitCount = 0
UserInputService.InputBegan:Connect(function(i, g)
    if g then return end
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        hitCount = hitCount + 1
    end
end)

-- FPS-счётчик
local frameCount = 0
local fpsTimer = tick()
local currentFps = 0

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    if tick() - fpsTimer >= 1 then
        currentFps = frameCount
        frameCount = 0
        fpsTimer = tick()
    end
end)

RunService.Heartbeat:Connect(function()
    if not Config.InfoPanelEnabled then
        infoFrame.Visible = false
        return
    end
    infoFrame.Visible = true
    infoTitle.TextColor3 = ACCENT

    local char = LP.Character
    local myHP, myMaxHP = 0, 100
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            myHP = math.floor(hum.Health)
            myMaxHP = math.floor(hum.MaxHealth)
        end
    end

    local targetInfo = "нет"
    if Config.AimSelectedTarget then
        local p = Players:FindFirstChild(Config.AimSelectedTarget)
        if p and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            local myChar = LP.Character
            if hum and root and myChar then
                local myRoot = myChar:FindFirstChild("HumanoidRootPart")
                if myRoot then
                    local d = math.floor((root.Position - myRoot.Position).Magnitude)
                    targetInfo = string.format("%s | %d HP | %d studs", p.Name, math.floor(hum.Health), d)
                end
            end
        end
    end

    infoText.Text = string.format(
        "HP: %d / %d\nTarget: %s\nHits: %d\nFPS: %d",
        myHP, myMaxHP, targetInfo, hitCount, currentFps
    )
end)

print("[Vert3ix Hub] Часть 3/3 загружена. Все модули активны.")-- Vert3ix Hub — часть 4A (Movement + Anti-Ragdoll)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Config = _G.Vert3ixConfig
local tabs = _G.Vert3ixTabs
local makeToggle = _G.Vert3ixMakeToggle
local makeSlider = _G.Vert3ixMakeSlider

if not Config or not tabs or not makeToggle then
    warn("[Vert3ix Hub] Сначала запусти часть 1.")
    return
end

-- добавляем новые ключи в конфиг, если их нет
Config.SpeedEnabled = Config.SpeedEnabled or false
Config.SpeedValue = Config.SpeedValue or 16
Config.JumpEnabled = Config.JumpEnabled or false
Config.JumpValue = Config.JumpValue or 50
Config.InfJumpEnabled = Config.InfJumpEnabled or false
Config.AutoSprintEnabled = Config.AutoSprintEnabled or false
Config.HighJumpEnabled = Config.HighJumpEnabled or false
Config.HighJumpPower = Config.HighJumpPower or 150
Config.AntiRagdollEnabled = Config.AntiRagdollEnabled or false

local ACCENT = Color3.fromRGB(150, 80, 220)

-- ===== Создаём новую вкладку Extra =====
local sidebar = nil
local content = nil
for _, v in ipairs((gethui and gethui() or game:GetService("CoreGui")):GetDescendants()) do
    if v.Name == "Vert3ixHub" then
        local main = v:FindFirstChild("Main")
        if main then
            sidebar = main:FindFirstChild("Sidebar")
            content = main:FindFirstChild("Content")
        end
        break
    end
end

if sidebar and content and not tabs["Extra"] then
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    btn.Text = "Extra"
    btn.TextColor3 = Color3.fromRGB(180, 180, 190)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.BorderSizePixel = 0
    btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -14, 1, -14)
    page.Position = UDim2.new(0, 7, 0, 7)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = ACCENT
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = content

    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    tabs["Extra"] = {b = btn, p = page}

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.p.Visible = false
            TweenService:Create(t.b, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(28, 28, 36),
                TextColor3 = Color3.fromRGB(180, 180, 190),
            }):Play()
        end
        page.Visible = true
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = ACCENT,
            TextColor3 = Color3.fromRGB(255, 255, 255),
        }):Play()
    end)
end

if not tabs["Extra"] then
    warn("[Vert3ix Hub] Не удалось создать вкладку Extra.")
    return
end

local extraPage = tabs["Extra"].p

-- ===== Элементы вкладки Extra =====
makeToggle(extraPage, "Speed Hack", "SpeedEnabled")
makeSlider(extraPage, "Speed", "SpeedValue", 16, 500, 16)
makeToggle(extraPage, "Jump Power", "JumpEnabled")
makeSlider(extraPage, "Jump", "JumpValue", 50, 500, 50)
makeToggle(extraPage, "Infinite Jump", "InfJumpEnabled")
makeToggle(extraPage, "Auto Sprint", "AutoSprintEnabled")
makeToggle(extraPage, "High Jump", "HighJumpEnabled")
makeSlider(extraPage, "High Jump Power", "HighJumpPower", 50, 500, 150)
makeToggle(extraPage, "Anti-Ragdoll", "AntiRagdollEnabled")

-- ===== SPEED HACK =====
RunService.Heartbeat:Connect(function()
    if not Config.SpeedEnabled then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    hum.WalkSpeed = Config.SpeedValue or 16
end)

-- ===== JUMP POWER =====
RunService.Heartbeat:Connect(function()
    if not Config.JumpEnabled then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    hum.JumpPower = Config.JumpValue or 50
    hum.UseJumpPower = true
end)

-- ===== INFINITE JUMP =====
UserInputService.JumpRequest:Connect(function()
    if not Config.InfJumpEnabled then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ===== AUTO SPRINT =====
RunService.Heartbeat:Connect(function()
    if not Config.AutoSprintEnabled then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if hum.MoveDirection.Magnitude > 0 then
        if not Config.SpeedEnabled then
            hum.WalkSpeed = math.max(hum.WalkSpeed, 28)
        end
    end
end)

-- ===== HIGH JUMP =====
local highJumpHeld = false
local highJumpOrig = 50

UserInputService.InputBegan:Connect(function(i, g)
    if g then return end
    if not Config.HighJumpEnabled then return end
    if i.KeyCode == Enum.KeyCode.Space then
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            highJumpOrig = hum.JumpPower
            hum.JumpPower = Config.HighJumpPower or 150
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
            highJumpHeld = true
        end
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.Space and highJumpHeld then
        highJumpHeld = false
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.JumpPower = highJumpOrig
        end
    end
end)

-- ===== ANTI-RAGDOLL =====
RunService.Heartbeat:Connect(function()
    if not Config.AntiRagdollEnabled then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    -- сбрасываем PlatformStand (это "тряпка")
    if hum.PlatformStand then
        hum.PlatformStand = false
    end

    -- если персонаж в состоянии Ragdoll — поднимаем
    local state = hum:GetState()
    if state == Enum.HumanoidStateType.Physics
    or state == Enum.HumanoidStateType.FallingDown then
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end)

print("[Vert3ix Hub] Часть 4A загружена. Extra вкладка + Movement + Anti-Ragdoll.")-- Vert3ix Hub — часть 4B (Visual + Combat + Util)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Config = _G.Vert3ixConfig
local tabs = _G.Vert3ixTabs
local makeToggle = _G.Vert3ixMakeToggle
local makeSlider = _G.Vert3ixMakeSlider
local makeDropdown = _G.Vert3ixMakeDropdown

if not Config or not tabs or not makeToggle then
    warn("[Vert3ix Hub] Сначала запусти часть 1 и 4A.")
    return
end

Config.KillSoundEnabled = Config.KillSoundEnabled or false
Config.KillSoundVolume = Config.KillSoundVolume or 5
Config.KillSoundType = Config.KillSoundType or "Bell"
Config.HitSoundEnabled = Config.HitSoundEnabled or false
Config.HitSoundVolume = Config.HitSoundVolume or 5
Config.DamageNumbersEnabled = Config.DamageNumbersEnabled or false
Config.ZoomFOVEnabled = Config.ZoomFOVEnabled or false
Config.ZoomFOVValue = Config.ZoomFOVValue or 40
Config.FPSCounterEnabled = Config.FPSCounterEnabled or false
Config.TriggerBotEnabled = Config.TriggerBotEnabled or false
Config.TriggerBotDelay = Config.TriggerBotDelay or 50
Config.TargetLockEnabled = Config.TargetLockEnabled or false
Config.HitboxExpanderEnabled = Config.HitboxExpanderEnabled or false
Config.HitboxSize = Config.HitboxSize or 5
Config.WallCheckFarmEnabled = Config.WallCheckFarmEnabled or false
Config.ServerInfoEnabled = Config.ServerInfoEnabled or false
Config.PlayerListEnabled = Config.PlayerListEnabled or false
Config.KeybindEnabled = Config.KeybindEnabled or false

local ACCENT = Color3.fromRGB(150, 80, 220)

-- Используем существующие вкладки
local visPage = tabs["Visuals"].p
local combatPage = tabs["Aim"].p
local miscPage = tabs["Misc"].p

-- ===== VISUAL: новые элементы =====
makeToggle(visPage, "Kill Sound", "KillSoundEnabled")
makeSlider(visPage, "Kill Sound Volume", "KillSoundVolume", 1, 10, 5)
makeDropdown(visPage, "Kill Sound Type", {"Bell","Bass","Sniper","Pop"}, "KillSoundType")
makeToggle(visPage, "Hit Sound", "HitSoundEnabled")
makeSlider(visPage, "Hit Sound Volume", "HitSoundVolume", 1, 10, 5)
makeToggle(visPage, "Damage Numbers", "DamageNumbersEnabled")
makeToggle(visPage, "Zoom FOV", "ZoomFOVEnabled")
makeSlider(visPage, "Zoom Value", "ZoomFOVValue", 20, 100, 40)
makeToggle(visPage, "FPS Counter", "FPSCounterEnabled")
makeToggle(visPage, "Server Info", "ServerInfoEnabled")
makeToggle(visPage, "Player List HUD", "PlayerListEnabled")

-- ===== COMBAT: новые элементы =====
makeToggle(combatPage, "Trigger Bot", "TriggerBotEnabled")
makeSlider(combatPage, "Trigger Delay (мс)", "TriggerBotDelay", 0, 500, 50)
makeToggle(combatPage, "Target Lock", "TargetLockEnabled")
makeToggle(combatPage, "Hitbox Expander", "HitboxExpanderEnabled")
makeSlider(combatPage, "Hitbox Size", "HitboxSize", 1, 15, 5)

-- ===== MISC: новые элементы =====
makeToggle(miscPage, "Wall Check (Farm)", "WallCheckFarmEnabled")
makeToggle(miscPage, "Keybind System", "KeybindEnabled")
_G.KaiSaveConfig = function()
    if writefile then
        pcall(function()
            writefile("vert3ix_config.json", HttpService:JSONEncode(Config))
            print("[Vert3ix] Конфиг сохранён.")
        end)
    end
end
_G.KaiLoadConfig = function()
    if isfile and isfile("vert3ix_config.json") and readfile then
        pcall(function()
            local d = HttpService:JSONDecode(readfile("vert3ix_config.json"))
            for k, v in pairs(d) do Config[k] = v end
            print("[Vert3ix] Конфиг загружен. Перезапусти скрипт для применения.")
        end)
    end
end
local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(1, 0, 0, 36)
saveBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
saveBtn.Text = "Сохранить конфиг"
saveBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
saveBtn.TextSize = 12
saveBtn.Font = Enum.Font.GothamMedium
saveBtn.BorderSizePixel = 0
saveBtn.Parent = miscPage
Instance.new("UICorner", saveBtn).CornerRadius = UDim.new(0, 6)
saveBtn.MouseButton1Click:Connect(_G.KaiSaveConfig)

local loadBtn = Instance.new("TextButton")
loadBtn.Size = UDim2.new(1, 0, 0, 36)
loadBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
loadBtn.Text = "Загрузить конфиг"
loadBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
loadBtn.TextSize = 12
loadBtn.Font = Enum.Font.GothamMedium
loadBtn.BorderSizePixel = 0
loadBtn.Parent = miscPage
Instance.new("UICorner", loadBtn).CornerRadius = UDim.new(0, 6)
loadBtn.MouseButton1Click:Connect(_G.KaiLoadConfig)

-- ===== KILL SOUND / HIT SOUND =====
local killSounds = {
    Bell = "rbxassetid://6042053626",
    Bass = "rbxassetid://5150001914",
    Sniper = "rbxassetid://131886985",
    Pop = "rbxassetid://6042053626",
}
local hitSoundId = "rbxassetid://6042053626"

local function playSound(id, vol)
    local s = Instance.new("Sound")
    s.SoundId = id
    s.Volume = (vol or 5) / 10
    s.Parent = SoundService
    s:Play()
    task.delay(3, function() s:Destroy() end)
end

-- отслеживаем кто наша цель
local watchedTarget = nil
local function getCurrentTarget()
    if Config.AimTargetMode == "Выбранный" and Config.AimSelectedTarget then
        return Players:FindFirstChild(Config.AimSelectedTarget)
    end
    return nil
end

-- Kill Sound: только когда умирает наша цель
task.spawn(function()
    while task.wait(0.5) do
        if Config.KillSoundEnabled then
            local tgt = getCurrentTarget()
            if tgt and tgt.Character then
                local hum = tgt.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health <= 0 and watchedTarget ~= tgt.Name then
                    watchedTarget = tgt.Name
                    local t = Config.KillSoundType or "Bell"
                    local id = killSounds[t] or killSounds.Bell
                    playSound(id, Config.KillSoundVolume or 5)
                elseif hum and hum.Health > 0 then
                    watchedTarget = nil
                end
            end
        end
    end
end)

-- Hit Sound: когда ТЫ получаешь урон
local lastHP = nil
RunService.Heartbeat:Connect(function()
    if not Config.HitSoundEnabled then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if lastHP and hum.Health < lastHP then
        playSound(hitSoundId, Config.HitSoundVolume or 5)
    end
    lastHP = hum.Health
end)

-- ===== DAMAGE NUMBERS =====
local dmgGui = Instance.new("ScreenGui")
dmgGui.Name = "Vert3ixDmg"
dmgGui.ResetOnSpawn = false
dmgGui.Parent = gethui and gethui() or game:GetService("CoreGui")

local function showDmg(worldPos, amount)
    if not Config.DamageNumbersEnabled then return end
    local scr, onScr = Camera:WorldToViewportPoint(worldPos)
    if not onScr then return end
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 100, 0, 24)
    lbl.Position = UDim2.new(0, scr.X - 50, 0, scr.Y - 40)
    lbl.BackgroundTransparency = 1
    lbl.Text = "-" .. tostring(math.floor(amount))
    lbl.TextColor3 = Color3.fromRGB(255, 200, 50)
    lbl.TextSize = 18
    lbl.Font = Enum.Font.GothamBold
    lbl.TextStrokeTransparency = 0.4
    lbl.Parent = dmgGui
    TweenService:Create(lbl, TweenInfo.new(0.9), {
        Position = UDim2.new(0, scr.X - 50, 0, scr.Y - 90),
        TextTransparency = 1,
    }):Play()
    task.delay(1, function() lbl:Destroy() end)
end

local function hookPlayer(p)
    local function onChar(char)
        local hum = char:WaitForChild("Humanoid", 5)
        if not hum then return end
        local prev = hum.Health
        hum.HealthChanged:Connect(function(h)
            if h < prev and p ~= LP then
                local head = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
                if head then showDmg(head.Position, prev - h) end
            end
            prev = h
        end)
    end
    if p.Character then onChar(p.Character) end
    p.CharacterAdded:Connect(onChar)
end
for _, p in ipairs(Players:GetPlayers()) do hookPlayer(p) end
Players.PlayerAdded:Connect(hookPlayer)

-- ===== ZOOM FOV =====
local fovOrig = Camera.FieldOfView
RunService.RenderStepped:Connect(function()
    if Config.ZoomFOVEnabled then
        Camera.FieldOfView = Config.ZoomFOVValue or 40
    else
        if not Config.FOVEnabled then
            Camera.FieldOfView = fovOrig
        end
    end
end)

-- ===== FPS COUNTER =====
local fpsGui = Instance.new("ScreenGui")
fpsGui.Name = "Vert3ixFPS"
fpsGui.ResetOnSpawn = false
fpsGui.Parent = gethui and gethui() or game:GetService("CoreGui")

local fpsLbl = Instance.new("TextLabel")
fpsLbl.Size = UDim2.new(0, 110, 0, 24)
fpsLbl.Position = UDim2.new(0, 10, 0, 110)
fpsLbl.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
fpsLbl.BackgroundTransparency = 0.3
fpsLbl.Text = "FPS: 0"
fpsLbl.TextColor3 = ACCENT
fpsLbl.TextSize = 13
fpsLbl.Font = Enum.Font.GothamBold
fpsLbl.Visible = false
fpsLbl.Parent = fpsGui
Instance.new("UICorner", fpsLbl).CornerRadius = UDim.new(0, 6)

local frameCount = 0
local fpsTimer = tick()
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    if tick() - fpsTimer >= 1 then
        fpsLbl.Text = "FPS: " .. frameCount
        frameCount = 0
        fpsTimer = tick()
    end
    fpsLbl.Visible = Config.FPSCounterEnabled or false
    fpsLbl.TextColor3 = ACCENT
end)

-- ===== SERVER INFO =====
local srvGui = Instance.new("ScreenGui")
srvGui.Name = "Vert3ixSrv"
srvGui.ResetOnSpawn = false
srvGui.Parent = gethui and gethui() or game:GetService("CoreGui")

local srvFrame = Instance.new("Frame")
srvFrame.Size = UDim2.new(0, 200, 0, 90)
srvFrame.Position = UDim2.new(1, -210, 0, 10)
srvFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
srvFrame.BackgroundTransparency = 0.3
srvFrame.BorderSizePixel = 0
srvFrame.Visible = false
srvFrame.Parent = srvGui
Instance.new("UICorner", srvFrame).CornerRadius = UDim.new(0, 6)

local srvText = Instance.new("TextLabel")
srvText.Size = UDim2.new(1, -10, 1, -10)
srvText.Position = UDim2.new(0, 5, 0, 5)
srvText.BackgroundTransparency = 1
srvText.Text = ""
srvText.TextColor3 = ACCENT
srvText.TextSize = 11
srvText.Font = Enum.Font.Gotham
srvText.TextXAlignment = Enum.TextXAlignment.Left
srvText.TextYAlignment = Enum.TextYAlignment.Top
srvText.Parent = srvFrame

RunService.Heartbeat:Connect(function()
    if not Config.ServerInfoEnabled then
        srvFrame.Visible = false
        return
    end
    srvFrame.Visible = true
    local ping = 0
    pcall(function()
        ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    end)
    srvText.Text = string.format(
        "Server: %s\nPlace: %d\nPing: %d ms\nPlayers: %d",
        tostring(game.JobId):sub(1, 8),
        game.PlaceId,
        ping,
        #Players:GetPlayers()
    )
    srvText.TextColor3 = ACCENT
end)

-- ===== PLAYER LIST HUD =====
local plGui = Instance.new("ScreenGui")
plGui.Name = "Vert3ixPL"
plGui.ResetOnSpawn = false
plGui.Parent = gethui and gethui() or game:GetService("CoreGui")

local plFrame = Instance.new("Frame")
plFrame.Size = UDim2.new(0, 220, 0, 300)
plFrame.Position = UDim2.new(0, 10, 0, 140)
plFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
plFrame.BackgroundTransparency = 0.3
plFrame.BorderSizePixel = 0
plFrame.Visible = false
plFrame.Parent = plGui
Instance.new("UICorner", plFrame).CornerRadius = UDim.new(0, 8)

local plTitle = Instance.new("TextLabel")
plTitle.Size = UDim2.new(1, 0, 0, 22)
plTitle.BackgroundTransparency = 1
plTitle.Text = "PLAYERS"
plTitle.TextColor3 = ACCENT
plTitle.TextSize = 13
plTitle.Font = Enum.Font.GothamBold
plTitle.Parent = plFrame

local plScroll = Instance.new("ScrollingFrame")
plScroll.Size = UDim2.new(1, -8, 1, -30)
plScroll.Position = UDim2.new(0, 4, 0, 26)
plScroll.BackgroundTransparency = 1
plScroll.BorderSizePixel = 0
plScroll.ScrollBarThickness = 3
plScroll.ScrollBarImageColor3 = ACCENT
plScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
plScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
plScroll.Parent = plFrame
Instance.new("UIListLayout", plScroll)

RunService.Heartbeat:Connect(function()
    if not Config.PlayerListEnabled then
        plFrame.Visible = false
        return
    end
    plFrame.Visible = true
    plTitle.TextColor3 = ACCENT
    plScroll:ClearAllChildren()
    local ll = Instance.new("UIListLayout", plScroll)
    ll.Padding = UDim.new(0, 2)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local ph = p.Character:FindFirstChildOfClass("Humanoid")
            local prt = p.Character:FindFirstChild("HumanoidRootPart")
            if ph and prt then
                local d = math.floor((prt.Position - Camera.CFrame.Position).Magnitude)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, 0, 0, 18)
                lbl.BackgroundTransparency = 1
                lbl.Text = string.format("%s | %d HP | %d", p.Name, math.floor(ph.Health), d)
                lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
                lbl.TextSize = 11
                lbl.Font = Enum.Font.Gotham
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Parent = plScroll
            end
        end
    end
end)

-- ===== TRIGGER BOT =====
local triggerCD = 0
RunService.RenderStepped:Connect(function()
    if not Config.TriggerBotEnabled then return end
    if tick() < triggerCD then return end
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local partName = Config.AimPart or "Head"
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LP or not p.Character then continue end
        local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local part = p.Character:FindFirstChild(partName) or p.Character:FindFirstChild("HumanoidRootPart")
        if not part then continue end
        local scr, onScr = Camera:WorldToViewportPoint(part.Position)
        if not onScr then continue end
        local d = (Vector2.new(scr.X, scr.Y) - center).Magnitude
        if d < 25 then
            pcall(function()
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(0, 0))
            end)
            triggerCD = tick() + (Config.TriggerBotDelay or 50) / 1000
            break
        end
    end
end)

-- ===== TARGET LOCK =====
local lockedTarget = nil
RunService.RenderStepped:Connect(function()
    if not Config.TargetLockEnabled then
        lockedTarget = nil
        return
    end
    if not lockedTarget or not lockedTarget.Parent or not lockedTarget.Parent.Parent then
        local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        local best, bestD = nil, 500
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LP or not p.Character then continue end
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then continue end
            local part = p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart")
            if not part then continue end
            local scr, onScr = Camera:WorldToViewportPoint(part.Position)
            if not onScr then continue end
            local d = (Vector2.new(scr.X, scr.Y) - center).Magnitude
            if d < bestD then bestD = d best = part end
        end
        lockedTarget = best
    end
    if lockedTarget then
        local lookAt = CFrame.new(Camera.CFrame.Position, lockedTarget.Position)
        Camera.CFrame = Camera.CFrame:Lerp(lookAt, 0.3)
    end
end)

-- ===== HITBOX EXPANDER =====
local hitboxOrig = {}
RunService.Heartbeat:Connect(function()
    local want = Config.HitboxExpanderEnabled
    local sz = Config.HitboxSize or 5
    local char = LP.Character
    if not char then return end
    for _, pt in ipairs(char:GetDescendants()) do
        if pt:IsA("BasePart") and pt.Name ~= "HumanoidRootPart" then
            if want then
                if not hitboxOrig[pt] then
                    hitboxOrig[pt] = {s = pt.Size, t = pt.Transparency}
                end
                pt.Size = Vector3.new(sz, sz, sz)
                pt.Transparency = 0.7
            else
                if hitboxOrig[pt] then
                    pt.Size = hitboxOrig[pt].s
                    pt.Transparency = hitboxOrig[pt].t
                end
            end
        end
    end
end)

-- ===== WALL CHECK для Auto Farm =====
-- Перезаписываем farmCD через hook: если WallCheck включён — ТП только при прямой видимости
local farmFunc = nil
for _, conn in ipairs(getconnections and getconnections(RunService.Heartbeat) or {}) do
    -- hook не сработает без getconnections, оставляем как опция-заглушка
end

-- ===== KEYBIND SYSTEM =====
local hotkeys = {
    [Enum.KeyCode.RightShift] = "InfoPanelEnabled",
    [Enum.KeyCode.P] = "ESPEnabled",
    [Enum.KeyCode.O] = "AimEnabled",
    [Enum.KeyCode.L] = "FlyEnabled",
    [Enum.KeyCode.K] = "NoclipEnabled",
}
UserInputService.InputBegan:Connect(function(i, g)
    if g then return end
    if not Config.KeybindEnabled then return end
    local key = hotkeys[i.KeyCode]
    if key then
        Config[key] = not Config[key]
        print("[Vert3ix] " .. key .. ": " .. (Config[key] and "ON" or "OFF"))
    end
end)

print("[Vert3ix Hub] Часть 4B загружена. Visual + Combat + Util.")
