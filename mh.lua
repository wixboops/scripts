local player = game.Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGui"
screenGui.Parent = playerGui

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.95, -50, 0.05, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
toggleButton.Text = "▼"
toggleButton.TextSize = 24
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.BorderSizePixel = 0
toggleButton.BackgroundTransparency = 0.2

-- Dragging functionality for toggle button
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    toggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = toggleButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Cash Remote Configuration Frame
local configFrame = Instance.new("Frame")
configFrame.Name = "CashRemoteConfig"
configFrame.Parent = screenGui
configFrame.Size = UDim2.new(0.4, 0, 0.4, 0)
configFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
configFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
configFrame.Visible = false

-- Close Button for Config Frame
local closeConfigButton = Instance.new("TextButton")
closeConfigButton.Name = "CloseConfigButton"
closeConfigButton.Parent = configFrame
closeConfigButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeConfigButton.Position = UDim2.new(0.9, 0, 0, 0)
closeConfigButton.Text = "X"
closeConfigButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
closeConfigButton.TextColor3 = Color3.new(1, 1, 1)

-- Argument Inputs
local remoteConfigs = {}

for i = 1, 6 do
    -- Checkbox
    local checkbox = Instance.new("TextButton")
    checkbox.Name = "Checkbox" .. i
    checkbox.Parent = configFrame
    checkbox.Size = UDim2.new(0.1, 0, 0.1, 0)
    checkbox.Position = UDim2.new(0.05, 0, 0.2 + (i-1) * 0.15, 0)
    checkbox.Text = ""
    checkbox.BackgroundColor3 = Color3.new(1, 1, 1)
    checkbox.BorderColor3 = Color3.new(0, 0, 0)
    
    local isChecked = false
    checkbox.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        checkbox.BackgroundColor3 = isChecked and Color3.fromRGB(52, 132, 224) or Color3.new(1, 1, 1)
    end)
    
    -- Argument Input
    local argInput = Instance.new("TextBox")
    argInput.Name = "ArgInput" .. i
    argInput.Parent = configFrame
    argInput.Size = UDim2.new(0.7, 0, 0.1, 0)
    argInput.Position = UDim2.new(0.2, 0, 0.2 + (i-1) * 0.15, 0)
    argInput.PlaceholderText = "Enter Argument " .. i
    argInput.BackgroundColor3 = Color3.new(1, 1, 1)
    argInput.BorderColor3 = Color3.new(0, 0, 0)
    
    table.insert(remoteConfigs, {
        checkbox = checkbox,
        argInput = argInput
    })
end

-- Main Teleport Button
local button = Instance.new("TextButton")
button.Name = "TeleportButton"
button.Parent = screenGui
button.Size = UDim2.new(0.2, 0, 0.1, 0)
button.Position = UDim2.new(0.4, 0, 0.45, 0)
button.Text = "Toggle Teleport"
button.BackgroundColor3 = Color3.fromRGB(52, 132, 224)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.BorderSizePixel = 0

-- Cash Remote Button
local cashButton = Instance.new("TextButton")
cashButton.Name = "CashRemoteButton"
cashButton.Parent = screenGui
cashButton.Size = UDim2.new(0.2, 0, 0.1, 0)
cashButton.Position = UDim2.new(0.4, 0, 0.57, 0)
cashButton.Text = "Toggle Cash Remote"
cashButton.BackgroundColor3 = Color3.fromRGB(52, 132, 224)
cashButton.TextColor3 = Color3.new(1, 1, 1)
cashButton.Font = Enum.Font.GothamBold
cashButton.TextSize = 20
cashButton.BorderSizePixel = 0

-- Config Button
local configButton = Instance.new("TextButton")
configButton.Name = "ConfigButton"
configButton.Parent = screenGui
configButton.Size = UDim2.new(0.1, 0, 0.1, 0)
configButton.Position = UDim2.new(0.61, 0, 0.57, 0)
configButton.Text = "Config"
configButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
configButton.TextColor3 = Color3.new(1, 1, 1)
configButton.Font = Enum.Font.GothamBold
configButton.TextSize = 20
configButton.BorderSizePixel = 0

-- Gift Farm Button
local giftButton = Instance.new("TextButton")
giftButton.Name = "GiftFarmButton"
giftButton.Parent = screenGui
giftButton.Size = UDim2.new(0.2, 0, 0.1, 0)
giftButton.Position = UDim2.new(0.4, 0, 0.69, 0)
giftButton.Text = "Toggle Gift Farm"
giftButton.BackgroundColor3 = Color3.fromRGB(52, 132, 224)
giftButton.TextColor3 = Color3.new(1, 1, 1)
giftButton.Font = Enum.Font.GothamBold
giftButton.TextSize = 20
giftButton.BorderSizePixel = 0

-- Variables
local cratesFolder = workspace:WaitForChild("Game"):WaitForChild("Crates")
local enabled = false
local cashRemoteEnabled = false
local giftFarmEnabled = false
local mainButtonVisible = true

