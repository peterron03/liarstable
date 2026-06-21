--[[
@TheAlmightyForehead
October 19th, 2024
This handles anything character-specific on the client
]]

-- SERVICES --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")

-- KNIT SERVICES --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local AnimationController = Knit.GetController("AnimationController")
local GameplayService = Knit.GetService("GameplayService")
local InventoryService = Knit.GetService("InventoryService")
local ItemService = Knit.GetService("ItemService")

-- UTILITIES --
local UtilitiesFolder = ReplicatedStorage:WaitForChild("Utilities")
local ProductIds = require(UtilitiesFolder:WaitForChild("ProductIds"))

-- PLAYER --
local Player = Players.LocalPlayer
local GamePassOwned = Player:FindFirstChild("GamePassOwned", true)
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Head = Character:WaitForChild("Head")
local HRP = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

local newLight = Instance.new("PointLight")
newLight.Range = 4
newLight.Brightness = 0.6
newLight.Parent = Head

Camera.CameraType = Enum.CameraType.Custom
Player.CameraMode = Enum.CameraMode.LockFirstPerson

Camera.CameraSubject = Humanoid

if not VRService.VREnabled then
	Humanoid.CameraOffset = Vector3.new(0, 0.25, -0.5)
end

Camera.CFrame = HRP.CFrame:ToWorldSpace(CFrame.new(0, 1.8, 0))

local newInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

local function HandleTransparency(v)
	if (not v:IsA("BasePart") and not v:IsA("Decal")) or (((v.Name == "Head") or (not v:FindFirstAncestor("Cards") and not v.Parent:IsA("Model"))) and (not v:FindFirstAncestor("RightHandCard")) and (not v:FindFirstAncestor("RightHandPotion"))) then
		return
	end
	
	if v:FindFirstAncestorWhichIsA("Accessory") then
		return
	end

	v:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
		v.LocalTransparencyModifier = 0
	end)

	v.LocalTransparencyModifier = 0
end

if not VRService.VREnabled then
	local oldTick = tick()
	local lastCF = CFrame.new()

	RunService.RenderStepped:Connect(function()
		if Camera.CameraType == Enum.CameraType.Scriptable then return end
		
		local CameraCFrame = HRP.CFrame:ToObjectSpace(Camera.CFrame)
		local x, y, z = CameraCFrame:ToOrientation()
		
		local xlimit = math.rad(math.clamp(math.deg(x), -70, 70))
		local ylimit
		
		if GamePassOwned:Invoke(ProductIds.Passes.Headspin.Id) then
			ylimit = y
		else
			ylimit = math.rad(math.clamp(math.deg(y), -65, 65))
		end

		Camera.CFrame = HRP.CFrame:ToWorldSpace(CFrame.new(0, 1.8, 0) * CFrame.fromOrientation(xlimit, ylimit, 0))
		
		local newTick = tick()
		local newCFrame = Camera.CFrame
		
		if newTick - oldTick > 0.1 and lastCF ~= newCFrame then
			oldTick = newTick
			lastCF = newCFrame
			
			local neck = Head:FindFirstChild("Neck")
			
			if neck then
				local camDirection = HRP.CFrame:ToObjectSpace(newCFrame).LookVector
				local lookAt = CFrame.new(Vector3.new(0, 0.8, 0), camDirection * 5)
				GameplayService:UpdateMovement(neck, lookAt)-- CFrame.new(0,0.8,0) * CFrame.Angles(0, -math.asin(camDirection.X), 0) * CFrame.Angles(math.sin(camDirection.Y), 0, 0))
			end
		end
	end)

	Character.DescendantAdded:Connect(HandleTransparency)

	for i, v in Character:GetDescendants() do
		HandleTransparency(v)
	end
else
	GameplayService:ActivateVR()
end