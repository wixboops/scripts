--////////////////////////////////////////////////////////////
-- SERVICES
--////////////////////////////////////////////////////////////
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--////////////////////////////////////////////////////////////
-- DEFAULT CONFIG
--////////////////////////////////////////////////////////////
local Config = {
	Enabled = false,
	Range = 15,
	Interval = 0.2,
	NPCName = "Bandit Leader [BOSS]",
	ShowVisual = true
}

--////////////////////////////////////////////////////////////
-- GUI
--////////////////////////////////////////////////////////////
local gui = Instance.new("ScreenGui")
gui.Name = "AutoAttackGUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(260, 220)
frame.Position = UDim2.fromOffset(20, 200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local function makeLabel(text, y)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.fromScale(1, 0)
	lbl.Position = UDim2.fromOffset(0, y)
	lbl.AutomaticSize = Enum.AutomaticSize.Y
	lbl.TextWrapped = true
	lbl.Text = text
	lbl.TextColor3 = Color3.new(1,1,1)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 13
	lbl.Parent = frame
	return lbl
end

local function makeBox(text, y, default)
	local box = Instance.new("TextBox")
	box.Size = UDim2.fromOffset(220, 28)
	box.Position = UDim2.fromOffset(20, y)
	box.Text = tostring(default)
	box.PlaceholderText = text
	box.Font = Enum.Font.Gotham
	box.TextSize = 13
	box.TextColor3 = Color3.new(1,1,1)
	box.BackgroundColor3 = Color3.fromRGB(40,40,40)
	box.Parent = frame
	Instance.new("UICorner", box)
	return box
end

makeLabel("Auto NPC Attack", 10).TextSize = 16

local rangeBox = makeBox("Range (studs)", 40, Config.Range)
local intervalBox = makeBox("Interval (seconds)", 75, Config.Interval)
local npcBox = makeBox("NPC Name", 110, Config.NPCName)

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.fromOffset(220, 32)
toggleBtn.Position = UDim2.fromOffset(20, 150)
toggleBtn.Text = "OFF"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Parent = frame
Instance.new("UICorner", toggleBtn)

local visualBtn = Instance.new("TextButton")
visualBtn.Size = UDim2.fromOffset(220, 28)
visualBtn.Position = UDim2.fromOffset(20, 190)
visualBtn.Text = "Visual: ON"
visualBtn.Font = Enum.Font.Gotham
visualBtn.TextSize = 13
visualBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
visualBtn.TextColor3 = Color3.new(1,1,1)
visualBtn.Parent = frame
Instance.new("UICorner", visualBtn)

--////////////////////////////////////////////////////////////
-- RANGE VISUAL
--////////////////////////////////////////////////////////////
local rangeVisual

local function updateVisual(character)
	if not Config.ShowVisual then
		if rangeVisual then rangeVisual:Destroy() rangeVisual = nil end
		return
	end

	if not rangeVisual then
		rangeVisual = Instance.new("Part")
		rangeVisual.Name = "AttackRange"
		rangeVisual.Shape = Enum.PartType.Ball
		rangeVisual.Material = Enum.Material.ForceField
		rangeVisual.Transparency = 0.7
		rangeVisual.Color = Color3.fromRGB(0, 170, 255)
		rangeVisual.Anchored = true
		rangeVisual.CanCollide = false
		rangeVisual.Parent = workspace
	end

	rangeVisual.Size = Vector3.new(Config.Range * 2, Config.Range * 2, Config.Range * 2)

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp then
		rangeVisual.CFrame = hrp.CFrame
	end
end

--////////////////////////////////////////////////////////////
-- UTIL
--////////////////////////////////////////////////////////////
local function getEquippedTool(character)
	for _, v in ipairs(character:GetChildren()) do
		if v:IsA("Tool") then
			return v
		end
	end
	return nil
end

--////////////////////////////////////////////////////////////
-- MAIN LOOP
--////////////////////////////////////////////////////////////
task.spawn(function()
	while true do
		task.wait(Config.Interval)

		if not Config.Enabled then continue end

		local character = LocalPlayer.Character
		if not character then continue end

		local hrp = character:FindFirstChild("HumanoidRootPart")
		if not hrp then continue end

		local tool = getEquippedTool(character)
		if not tool then continue end

		local remote = character:FindFirstChild("SwordDamage")
		if not remote then continue end

		local mobsFolder = workspace:FindFirstChild("Mobs")
		if not mobsFolder then continue end

		for _, mob in ipairs(mobsFolder:GetChildren()) do
			if mob.Name ~= Config.NPCName then continue end

			local humanoid = mob:FindFirstChildWhichIsA("Humanoid")
			local mobHRP = mob:FindFirstChild("HumanoidRootPart")
			if not humanoid or not mobHRP or humanoid.Health <= 0 then continue end

			if (mobHRP.Position - hrp.Position).Magnitude <= Config.Range then
				remote:FireServer(humanoid, tool, 1, 0)
			end
		end
	end
end)

--////////////////////////////////////////////////////////////
-- UI LOGIC
--////////////////////////////////////////////////////////////
toggleBtn.MouseButton1Click:Connect(function()
	Config.Enabled = not Config.Enabled
	toggleBtn.Text = Config.Enabled and "ON" or "OFF"
	toggleBtn.BackgroundColor3 = Config.Enabled
		and Color3.fromRGB(50, 150, 50)
		or Color3.fromRGB(150, 50, 50)
end)

visualBtn.MouseButton1Click:Connect(function()
	Config.ShowVisual = not Config.ShowVisual
	visualBtn.Text = "Visual: " .. (Config.ShowVisual and "ON" or "OFF")
end)

rangeBox.FocusLost:Connect(function()
	Config.Range = tonumber(rangeBox.Text) or Config.Range
end)

intervalBox.FocusLost:Connect(function()
	Config.Interval = math.max(0.05, tonumber(intervalBox.Text) or Config.Interval)
end)

npcBox.FocusLost:Connect(function()
	Config.NPCName = npcBox.Text ~= "" and npcBox.Text or Config.NPCName
end)

--////////////////////////////////////////////////////////////
-- VISUAL UPDATE
--////////////////////////////////////////////////////////////
RunService.RenderStepped:Connect(function()
	local character = LocalPlayer.Character
	if character then
		updateVisual(character)
	end
end)
