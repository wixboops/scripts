local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = OrionLib:MakeWindow({
    Name = "v3",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "GameModConfig",
    IntroEnabled = true,
    IntroText = "Welcome to LSRPG",
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

-- State Variables
local guiEnabled = false
local bronzeArg3 = -math.huge  -- Default to original script's value
local gobblerArg3 = 1  -- Default to original script's value
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

-- Killaura functionality remains the same as in previous version...
-- (Killaura code from previous script)

-- Notification on script load
OrionLib:MakeNotification({
    Name = "Script Loaded",
    Content = "Sword Mods script initialized!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Initialize the library
OrionLib:Init()
