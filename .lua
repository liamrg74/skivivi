local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "TeleportUI"

-- Utility functions for styling
local function addCorner(frame, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 8)
	corner.Parent = frame
end

local function addGlow(frame)
	local glow = Instance.new("ImageLabel")
	glow.Name = "GlowEffect"
	glow.Image = "rbxassetid://12187398025" -- subtle glow asset
	glow.BackgroundTransparency = 1
	glow.AnchorPoint = Vector2.new(0.5, 0.5)
	glow.Position = UDim2.new(0.5, 0, 0.5, 0)
	glow.Size = UDim2.new(1.5, 0, 1.5, 0)
	glow.ZIndex = frame.ZIndex - 1
	glow.ImageColor3 = frame.BackgroundColor3
	glow.Parent = frame
end

local function styleButton(button, bgColor)
	button.BackgroundColor3 = bgColor or Color3.fromRGB(40, 40, 40)
	button.BackgroundTransparency = 0 -- fully opaque background
	button.TextColor3 = Color3.fromRGB(255, 255, 255) -- bright white text
	button.Font = Enum.Font.GothamBold
	button.TextScaled = true
	button.AutoButtonColor = true
	button.TextStrokeTransparency = 0 -- black outline visible
	button.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	
	addCorner(button, 10)
	addGlow(button)
	
	-- Remove any UIGradient on buttons (to avoid darkening text)
	for _, child in pairs(button:GetChildren()) do
		if child:IsA("UIGradient") then
			child:Destroy()
		end
	end
end

-- Main Panel
local mainPanel = Instance.new("Frame", screenGui)
mainPanel.Size = UDim2.new(0, 300, 0, 460)
mainPanel.Position = UDim2.new(0, 30, 0, 60)
mainPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainPanel.BackgroundTransparency = 0.5
mainPanel.Visible = false
addCorner(mainPanel, 15)

-- UIGradient for main panel background
local mainGradient = Instance.new("UIGradient", mainPanel)
mainGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15)),
}
mainGradient.Rotation = 90

-- Top Bar
local topBar = Instance.new("Frame", screenGui)
topBar.Size = UDim2.new(0, 300, 0, 40)
topBar.Position = UDim2.new(0, 30, 0, 10)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.BackgroundTransparency = 0.4
addCorner(topBar, 15)

-- UIGradient for topBar
local topBarGradient = Instance.new("UIGradient", topBar)
topBarGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15)),
}
topBarGradient.Rotation = 90

-- "Main" TextButton on topBar
local mainButton = Instance.new("TextButton", topBar)
mainButton.Size = UDim2.new(0, 120, 1, -10)
mainButton.Position = UDim2.new(0, 10, 0, 5)
mainButton.Text = "Main"
styleButton(mainButton, Color3.fromRGB(60, 60, 60))

-- "Credits" TextButton on topBar
local creditsButton = Instance.new("TextButton", topBar)
creditsButton.Size = UDim2.new(0, 120, 1, -10)
creditsButton.Position = UDim2.new(0, 140, 0, 5)
creditsButton.Text = "Credits"
styleButton(creditsButton, Color3.fromRGB(60, 60, 60))

-- Credits Frame
local creditsFrame = Instance.new("Frame", screenGui)
creditsFrame.Size = UDim2.new(0, 280, 0, 200)
creditsFrame.Position = UDim2.new(0, 35, 0, 60)
creditsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
creditsFrame.BackgroundTransparency = 0.5
creditsFrame.Visible = false
addCorner(creditsFrame, 15)

local creditsGradient = Instance.new("UIGradient", creditsFrame)
creditsGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15)),
}
creditsGradient.Rotation = 90

local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -20, 0, 40)
creditsLabel.Position = UDim2.new(0, 10, 0, 10)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Text = "liam - UI/Scripts"
creditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsLabel.Font = Enum.Font.GothamBold
creditsLabel.TextScaled = true
creditsLabel.TextStrokeTransparency = 0
creditsLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
creditsLabel.TextXAlignment = Enum.TextXAlignment.Center
creditsLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Close Button for credits
local creditsClose = Instance.new("TextButton", creditsFrame)
creditsClose.Size = UDim2.new(0, 30, 0, 30)
creditsClose.Position = UDim2.new(1, -35, 0, 5)
creditsClose.Text = "X"
styleButton(creditsClose, Color3.fromRGB(150, 0, 0))

-- Close Credits Logic
creditsClose.MouseButton1Click:Connect(function()
	creditsFrame.Visible = false
	mainPanel.Visible = false
	topBar.Visible = true
end)

-- Close and Add Buttons on mainPanel
local closeButton = Instance.new("TextButton", mainPanel)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
styleButton(closeButton, Color3.fromRGB(150, 0, 0))

local addButton = Instance.new("TextButton", screenGui)
addButton.Size = UDim2.new(0, 30, 0, 30)
addButton.Position = UDim2.new(0, 30, 0, 10)
addButton.Text = "+"
styleButton(addButton, Color3.fromRGB(0, 150, 0))
addButton.Visible = false

