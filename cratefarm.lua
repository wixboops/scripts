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

-- Server hop functionality
local function serverHop()
    debugPrint("Starting server hop routine...")
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local File = pcall(function()
        AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
    end)

    if not File then
        table.insert(AllIDs, actualHour)
        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
    end

    local function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                delfile("NotSameServers.json")
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end

    pcall(function()
        TPReturner()
        if foundAnything ~= "" then
            TPReturner()
        end
    end)
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
        debugPrint("Confirmed no valid boxes. Initiating server hop.")
        serverHop()
        return true
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
                    wait(0.3)  -- Increased delay for consistency
                    
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
                    wait(0.3)  -- Increased delay for consistency
                end)
                
                -- Log individual box processing errors
                if not boxSuccess then
                    logError("Error processing box " .. tostring(box.Name) .. ": " .. tostring(boxError))
                end
                
                -- Periodic status update
                debugPrint("Boxes processed: " .. boxesCollected .. " / " .. #validBoxes)
                
                                -- Safety break to prevent infinite loop
                if tick() - startTime > 300 then  -- Timeout after 5 minutes
                    logError("Box collection timed out after 5 minutes.")
                    resetToSafePlatform()
                    return false
                end
            end
        end
    end)

    -- Handle global errors in box collection
    if not outerSuccess then
        logError("Global error during box collection: " .. tostring(outerError))
        resetToSafePlatform()
        return false
    end

    debugPrint(string.format("Box collection complete! Total boxes collected: %d", boxesCollected))
    return true
end

-- Start the box collection routine
local success = collectBoxes()

-- If box collection fails, initiate server hop
if not success then
    debugPrint("Box collection failed or incomplete. Initiating server hop.")
    serverHop()
end

