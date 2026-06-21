--[[
@TheAlmightyForehead
May 4th, 2024
This controller handles most, if not all, of the camera work
]]

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))

-- OTHER MODULES --
local ThirdPersonCamera = require(script.ThirdPersonCamera)

-- PLAYER --
local Player = Players.LocalPlayer

local Camera = Knit.CreateController {
	Name = "CameraController",
	RenderName = "CustomCamRender",
	Priority = Enum.RenderPriority.Camera.Value
}

function Camera:EnableThirdPerson()
	if not self.CurrentThirdPerson then
		local character = Player.Character
		
		if character then
			self.CurrentThirdPerson = ThirdPersonCamera.new(character)
		else
			warn("Character doesn't exist.")
			return
		end
	end
	
	self.CurrentThirdPerson:Enable()
end

function Camera:DisableThirdPerson()
	if self.CurrentThirdPerson then
		self.CurrentThirdPerson:Disable()
	else
		warn("Third person camera doesn't exist.")
	end
end

function Camera:TweenToCFrame(newCF : CFrame, duration : number?)
	if self.Locked then warn("Camera currently locked.") return end

	local tweenInfo = TweenInfo.new(duration or 1)

	local tween = TweenService:Create(
		workspace.CurrentCamera,
		tweenInfo,
		{CFrame = newCF}
	)

	self:SetType(Enum.CameraType.Scriptable)

	tween:Play()
end

function Camera:TweenToPart(part : BasePart, distanceFromPart : Vector3?, duration : number?)
	if self.Locked then warn("Camera currently locked.") return end
	
	local newCF = CFrame.new(part.Position + (distanceFromPart or Vector3.new(0, 0, 0)), part.Position)
	
	self:TweenToCFrame(newCF, duration)
end

function Camera:ToCFrame(newCF : CFrame)
	self:SetType(Enum.CameraType.Scriptable)
	
	workspace.CurrentCamera.CFrame = newCF
end

function Camera:ToPart(part : BasePart, distanceFromPart : Vector3?)
	if self.Locked then warn("Camera currently locked.") return end

	self:ToCFrame(CFrame.new(part.Position + (distanceFromPart or Vector3.new(0, 0, 0))), part.Position)
end

function Camera:Lock(part : BasePart?)
	if self.Locked then warn("Camera already locked.") return end
	
	self.Locked = true
	self:SetType(Enum.CameraType.Scriptable)
	
	local currentCamera = workspace.CurrentCamera
	
	RunService:BindToRenderStep(self.RenderName, self.Priority, function()
		if part then
			currentCamera.CFrame = part.CFrame * CFrame.new(0, 0, 10)
		end
	end)
end

function Camera:Unlock()
	if not self.Locked then return end
	
	self.Locked = false
	self:SetType(Enum.CameraType.Custom)
	
	RunService:UnbindFromRenderStep(self.RenderName)
end

function Camera:Track(part : BasePart)
	if self.Locked then warn("Camera currently locked.") return end
	
	self:SetType(Enum.CameraType.Track)
	self:SetSubject(part)
end

function Camera:SetSubject(part : BasePart)
	workspace.CurrentCamera.CameraSubject = part
end

function Camera:SetType(cameraType : Enum.CameraType)
	workspace.CurrentCamera.CameraType = cameraType
end

function Camera:Reset()
	pcall(function()
		self:TweenToPart(Players.LocalPlayer.Character.Head, Vector3.new(0, 0, 0), 0)
	end)
	
	self:SetType(Enum.CameraType.Custom)
	self:SetSubject(Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"))
end

function Camera:KnitInit()
	print(script.Name .. " initialized")
end

function Camera:KnitStart()
	print(script.Name .. " started")
end

return Camera