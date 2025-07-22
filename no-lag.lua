if identifyexecutor and identifyexecutor():lower():find("delta") then
    print("Delta")
else
    spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/greywaterstill/GAG/refs/heads/main/base.lua"))();
    end)
end

local freescripts = {
     [126884695634066] = "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Garden/Garden-V2.lua",
}
local scripts = {
    [126884695634066] = "https://api.luarmor.net/files/v3/loaders/7a953911595e67e8494c3d3446b8be5b.lua",
}

loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/untitled.lua"))()
isLoad = false
local lootlabs = "https://ads.luarmor.net/get_key?for=Lootlabs_No_Lag-WAKXwZFYPyHF"
local linkvertise = "https://ads.luarmor.net/get_key?for=Linkvertise_No_Lag-mSdMfyEDdcbV"
local rinku = "https://ads.luarmor.net/get_key?for=Rinku_No_Lag-pozgARUxinWe"
if skip_ui then
    local url = freescripts[game.PlaceId]
    if url then
        loadstring(game:HttpGetAsync(url))()
        isLoad = true
    end
end

if script_key and script_key ~= "" and script_key ~= "your_key" then
    local url = scripts[game.PlaceId]
    if url then
        loadstring(game:HttpGetAsync(url))()
        isLoad = true
    end
end
if not isLoad then
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ModernKeyUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 250)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Parent = mainFrame
shadow.ZIndex = -1

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Select No-Lag Version"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamSemibold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 40, 1, 0)
closeButton.Position = UDim2.new(1, -40, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamSemibold
closeButton.Parent = titleBar

local buttonContainer = Instance.new("Frame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Size = UDim2.new(1, -40, 0, 100)
buttonContainer.Position = UDim2.new(0, 20, 0, 60)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = mainFrame

local keylessButton = Instance.new("TextButton")
keylessButton.Name = "KeylessButton"
keylessButton.Size = UDim2.new(1, 0, 0, 45)
keylessButton.Position = UDim2.new(0, 0, 0, 55)
keylessButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
keylessButton.BorderSizePixel = 0
keylessButton.Text = "Free [🔓]"
keylessButton.TextColor3 = Color3.fromRGB(255, 255, 255)
keylessButton.TextSize = 16
keylessButton.Font = Enum.Font.GothamSemibold
keylessButton.Parent = buttonContainer

local keylessCorner = Instance.new("UICorner")
keylessCorner.CornerRadius = UDim.new(0, 8)
keylessCorner.Parent = keylessButton

local keyButton = Instance.new("TextButton")
keyButton.Name = "KeyButton"
keyButton.Size = UDim2.new(1, 0, 0, 45)
keyButton.Position = UDim2.new(0, 0, 0, 0)
keyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
keyButton.BorderSizePixel = 0
keyButton.Text = "Premium [🔑]"
keyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
keyButton.TextSize = 16
keyButton.Font = Enum.Font.GothamSemibold
keyButton.Parent = buttonContainer

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyButton

local discordButton = Instance.new("TextButton")
discordButton.Name = "DiscordButton"
discordButton.Size = UDim2.new(1, -40, 0, 40)
discordButton.Position = UDim2.new(0, 20, 0, 170)
discordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discordButton.BorderSizePixel = 0
discordButton.Text = "Join Discord"
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.TextSize = 16
discordButton.Font = Enum.Font.GothamSemibold
discordButton.Parent = mainFrame

local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 8)
discordCorner.Parent = discordButton

local function showNotification(text)
    local screenGui = gui:FindFirstChild("NotificationGui")
    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "NotificationGui"
        screenGui.Parent = gui
        screenGui.ResetOnSpawn = false
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    end
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    notification.BackgroundTransparency = 0.1
    notification.BorderSizePixel = 0
    notification.Size = UDim2.new(0.2, 0, 0.08, 0)
    notification.Position = UDim2.new(0.89, 0, 0.79, 0)
    notification.AnchorPoint = Vector2.new(0.5, 0.5)
    notification.Parent = screenGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 12)
    uiCorner.Parent = notification
    
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.Parent = notification
    shadow.ZIndex = -1
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "Text"
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 14
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
    textLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notification
    
    notification.BackgroundTransparency = 1
    textLabel.TextTransparency = 1
    
    local appearTween = TweenService:Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.1}
    )
    
    local textAppearTween = TweenService:Create(
        textLabel,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {TextTransparency = 0}
    )
    
    appearTween:Play()
    textAppearTween:Play()
    
    wait(3)
    
    local disappearTween = TweenService:Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    )
    
    local textDisappearTween = TweenService:Create(
        textLabel,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {TextTransparency = 1}
    )
    
    disappearTween:Play()
    textDisappearTween:Play()
    
    disappearTween.Completed:Connect(function()
        notification:Destroy()
    end)