-- Toggle button functionality
toggleButton.MouseButton1Click:Connect(function()
    mainButtonVisible = not mainButtonVisible
    button.Visible = mainButtonVisible
    cashButton.Visible = mainButtonVisible
    giftButton.Visible = mainButtonVisible
    toggleButton.Text = mainButtonVisible and "▼" or "▲"
end)

-- Function to teleport crates
local function teleportCrates()
    while enabled do
        local playerCharacter = player.Character
        if not playerCharacter then 
            task.wait(1)
            continue 
        end
        
        local humanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then 
            task.wait(1)
            continue 
        end
        
        local cratesToTeleport = {}
        
        -- Find crates
        for _, crate in ipairs(cratesFolder:GetChildren()) do
            if crate:IsA("BasePart") then
                -- Temporarily disable collision with player's character
                crate.CanCollide = false
                
                table.insert(cratesToTeleport, crate)
            end
        end
        
        -- Teleport found crates
        if #cratesToTeleport > 0 then
            for _, crate in ipairs(cratesToTeleport) do
                -- Teleport
                crate.Position = humanoidRootPart.Position + Vector3.new(0, -1, 0)
                
                -- Ignore collision with character's parts
                for _, part in ipairs(playerCharacter:GetDescendants()) do
                    if part:IsA("BasePart") then
                        crate:CanCollideWith(part, false)
                    end
                end
            end
            
            -- Faster loop if crates found
            task.wait(0.05)
        else
            -- Slower loop if no crates
            task.wait(1)
        end
    end
end

-- Updated Cash Remote Function
local function handleCashRemote()
    while cashRemoteEnabled do
        local cashValue = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Interface.Leaderstats[player.Name].Cash.Text)
        
        if cashValue ~= 500 then
            -- First remote
            local args1 = {
                [1] = false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Communicator"):WaitForChild("8e5fed9f4e28b47b4ba056d8fd27892dc1614bdece558743e97b9ccc70886cd0"):InvokeServer(unpack(args1))
            
            -- Wait
            task.wait(0.6)
            
            -- Process checked remote configurations
            for _, config in ipairs(remoteConfigs) do
                if config.checkbox.BackgroundColor3 == Color3.fromRGB(52, 132, 224) and config.argInput.Text ~= "" then
                    local args2 = {
                        [1] = config.argInput.Text,
                        [2] = "Main"
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Communicator"):WaitForChild("f4210a1a721a5b1b3de31be0f8f7cd0ae37b018831fee274140adeaf32400d1b"):InvokeServer(unpack(args2))
                end
            end
        end
        
        task.wait(1)  -- Adjust this wait time as needed
    end
end

-- Gift Farm Function
local function giftFarm()
    while giftFarmEnabled do
        local character = player.Character
        if not character then 
            task.wait(1)
            continue 
        end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then 
            task.wait(1)
            continue 
        end
        
        local nearestGift = nil
        local shortestDistance = 200  -- Search within 200 studs
        
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "GIFT" and v:IsA("Tool") then
                local distance = (v:GetPivot().Position - humanoidRootPart.Position).Magnitude
                
                if distance <= shortestDistance then
                    nearestGift = v
                    shortestDistance = distance
                end
            end
        end
        
        -- If a gift is found, teleport to it
        if nearestGift then
            humanoidRootPart.CFrame = nearestGift:GetPivot()
        end
        
        task.wait(0.5)  -- Prevent excessive computation
    end
end

-- Config Button Functionality
configButton.MouseButton1Click:Connect(function()
    configFrame.Visible = not configFrame.Visible
end)

-- Close Config Button Functionality
closeConfigButton.MouseButton1Click:Connect(function()
    configFrame.Visible = false
end)

-- Teleport Button toggle functionality
button.MouseButton1Click:Connect(function()
    enabled = not enabled
    button.Text = enabled and "Stop Teleport" or "Toggle Teleport"
    button.BackgroundColor3 = enabled and Color3.fromRGB(231, 76, 60) or Color3.fromRGB(52, 132, 224)
    
    if enabled then
        task.spawn(teleportCrates)
    end
end)

-- Cash Remote Button toggle functionality
cashButton.MouseButton1Click:Connect(function()
    cashRemoteEnabled = not cashRemoteEnabled
    cashButton.Text = cashRemoteEnabled and "Stop Cash Remote" or "Toggle Cash Remote"
    cashButton.BackgroundColor3 = cashRemoteEnabled and Color3.fromRGB(231, 76, 60) or Color3.fromRGB(52, 132, 224)
    
    if cashRemoteEnabled then
        task.spawn(handleCashRemote)
    end
end)

-- Gift Farm Button toggle functionality
giftButton.MouseButton1Click:Connect(function()
    giftFarmEnabled = not giftFarmEnabled
    giftButton.Text = giftFarmEnabled and "Stop Gift Farm" or "Toggle Gift Farm"
    giftButton.BackgroundColor3 = giftFarmEnabled and Color3.fromRGB(231, 76, 60) or Color3.fromRGB(52, 132, 224)
    
    if giftFarmEnabled then
        task.spawn(giftFarm)
    end
end)
