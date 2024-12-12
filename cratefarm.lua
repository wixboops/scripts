local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Debugging function
local function debugPrint(message)
    print("[Box Collection Debug] " .. tostring(message))
end

-- Error logging function
local function logError(message)
    warn("[Box Collection ERROR] " .. tostring(message))
end

-- Create safe platform with debug logging
local function createSafePlatform()
    debugPrint("Creating safe platform...")
    local safePlatform = Instance.new("Part")
    safePlatform.Position = Vector3.new(2000, 250, 2000)
    safePlatform.Size = Vector3.new(100, 1, 100)
    safePlatform.Anchored = true
    safePlatform.Name = "SafePlatform_Debug"
    safePlatform.Parent = workspace
    
    debugPrint("Safe platform created at: " .. tostring(safePlatform.Position))
    return safePlatform
end

-- Safe platform creation
local safePlatform = createSafePlatform()

-- Serverhop script loading with error handling
local function loadServerHopScript()
    debugPrint("Attempting to load serverhop script...")
    local success, serverHopScript = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/wixboops/scripts/refs/heads/main/serverhop.lua"))
    end)
    
    if success and serverHopScript then
        debugPrint("Serverhop script loaded successfully")
        return serverHopScript
    else
        logError("Failed to load serverhop script: " .. tostring(serverHopScript))
        return nil
    end
end

local serverHopScript = loadServerHopScript()

-- Function to teleport player above safe platform
local function resetToSafePlatform()
    debugPrint("Resetting player to safe platform")
    local success, errorMessage = pcall(function()
        humanoidRootPart.CFrame = safePlatform.CFrame * CFrame.new(0, 5, 0)
    end)
    
    if not success then
        logError("Failed to reset to safe platform: " .. tostring(errorMessage))
    end
end

-- Main box collection function with extensive debugging
local function collectBoxes()
    -- Check for Boxes folder
    local boxFolder = workspace:FindFirstChild("Boxes")
    if not boxFolder then
        logError("No 'Boxes' folder found in Workspace!")
        return
    end
    
    debugPrint("Starting box collection routine")
    debugPrint("Total boxes to collect: " .. #boxFolder:GetChildren())
    
    local boxesCollected = 0
    local startTime = tick()
    
    while #boxFolder:GetChildren() > 0 do
        for _, box in ipairs(boxFolder:GetChildren()) do
            debugPrint("Processing box: " .. tostring(box.Name))
            
            -- Safe teleport with error handling and anchoring
            local success, teleportError = pcall(function()
                -- Anchor the character
                character.HumanoidRootPart.Anchored = true
                
                -- Teleport 4 studs below the box
                humanoidRootPart.CFrame = box.CFrame * CFrame.new(0, -4, 0)
            end)
            
            if not success then
                logError("Teleport failed for box " .. tostring(box.Name) .. ": " .. tostring(teleportError))
                -- Unanchor the character in case of error
                character.HumanoidRootPart.Anchored = false
                continue  -- Skip to next box
            end
            
            -- Wait a moment to ensure teleport
            wait(0.1)
            
            local touchInterest = box:FindFirstChildOfClass("TouchInterest")
            if touchInterest then
                debugPrint("Firing TouchInterest for box: " .. tostring(box.Name))
                firetouchinterest(humanoidRootPart, box, 0)
                boxesCollected = boxesCollected + 1
            else
                logError("No TouchInterest found for box: " .. tostring(box.Name))
            end
            
            -- Unanchor after interaction
            character.HumanoidRootPart.Anchored = false
        
        end
        
        -- Periodic status update
        debugPrint("Boxes processed: " .. boxesCollected .. " / " .. #boxFolder:GetChildren())
        
        -- Recheck boxes after a full cycle
        wait(0.1)
        
        -- Safety break to prevent infinite loop
        if tick() - startTime > 300 then  -- 5-minute timeout
            logError("Box collection timeout reached")
            break
        end
    end
    
    -- Server hop if no boxes left
    if #boxFolder:GetChildren() == 0 then
        debugPrint("No boxes remaining. Initiating server hop.")
        if serverHopScript then
            serverHopScript()
        else
            logError("Cannot server hop - serverhop script failed to load")
        end
    end
    
    debugPrint("Box collection completed. Total boxes collected: " .. boxesCollected)
    resetToSafePlatform()
end

-- Main execution with error handling
local function main()
    debugPrint("Script initialized")
    
    local success, errorMessage = pcall(function()
        -- Reset to safe platform
        resetToSafePlatform()
        
        collectBoxes()

        resetToSafePlatform()
    end)
    
    if not success then
        logError("Script execution failed: " .. tostring(errorMessage))
    end
end

-- Run the main function
main()