end

local function makeDraggable(frame, dragHandle)
    local dragStartPos
    local frameStartPos
    local dragging = false

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStartPos = Vector2.new(input.Position.X, input.Position.Y)
            frameStartPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStartPos
            frame.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X, frameStartPos.Y.Scale,
                frameStartPos.Y.Offset + delta.Y)
        end
    end)
end

local function buttonHoverEffect(button)
    local originalColor = button.BackgroundColor3
    local hoverColor = Color3.fromRGB(
        math.min(originalColor.R * 255 + 20, 255),
        math.min(originalColor.G * 255 + 20, 255),
        math.min(originalColor.B * 255 + 20, 255)
    )

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
    end)
end

buttonHoverEffect(keylessButton)
buttonHoverEffect(keyButton)
buttonHoverEffect(discordButton)

discordButton.MouseButton1Click:Connect(function()
    TweenService:Create(discordButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -45, 0, 35)}):Play()
    wait(0.1)
    TweenService:Create(discordButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -40, 0, 40)}):Play()
    setclipboard("https://discord.gg/no-lag")
    showNotification("Discord link copied to clipboard!")
end)

keyButton.MouseButton1Click:Connect(function()
    TweenService:Create(keyButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -5, 0, 40)}):Play()
    wait(0.1)
    TweenService:Create(keyButton, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 45)}):Play()
    
    local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.3), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    
    closeTween:Play()
    closeTween.Completed:Wait()
    
    local keyFrame = Instance.new("Frame")
    keyFrame.Name = "KeyFrame"
    keyFrame.Size = UDim2.new(0, 350, 0, 350) -- Increased height to accommodate new button
    keyFrame.Position = UDim2.new(0.5, -30, 0.5, -30)
    keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    keyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    keyFrame.BackgroundTransparency = 0.1
    keyFrame.BorderSizePixel = 0
    keyFrame.ClipsDescendants = true
    keyFrame.Parent = gui

    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 12)
    keyCorner.Parent = keyFrame

    local keyShadow = Instance.new("ImageLabel")
    keyShadow.Name = "Shadow"
    keyShadow.Image = "rbxassetid://1316045217"
    keyShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    keyShadow.ImageTransparency = 0.8
    keyShadow.ScaleType = Enum.ScaleType.Slice
    keyShadow.SliceCenter = Rect.new(10, 10, 118, 118)
    keyShadow.Size = UDim2.new(1, 20, 1, 20)
    keyShadow.Position = UDim2.new(0, -10, 0, -10)
    keyShadow.BackgroundTransparency = 1
    keyShadow.Parent = keyFrame
    keyShadow.ZIndex = -1

    local keyTitleBar = Instance.new("Frame")
    keyTitleBar.Name = "TitleBar"
    keyTitleBar.Size = UDim2.new(1, 0, 0, 40)
    keyTitleBar.Position = UDim2.new(0, 0, 0, 0)
    keyTitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    keyTitleBar.BorderSizePixel = 0
    keyTitleBar.Parent = keyFrame

    local keyTitleCorner = Instance.new("UICorner")
    keyTitleCorner.CornerRadius = UDim.new(0, 12)
    keyTitleCorner.Parent = keyTitleBar

    local keyTitle = Instance.new("TextLabel")
    keyTitle.Name = "Title"
    keyTitle.Size = UDim2.new(1, -40, 1, 0)
    keyTitle.Position = UDim2.new(0, 20, 0, 0)
    keyTitle.BackgroundTransparency = 1
    keyTitle.Text = "No Lag (Premium)"
    keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyTitle.TextSize = 18
    keyTitle.Font = Enum.Font.GothamSemibold
    keyTitle.TextXAlignment = Enum.TextXAlignment.Left
    keyTitle.Parent = keyTitleBar

    local keyCloseButton = Instance.new("TextButton")
    keyCloseButton.Name = "CloseButton"
    keyCloseButton.Size = UDim2.new(0, 40, 1, 0)
    keyCloseButton.Position = UDim2.new(1, -40, 0, 0)
    keyCloseButton.BackgroundTransparency = 1
    keyCloseButton.Text = "X"
    keyCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyCloseButton.TextSize = 18
    keyCloseButton.Font = Enum.Font.GothamSemibold
    keyCloseButton.Parent = keyTitleBar

    local inputFrame = Instance.new("Frame")
    inputFrame.Name = "InputFrame"
    inputFrame.Size = UDim2.new(1, -40, 0, 40)
    inputFrame.Position = UDim2.new(0, 20, 0, 60)
    inputFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    inputFrame.BorderSizePixel = 0
    inputFrame.Parent = keyFrame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputFrame

    local inputBox = Instance.new("TextBox")
    inputBox.Name = "InputBox"
    inputBox.Size = UDim2.new(1, -20, 1, -10)
    inputBox.Position = UDim2.new(0, 10, 0, 5)
    inputBox.BackgroundTransparency = 1
    inputBox.PlaceholderText = "Enter key here..."
    inputBox.Text = ""
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextSize = 14
    inputBox.Font = Enum.Font.Gotham
    inputBox.Parent = inputFrame

    local lootlabsButton = Instance.new("TextButton")
    lootlabsButton.Name = "lootlabsButton"
    lootlabsButton.Size = UDim2.new(1, -40, 0, 40)
    lootlabsButton.Position = UDim2.new(0, 20, 0, 240) -- Adjusted position
    lootlabsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    lootlabsButton.BorderSizePixel = 0
    lootlabsButton.Text = "Get Key [Lootlabs] (12h)"
    lootlabsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    lootlabsButton.TextSize = 16
    lootlabsButton.Font = Enum.Font.GothamSemibold
    lootlabsButton.Parent = keyFrame

    local getKeyCorner = Instance.new("UICorner")
    getKeyCorner.CornerRadius = UDim.new(0, 8)
    getKeyCorner.Parent = lootlabsButton

    local linkVertiseButton = Instance.new("TextButton")
    linkVertiseButton.Name = "linkVertiseButton"
    linkVertiseButton.Size = UDim2.new(1, -40, 0, 40)
    linkVertiseButton.Position = UDim2.new(0, 20, 0, 190) -- Adjusted position
    linkVertiseButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    linkVertiseButton.BorderSizePixel = 0
    linkVertiseButton.Text = "Get Key [Linkvertise] (12h)"
    linkVertiseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    linkVertiseButton.TextSize = 16
    linkVertiseButton.Font = Enum.Font.GothamSemibold
    linkVertiseButton.Parent = keyFrame

    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 8)
    discordCorner.Parent = linkVertiseButton

    local rinkuButton = Instance.new("TextButton")
    rinkuButton.Name = "rinkuButton"
    rinkuButton.Size = UDim2.new(1, -40, 0, 40)
    rinkuButton.Position = UDim2.new(0, 20, 0, 290)
    rinkuButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    rinkuButton.BorderSizePixel = 0
    rinkuButton.Text = "Get Key [Rinku] (24h)"
    rinkuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    rinkuButton.TextSize = 16
    rinkuButton.Font = Enum.Font.GothamSemibold
    rinkuButton.Parent = keyFrame

    local rinkuCorner = Instance.new("UICorner")
    rinkuCorner.CornerRadius = UDim.new(0, 8)
    rinkuCorner.Parent = rinkuButton

    local submitButton = Instance.new("TextButton")
    submitButton.Name = "SubmitButton"
    submitButton.Size = UDim2.new(1, -40, 0, 40)
    submitButton.Position = UDim2.new(0, 20, 0, 120)
    submitButton.BackgroundColor3 = Color3.fromRGB(0,128,0)
    submitButton.BorderSizePixel = 0
    submitButton.Text = "Submit Key"
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitButton.TextSize = 16
    submitButton.Font = Enum.Font.GothamSemibold
    submitButton.Parent = keyFrame

    local submitCorner = Instance.new("UICorner")
    submitCorner.CornerRadius = UDim.new(0, 8)
    submitCorner.Parent = submitButton

    buttonHoverEffect(lootlabsButton)
    buttonHoverEffect(linkVertiseButton)
    buttonHoverEffect(rinkuButton)
    buttonHoverEffect(submitButton)

    keyCloseButton.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(keyFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })

        tween:Play()
        tween.Completed:Wait()
        keyFrame:Destroy()
    end)

    lootlabsButton.MouseButton1Click:Connect(function()
        TweenService:Create(lootlabsButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -45, 0, 35)}):Play()
        wait(0.1)
        TweenService:Create(lootlabsButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -40, 0, 40)}):Play()
        setclipboard(lootlabs)
        showNotification("Successfully Copied Lootlabs Key Link\nPaste it in your browser to continue")
    end)

    linkVertiseButton.MouseButton1Click:Connect(function()
        TweenService:Create(linkVertiseButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -45, 0, 35)}):Play()
        wait(0.1)
        TweenService:Create(linkVertiseButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -40, 0, 40)}):Play()
        setclipboard(linkvertise)
        showNotification("Successfully Copied Linkvertise Key Link\nPaste it in your browser to continue")
    end)

    rinkuButton.MouseButton1Click:Connect(function()
        TweenService:Create(rinkuButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -45, 0, 35)}):Play()
        wait(0.1)
        TweenService:Create(rinkuButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -40, 0, 40)}):Play()
        setclipboard(rinku)
        showNotification("Successfully Copied Rinku Key Link\nPaste it in your browser to continue")
    end)

    submitButton.MouseButton1Click:Connect(function()
        TweenService:Create(submitButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -45, 0, 35)}):Play()
        wait(0.1)
        TweenService:Create(submitButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -40, 0, 40)}):Play()

        local enteredKey = inputBox.Text
        local correctKeyLength = 32 
        
        if #enteredKey == correctKeyLength then
            local tween = TweenService:Create(keyFrame, TweenInfo.new(0.3), {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            })
            tween:Play()
            tween.Completed:Wait()
            keyFrame:Destroy()
            task.spawn(function()
                script_key = tostring(enteredKey)
                local url = scripts[game.PlaceId]
                if url then
                    loadstring(game:HttpGetAsync(url))()
                end
            end)
        else
            local shake1 = TweenService:Create(inputFrame, TweenInfo.new(0.05), {Position = UDim2.new(0, 25, 0, 60)})
            local shake2 = TweenService:Create(inputFrame, TweenInfo.new(0.05), {Position = UDim2.new(0, 15, 0, 60)})
            local shake3 = TweenService:Create(inputFrame, TweenInfo.new(0.05), {Position = UDim2.new(0, 20, 0, 60)})
            
            shake1:Play()
            shake1.Completed:Wait()
            shake2:Play()
            shake2.Completed:Wait()
            shake3:Play()
            
            inputFrame.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
            wait(0.5)
            inputFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        end
    end)
    makeDraggable(keyFrame, keyTitle)
end)

keylessButton.MouseButton1Click:Connect(function()
    TweenService:Create(keylessButton, TweenInfo.new(0.1), {Size = UDim2.new(1, -5, 0, 40)}):Play()
    wait(0.1)
    TweenService:Create(keylessButton, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 45)}):Play()
    
    local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.3), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    
    closeTween:Play()
    closeTween.Completed:Wait()
    
    task.spawn(function()
        local url = freescripts[game.PlaceId]
        if url then
            loadstring(game:HttpGetAsync(url))()
        end
    end)
end)

mainFrame.BackgroundTransparency = 1
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Parent = gui

closeButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    
    tween:Play()
    tween.Completed:Wait()
    gui:Destroy()
end)

makeDraggable(mainFrame, titleBar)

local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0.1,
    Size = UDim2.new(0, 350, 0, 250),
    Position = UDim2.new(0.5, -30, 0.5, -30)
})
openTween:Play()
end
