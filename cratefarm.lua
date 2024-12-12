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
    if not box or not box:IsA("BasePart") then
        debugPrint("Invalid box object: " .. tostring(box))
        return false
    end

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

        local validationSuccess, validationResult = pcall(function()
            if not box or not box.Parent then
                debugPrint("Box removed or invalid: " .. tostring(box))
                return false
            end

            if hasTouchInterest(box) then
                table.insert(validBoxes, box)
                debugPrint("Valid box confirmed: " .. tostring(box.Name))
                return true
            end

            return false
        end)

        if not validationSuccess then
            logError("Validation error for box " .. tostring(box.Name) .. ": " .. tostring(validationResult))
        end
    end

    debugPrint(string.format("Box Validation Complete - Total Checked: %d, Valid Boxes: %d", 
                              totalBoxesChecked, #validBoxes))

    return validBoxes
end

-- Server hop functionality using the provided logic
local function serverHop()
    debugPrint("Starting server hop routine...")
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    local File = pcall(function()
        AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
    end)
    if not File then
        table.insert(AllIDs, actualHour)
        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
    end
    function TPReturner()
        local Site
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        if Site.nextPageCursor then
            foundAnything = Site.nextPageCursor
        else
            foundAnything = ""
        end
        local num = 0
        for i, v in pairs(Site.data) do
            local Possible = true
            local ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _, Existing in pairs(AllIDs) do
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
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    debugPrint("Teleporting to server ID: " .. ID)
                    local success, err = pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    if not success then
                        logError("Teleport failed: " .. tostring(err))
                    end
                    return
                end
            end
        end
    end

    Teleport = function()
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end

    debugPrint("Initiating teleport sequence.")
    Teleport()
end

-- Main box collection function with extensive debugging and error recovery
local function collectBoxes()
    local boxFolder = workspace:FindFirstChild("Boxes")
    if not boxFolder then
        logError("No 'Boxes' folder found in Workspace!")
        serverHop() -- Trigger server hop if no boxes folder exists.
        return false
    end

    debugPrint("Starting box collection routine")

    local validBoxes = validateBoxes(boxFolder)

    if #validBoxes == 0 then
        debugPrint("No valid boxes found. Initiating server hop.")
        serverHop()
        return true
    end

    debugPrint("Total valid boxes to collect: " .. #validBoxes)

    local boxesCollected = 0
    local startTime = tick()

    while #validBoxes > 0 do
        for i = #validBoxes, 1, -1 do
            local box = validBoxes[i]
            debugPrint("Processing box: " .. tostring(box.Name))

            local boxSuccess, boxError = pcall(function()
                if not box or not box.Parent or not hasTouchInterest(box) then
                    debugPrint("Box no longer valid or has been removed: " .. tostring(box))
                    table.remove(validBoxes, i)
                    return
                end

                humanoidRootPart.CFrame = box.CFrame
                wait(0.3)

                local touchTransmitter = box:FindFirstChildOfClass("TouchTransmitter")
                if touchTransmitter then
                    debugPrint("Interacting with box: " .. tostring(box.Name))
                    firetouchinterest(humanoidRootPart, box, 0)
                    boxesCollected = boxesCollected + 1
                else
                    debugPrint("No TouchTransmitter found for box: " .. tostring(box.Name))
                end

                table.remove(validBoxes, i)
                resetToSafePlatform()
                wait(0.3)
            end)

            if not boxSuccess then
                logError("Error processing box " .. tostring(box.Name) .. ": " .. tostring(boxError))
            end

            debugPrint("Boxes processed: " .. boxesCollected .. " / " .. #validBoxes)

            -- Break the loop and hop servers if time exceeds 5 minutes.
            if tick() - startTime > 300 then
                logError("Box collection timed out after 5 minutes.")
                resetToSafePlatform()
                serverHop()
                return false
            end
        end
    end

    debugPrint("All boxes processed. Initiating server hop.")
    serverHop() -- Ensure server hop is called after collection loop.

    debugPrint(string.format("Box collection complete! Total boxes collected: %d", boxesCollected))
    return true
end

local success = collectBoxes()

if not success then
    debugPrint("Box collection failed or incomplete. Retrying server hop.")
    serverHop()
end
