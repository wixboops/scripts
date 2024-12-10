local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = OrionLib:MakeWindow({
    Name = "lsrpg",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "GameModConfig",
    IntroEnabled = true,
    IntroText = "Welcome to lsrpg",
    Icon = "rbxassetid://4483345998"
})

-- Sword Mod Tab
local SwordModTab = Window:MakeTab({
    Name = "Sword Mods",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local SwordModSection = SwordModTab:AddSection({
    Name = "Sword Damage Modifier"
})

-- Killaura Tab
local KillauraTab = Window:MakeTab({
    Name = "Killaura",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local KillauraSection = KillauraTab:AddSection({
    Name = "Auto Attack"
})

-- Configuration for each sword
local SwordConfigs = {
    ["Bronze"] = {
        args = function(targetHumanoid, arg3)
            return {
                [1] = targetHumanoid,
                [2] = LocalPlayer.Character["Bronze"],
                [3] = arg3 or -math.huge,
                [4] = 2,
                [5] = 0
            }
        end
    },
    ["Gobbler's Pride"] = {
        args = function(targetHumanoid, arg3)
            return {
                [1] = targetHumanoid,
                [2] = LocalPlayer.Character["Gobbler's Pride"],
                [3] = arg3 or 1,
                [4] = 2,
                [5] = 0
            }
        end
    }
}

-- State Variables for Sword Mods
local guiEnabled = false
local bronzeArg3 = -math.huge
local gobblerArg3 = 1
local activeConnections = {}
local debounceTable = {}

-- Killaura Variables
local isFunctionalityEnabled = false
local runningLoop = false

-- Function to fire the SwordDamage event
local function fireSwordDamage(toolName, targetHumanoid, arg3)
    local config = SwordConfigs[toolName]
    if config then
        local args = config.args(targetHumanoid, arg3)
        LocalPlayer.Character.SwordDamage:FireServer(unpack(args))
    end
end

-- Function to handle tool activation and touch events
local function onToolActivated(tool)
    if not guiEnabled then return end

    if SwordConfigs[tool.Name] then
        local handle = tool:FindFirstChild("Handle") or tool

        -- Clear existing connections for this tool
        if activeConnections[tool.Name] then
            activeConnections[tool.Name]:Disconnect()
            activeConnections[tool.Name] = nil
        end

        -- Reconnect touch event
        if guiEnabled then
            activeConnections[tool.Name] = handle.Touched:Connect(function(hit)
                local character = hit.Parent
                local humanoid = character and character:FindFirstChild("Humanoid")

                if humanoid and character ~= LocalPlayer.Character then
                    if not debounceTable[tool.Name] then
                        debounceTable[tool.Name] = true

                        -- Use the saved arg3 value based on the tool
                        local arg3Value = tool.Name == "Bronze" and bronzeArg3 or gobblerArg3
                        fireSwordDamage(tool.Name, humanoid, arg3Value)

                        -- Reset debounce after 0.5 seconds
                        task.delay(0.5, function()
                            debounceTable[tool.Name] = false
                        end)
                    end
                end
            end)
        end
    end
end

-- Setup tool listeners
local function setupToolListeners()
    for _, child in ipairs(LocalPlayer.Character:GetChildren()) do
        if child:IsA("Tool") and SwordConfigs[child.Name] then
            child.Activated:Connect(function()
                onToolActivated(child)
            end)
        end
    end

    LocalPlayer.Character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") and SwordConfigs[child.Name] then
            if guiEnabled then
                child.Activated:Connect(function()
                    onToolActivated(child)
                end)
            end
        end
    end)
end

-- Killaura: Get the currently equipped tool
local function getEquippedTool()
    local character = LocalPlayer.Character
    if character then
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                return tool
            end
        end
    end
    return nil
end

-- Killaura: Fire the remote on NPCs within 18 studs
local function fireOnNearbyMobs()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("SwordDamage") then
        return
    end

    local mobsFolder = workspace:FindFirstChild("Mobs")
    if not mobsFolder then
        return
    end

    local equippedTool = getEquippedTool()
    if not equippedTool then
        return
    end

    for _, mob in pairs(mobsFolder:GetChildren()) do
        if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
            local humanoid = mob.Humanoid
            local distance = (mob.HumanoidRootPart.Position - character.PrimaryPart.Position).Magnitude

            if distance <= 18 then
                local args = {
                    [1] = humanoid,
                    [2] = equippedTool,
                    [3] = 1,
                    [4] = 1,
                    [5] = 0
                }
                character:WaitForChild("SwordDamage"):FireServer(unpack(args))
            end
        end
    end
end

-- Sword Mod Toggles
SwordModTab:AddToggle({
    Name = "Enable Sword Script",
    Default = false,
    Callback = function(value)
        guiEnabled = value
        setupToolListeners()
        
        if not value then
            -- Disconnect all active connections
            for toolName, connection in pairs(activeConnections) do
                connection:Disconnect()
                activeConnections[toolName] = nil
            end
        end
    end
})

SwordModTab:AddTextbox({
    Name = "Bronze Sword Arg3",
    Default = tostring(-math.huge),
    TextDisappear = false,
    Callback = function(value)
        bronzeArg3 = tonumber(value) or -math.huge
    end
})

SwordModTab:AddTextbox({
    Name = "Gobbler's Pride Arg3",
    Default = "1",
    TextDisappear = false,
    Callback = function(value)
        gobblerArg3 = tonumber(value) or 1
    end
})

-- Killaura Toggle
KillauraTab:AddToggle({
    Name = "Enable Killaura",
    Default = false,
    Callback = function(value)
        isFunctionalityEnabled = value
        if value then
            spawn(function()
                while isFunctionalityEnabled do
                    fireOnNearbyMobs()
                    task.wait(0.2)
                end
            end)
        end
    end
})



local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local PlayerSection = PlayerTab:AddSection({
    Name = "Player Modifications"
})

-- Walkspeed Control
PlayerTab:AddTextbox({
    Name = "Walk Speed",
    Default = tostring(LocalPlayer.Character.Humanoid.WalkSpeed),
    TextDisappear = false,
    Callback = function(value)
        local speed = tonumber(value)
        if speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speed
        end
    end
})

-- Self-Damage Button
PlayerTab:AddButton({
    Name = "Self Damage",
    Callback = function()
        local character = LocalPlayer.Character
        if not character then return end
        
        local bronzeSword = character:FindFirstChild("Bronze")
        if not bronzeSword then
            -- Try to equip Bronze sword from inventory
            local backpack = LocalPlayer.Backpack
            bronzeSword = backpack:FindFirstChild("Bronze")
            if bronzeSword then
                bronzeSword.Parent = character
            else
                OrionLib:MakeNotification({
                    Name = "Error",
                    Content = "Bronze sword not found in inventory!",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
                return
            end
        end
        
        -- Fire damage remote on self
        local args = {
            [1] = character.Humanoid,
            [2] = bronzeSword,
            [3] = -math.huge,
            [4] = 2,
            [5] = 0
        }
        character.SwordDamage:FireServer(unpack(args))
    end
})

-- Notification on script load
OrionLib:MakeNotification({
    Name = "Script Loaded",
    Content = "Sword Mods and Killaura script initialized!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Initialize the library
OrionLib:Init()
