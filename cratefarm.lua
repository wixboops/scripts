local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Enhanced debugging function
local function debugPrint(message)
    print("[Box Collection Debug] " .. tostring(message))
end

-- Enhanced error logging function
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

-- Enhanced function to check for touch interest
local function hasTouchInterest(box)
    -- Check if the box is a valid object
    if not box or not box:IsA("BasePart") then
        debugPrint("Invalid box object: " .. tostring(box))
        return false
    end

    -- More comprehensive touch interest check
    for _, child in ipairs(box:GetChildren()) do
        if child:IsA("TouchTransmitter") then
            return true
        end
    end
    return false
end

-- Comprehensive box validation function
local function validateBoxes(boxFolder)
    debugPrint("Starting comprehensive box validation")
    
    local validBoxes = {}
    local totalBoxesChecked = 0
    
    for _, box in ipairs(boxFolder:GetChildren()) do
        totalBoxesChecked = totalBoxesChecked + 1
        
        -- Detailed validation checks
        local validationSuccess, validationResult = pcall(function()
            -- Check if box exists and is in workspace
            if not box or not box.Parent then
                debugPrint("Box removed or invalid: " .. tostring(box))
                return false
            end
            
            -- Check for touch interest
            if hasTouchInterest(box) then
                table.insert(validBoxes, box)
                debugPrint("Valid box confirmed: " .. tostring(box.Name))
                return true
            end
            
            return false
        end)
        
        -- Log any validation errors
        if not validationSuccess then
            logError("Validation error for box " .. tostring(box.Name) .. ": " .. tostring(validationResult))
        end
    end
    
    debugPrint(string.format("Box Validation Complete - Total Checked: %d, Valid Boxes: %d", 
                              totalBoxesChecked, #validBoxes))
    
    return validBoxes
end

-- Main box collection function with extensive debugging and error recovery
local function collectBoxes()
    -- Check for Boxes folder
    local boxFolder = workspace:FindFirstChild("Boxes")
    if not boxFolder then
        logError("No 'Boxes' folder found in Workspace!")
        return false
    end
    
    debugPrint("Starting box collection routine")
    
    -- Comprehensive validation of boxes
    local validBoxes = validateBoxes(boxFolder)
    
    if #validBoxes == 0 then
        debugPrint("No valid boxes found after comprehensive validation")
        
        -- Perform a second, more thorough recheck before server hopping
        wait(1)  -- Short wait to allow for any potential updates
        validBoxes = validateBoxes(boxFolder)
        
        if #validBoxes > 0 then
            -- Rerun box collection if valid boxes are found
            debugPrint("Valid boxes found after recheck. Rerunning box collection.")
            return collectBoxes()
        else
            debugPrint("Confirmed no valid boxes after recheck. Initiating server hop.")
            
            -- Send Discord webhook notification
            local webhookUrl = "https://discord.com/api/webhooks/1316590004155449436/AsT_mCmwptd1Vc8AqG5myDjmSlCMfut7Z-BsdwgC_qYl1p01SEIZLIjd2UUqKCVBUF6N"
            local webhookData = {
                ["embeds"] = {{
                    ["title"] = "Box Collection Complete",
                    ["description"] = "No valid boxes remaining. Server hopping.",
                    ["fields"] = {
                        {["name"] = "Valid Boxes Remaining", ["value"] = tostring(#validBoxes), ["inline"] = true},
                        {["name"] = "Total Boxes Collected", ["value"] = tostring(boxesCollected), ["inline"] = true},
                        {["name"] = "Server Time", ["value"] = tostring(os.date("%Y-%m-%d %H:%M:%S")), ["inline"] = true},
                    },
                    ["color"] = 0x00ff00,
                }},
            }
            local headers = {
                ["Content-Type"] = "application/json",
            }
            local response = http:RequestAsync({
                Url = webhookUrl,
                Method = "POST",
                Headers = headers,
                Body = http:JSONEncode(webhookData),
            })
            if response.Success then
                debugPrint("Discord webhook notification sent successfully.")
            else
                logError("Failed to send Discord webhook notification: " .. tostring(response.StatusCode))
            end
            
            if serverHopScript then
                serverHopScript()
            else
                logError("Cannot server hop - serverhop script failed to load")
            end
            return true
        end
    end
    
    debugPrint("Total valid boxes to collect: " .. #validBoxes)
    
    local boxesCollected = 0
    local startTime = tick()
    
    -- Use a protected call to handle potential global errors
    local outerSuccess, outerError = pcall(function()
        while #validBoxes > 0 do
            for i = #validBoxes, 1, -1 do
                local box = validBoxes[i]
                debugPrint("Processing box: " .. tostring(box.Name))
                
                -- Enhanced error handling for box processing
                local boxSuccess, boxError = pcall(function()
                    -- Verify box still exists and is valid
                    if not box or not box.Parent or not hasTouchInterest(box) then
                        logError("Box no longer valid: " .. tostring(box))
                        table.remove(validBoxes, i)
                        return
                    end
                    
                    -- Safe teleport with more detailed error handling
                    humanoidRootPart.CFrame = box.CFrame
                    wait(0.15)
                    
                    -- More robust touch interest handling
                    local touchTransmitter = box:FindFirstChildOfClass("TouchTransmitter")
                    if touchTransmitter then
                        debugPrint("Firing touch for box: " .. tostring(box.Name))
                        firetouchinterest(humanoidRootPart, box, 0)
                        boxesCollected = boxesCollected + 1
                    else
                        debugPrint("No TouchTransmitter found for box: " .. tostring(box.Name))
                    end
                    
                    -- Remove processed box
                    table.remove(validBoxes, i)
                    
                    -- Reset to safe platform between box collections
                    resetToSafePlatform()
                    wait(0.15)
                end)
                
                -- Log individual box processing errors
                if not boxSuccess then
                    logError("Error processing box " .. tostring(box.Name) .. ": " .. tostring(boxError))
                end
                
                -- Periodic status update
                debugPrint("Boxes processed: " .. boxesCollected .. " / " .. #validBoxes)
                
                -- Safety break to prevent infinite loop
                if tick() - startTime > 300 then  -- 5-minute timeout
                    logError("Box collection timeout reached")
                    return
                end
            end
            
            -- Revalidate remaining boxes before continuing
            if #validBoxes > 0 then
                local recheckBoxes = validateBoxes(boxFolder)
                if #recheckBoxes == 0 then
                    debugPrint("No valid boxes remaining after recheck. Breaking collection loop.")
                    break
                end
                validBoxes = recheckBoxes
            end
            
            -- Short wait between collection cycles
            wait(0.2)
        end
    end)
    
    -- Handle any outer-level errors
    if not outerSuccess then
        logError("Outer box collection failed: " .. tostring(outerError))
        return false
    end
    
    -- Final validation before server hopping
    if #validBoxes == 0 then
        debugPrint("No boxes remaining. Initiating server hop.")
        if serverHopScript then
            serverHopScript()
        else
            logError("Cannot server hop - serverhop script failed to load")
        end
    end
    
    debugPrint("Box collection completed. Total boxes collected: " .. boxesCollected)
    resetToSafePlatform()
    return true
end

-- Main execution with comprehensive error handling
local function main()
    debugPrint("Script initialized")
    
    local success, errorMessage = pcall(function()
        -- Reset to safe platform
        resetToSafePlatform()
        
        -- Attempt box collection with retry mechanism
        local collectionAttempts = 0
        while collectionAttempts < 3 do
            collectionAttempts = collectionAttempts + 1
            debugPrint("Box collection attempt " .. collectionAttempts)
            
            local collectionResult = collectBoxes()
            if collectionResult then
                break
            end
            
            wait(2)  -- Wait between attempts
        end

        resetToSafePlatform()
    end)
    
    if not success then
        logError("Script execution failed: " .. tostring(errorMessage))
    end
end

-- Run the main function
main()