-- Toggle UI visibility logic
closeButton.MouseButton1Click:Connect(function()
	mainPanel.Visible = false
	addButton.Visible = true
end)

addButton.MouseButton1Click:Connect(function()
	mainPanel.Visible = true
	addButton.Visible = false
end)

-- Main Button click logic: show teleport UI, hide credits
mainButton.MouseButton1Click:Connect(function()
	mainPanel.Visible = true
	creditsFrame.Visible = false
	topBar.Visible = true
	addButton.Visible = false
end)

-- Credits Button click logic: show credits, hide teleport UI
creditsButton.MouseButton1Click:Connect(function()
	creditsFrame.Visible = true
	mainPanel.Visible = false
	topBar.Visible = true
	addButton.Visible = false
end)

-- Teleport function
local function teleportTo(folderName, modelName)
	local player = Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	local folder = workspace:FindFirstChild(folderName)
	if not folder then warn("Folder not found:", folderName) return end

	local model = folder:FindFirstChild(modelName)
	if not model or not model:IsA("Model") then warn("Invalid model:", modelName) return end

	local mainPart = model.PrimaryPart or model:FindFirstChild("Main") or model:FindFirstChildWhichIsA("BasePart")
	if not mainPart then warn("No main part found in model.") return end

	if not model.PrimaryPart then model.PrimaryPart = mainPart end

	root.CFrame = model.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
end

-- Buttons Container Frame inside mainPanel
local buttonsFrame = Instance.new("Frame", mainPanel)
buttonsFrame.Size = UDim2.new(1, -20, 1, -80)
buttonsFrame.Position = UDim2.new(0, 10, 0, 50)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.ClipsDescendants = true

-- Red Button (teleport to Meteorite Ingot)
local redButton = Instance.new("TextButton", buttonsFrame)
redButton.Size = UDim2.new(1, 0, 0, 40)
redButton.Position = UDim2.new(0, 0, 0, 0)
redButton.Text = "Teleport to Meteorite Ingot"
styleButton(redButton, Color3.fromRGB(255, 0, 0))
redButton.TextXAlignment = Enum.TextXAlignment.Left

redButton.MouseButton1Click:Connect(function()
	teleportTo("Items", "Meteorite Ingot")
end)

-- Blue Button (teleport to Truck)
local blueButton = redButton:Clone()
blueButton.Text = "Teleport to Truck"
blueButton.Position = UDim2.new(0, 0, 0, 50)
styleButton(blueButton, Color3.fromRGB(0, 102, 255))
blueButton.Parent = buttonsFrame

blueButton.MouseButton1Click:Connect(function()
	teleportTo("Vehicle", "Truck")
end)

-- ESP Button (toggle ESP on/off)
local espButton = redButton:Clone()
espButton.Text = "ESP NPC and Players"
espButton.Position = UDim2.new(0, 0, 0, 100)
styleButton(espButton, Color3.fromRGB(0, 255, 0))
espButton.Parent = buttonsFrame

local espEnabled = false
local highlightInstances = {}

local function isNPC(model)
	if not model:IsA("Model") then return false end
	if model:FindFirstChildOfClass("Humanoid") then
		for _, player in pairs(Players:GetPlayers()) do
			if player.Character == model then
				return false
			end
		end
		return true
	end
	return false
end

local function createHighlightForHeads(model)
	if not model or not model:IsA("Model") then return end
	if highlightInstances[model] then return highlightInstances[model] end

	-- Find all "Head" parts and highlight them
	for _, part in pairs(model:GetChildren()) do
		if part:IsA("BasePart") and part.Name == "Head" then
			local highlight = Instance.new("Highlight")
			highlight.Adornee = part
			highlight.FillColor = Color3.fromRGB(0, 255, 0)
			highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			highlight.Parent = workspace
			highlightInstances[part] = highlight
		end
	end
end

local function clearHighlights()
	for part, highlight in pairs(highlightInstances) do
		if highlight and highlight.Parent then
			highlight:Destroy()
		end
	end
	highlightInstances = {}
end

local function updateHighlights()
	if not espEnabled then return end

	for _, player in pairs(Players:GetPlayers()) do
		if player.Character and player.Character.Parent then
			createHighlightForHeads(player.Character)
		end
	end

	for _, descendant in pairs(workspace:GetDescendants()) do
		if isNPC(descendant) then
			createHighlightForHeads(descendant)
		end
	end
end

workspace.DescendantAdded:Connect(function(descendant)
	if espEnabled and isNPC(descendant) then
		createHighlightForHeads(descendant)
	end
end)

espButton.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	if espEnabled then
		espButton.TextColor3 = Color3.fromRGB(0, 255, 0)
		updateHighlights()
	else
		espButton.TextColor3 = Color3.fromRGB(150, 150, 150)
		clearHighlights()
	end
end)

RunService.Heartbeat:Connect(function()
	if espEnabled then
		updateHighlights()
	end
end)

