local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Game Mod Menu",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "GameModConfig",
    IntroEnabled = true,
    IntroText = "Welcome to Game Mod Menu",
    Icon = "rbxassetid://4483345998"
})

-- Main Tab (Original Template Elements)
local MainTab = Window:MakeTab({
    Name = "Main Features",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local MainSection = MainTab:AddSection({
    Name = "UI Elements"
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

-- Global State Variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Sword Mod Variables
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

-- Sword Mod Controls
local guiEnabled = false
local bronzeArg3 = 0
local gobblerArg3 = 0
local activeConnections = {}
local debounceTable = {}

-- Function to fire the SwordDamage event
local function fireSwordDamage(toolName, targetHumanoid, arg3)
    local config = SwordConfigs[toolName]
    if config then
        local args = config.args(targetHumanoid, arg3)
        LocalPlayer.Character.SwordDamage:FireServer(unpack(args))
    end
end

-- Sword Mod Toggles
SwordModTab:AddToggle({
    Name = "Enable Sword Script",
    Default = false,
    Callback = function(value)
        guiEnabled = value
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
    Default = "0",
    TextDisappear = true,
    Callback = function(value)
        bronzeArg3 = tonumber(value) or 0
    end
})

SwordModTab:AddTextbox({
    Name = "Gobbler's Pride Arg3",
    Default = "0",
    TextDisappear = true,
    Callback = function(value)
        gobblerArg3 = tonumber(value) or 0
    end
})

-- Killaura Controls
local isFunctionalityEnabled = false
local runningLoop = false

-- Get the currently equipped tool
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

-- Fire the remote on NPCs within 18 studs
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
                    task.wait(0.1)
                end
            end)
        end
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
