local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local safePlatform = Instance.new("Part")
safePlatform.Position = Vector3.new(2000, 250, 2000)
safePlatform.Size = Vector3.new(100, 1, 100)
safePlatform.Anchored = true
safePlatform.Parent = workspace

local serverHopScript = loadstring(game:HttpGet("https://raw.githubusercontent.com/wixboops/scripts/refs/heads/main/serverhop.lua"))

local function resetToSafePlatform()
    humanoidRootPart.CFrame = safePlatform.CFrame * CFrame.new(0, 5, 0)
end

local function collectBoxes()
    local boxFolder = workspace:WaitForChild("Boxes")
    
    while #boxFolder:GetChildren() > 0 do
        for _, box in ipairs(boxFolder:GetChildren()) do
            humanoidRootPart.CFrame = box.CFrame
            

            local touchInterest = box:FindFirstChildOfClass("TouchInterest")
            if touchInterest then
                firetouchinterest(humanoidRootPart, box, 0)
                wait(0.05)
            end
        end
        

        wait(0.1)
    end
    
    if #boxFolder:GetChildren() == 0 then
        serverHopScript()
    end
end


resetToSafePlatform()

collectBoxes()