-- Bring Unanchored Models Button
local bringButton = redButton:Clone()
bringButton.Text = "Bring Unanchored Items"
bringButton.Position = UDim2.new(0, 0, 0, 150)
styleButton(bringButton, Color3.fromRGB(255, 255, 0)) -- Yellow
bringButton.Parent = buttonsFrame

local function bringUnanchoredModels()
	local folder = workspace:FindFirstChild("Items")
	if not folder then
		warn("Items folder not found")
		return
	end

	local player = Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	for _, model in pairs(folder:GetChildren()) do
		if model:IsA("Model") then
			local primary = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
			if primary and not primary.Anchored then
				-- Teleport model's PrimaryPart near player
				model:SetPrimaryPartCFrame(root.CFrame * CFrame.new(0, 0, -5))
			end
		end
	end
end

bringButton.MouseButton1Click:Connect(bringUnanchoredModels)

-- Add this to your existing GUI creation script after all other buttons:

-- Kill Aura Button
local killAuraButton = redButton:Clone()
killAuraButton.Text = "Kill Aura"
killAuraButton.Position = UDim2.new(0, 0, 0, 200)
styleButton(killAuraButton, Color3.fromRGB(255, 85, 85))
killAuraButton.Parent = buttonsFrame

-- Kill Aura Logic
local killAuraEnabled = false
local KILL_AURA_RADIUS = 50
local DAMAGE_AMOUNT = 100

local function damageNPCsNearPlayer()
	if not killAuraEnabled then return end

	local player = Players.LocalPlayer
	local character = player.Character
	if not character then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	for _, npc in pairs(workspace:GetDescendants()) do
		if npc:IsA("Model") and isNPC(npc) then
			local humanoid = npc:FindFirstChildOfClass("Humanoid")
			local torso = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart")

			if humanoid and torso then
				local distance = (torso.Position - root.Position).Magnitude
				if distance <= KILL_AURA_RADIUS then
					humanoid:TakeDamage(DAMAGE_AMOUNT)
				end
			end
		end
	end
end

killAuraButton.MouseButton1Click:Connect(function()
	killAuraEnabled = not killAuraEnabled
	if killAuraEnabled then
		killAuraButton.TextColor3 = Color3.fromRGB(255, 0, 0)
	else
		killAuraButton.TextColor3 = Color3.fromRGB(150, 150, 150)
	end
end)

-- Loop to apply damage periodically
task.spawn(function()
	while true do
		task.wait(0.5)
		if killAuraEnabled then
			damageNPCsNearPlayer()
		end
	end
end)

-- Auto Drive Button (Add in buttonsFrame)
local autoDriveButton = redButton:Clone()
autoDriveButton.Text = "Auto Drive"
autoDriveButton.Position = UDim2.new(0, 0, 0, 250)
styleButton(autoDriveButton, Color3.fromRGB(0, 170, 255))
autoDriveButton.Parent = buttonsFrame

-- Auto-Drive Logic
local RunService = game:GetService("RunService")
local autoDriveEnabled = false
local seat = nil
local bodyVelocity = nil

autoDriveButton.MouseButton1Click:Connect(function()
	autoDriveEnabled = not autoDriveEnabled

	local vehicleFolder = workspace:FindFirstChild("Vehicle")
	if not vehicleFolder then warn("Vehicle folder not found") return end

	local truck = vehicleFolder:FindFirstChild("Truck")
	if not truck or not truck:IsA("Model") then warn("Truck model not found") return end

	seat = truck:FindFirstChildWhichIsA("VehicleSeat", true)
	if not seat then warn("No VehicleSeat found in Truck") return end

	if autoDriveEnabled then
		autoDriveButton.TextColor3 = Color3.fromRGB(0, 255, 255)

		if bodyVelocity and bodyVelocity.Parent then
			bodyVelocity:Destroy()
		end
		bodyVelocity = nil
	else
		autoDriveButton.TextColor3 = Color3.fromRGB(150, 150, 150)

		seat.Throttle = 0
		seat.Steer = 0

		if not bodyVelocity then
			bodyVelocity = Instance.new("BodyVelocity")
			bodyVelocity.Velocity = Vector3.new(0, 0, 0)
			bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
			bodyVelocity.Parent = seat.Parent.PrimaryPart or seat.Parent:FindFirstChildWhichIsA("BasePart")
		end

		if seat.Parent.PrimaryPart then
			seat.Parent.PrimaryPart.RotVelocity = Vector3.new(0, 0, 0)
		end

		task.delay(0.5, function()
			if bodyVelocity and bodyVelocity.Parent then
				bodyVelocity:Destroy()
				bodyVelocity = nil
			end
		end)
	end
end)

RunService.Heartbeat:Connect(function()
	if autoDriveEnabled and seat and seat:IsDescendantOf(workspace) then
		seat.Throttle = 1
		seat.Steer = 0

		if bodyVelocity and bodyVelocity.Parent then
			bodyVelocity:Destroy()
			bodyVelocity = nil
		end
	end
end)
