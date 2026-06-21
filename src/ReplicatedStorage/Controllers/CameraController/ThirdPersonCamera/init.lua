local ThirdPersonCamera = {}
ThirdPersonCamera.__index = ThirdPersonCamera

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Camera = workspace.CurrentCamera

local Typer = require(script.Typer)
local Spring = require(script.Spring)

local Cast = Typer.cast
local Expect = Typer.expect

local OFFSET = Vector3.new(7, 1.5, -0.5)

function ThirdPersonCamera.new(Character : Model, Properties : {[string] : any}?)
	local self = setmetatable({}, ThirdPersonCamera)
	
	self.Character = Cast(Character) "Instance"
	self.Enabled = true
	
	self.Active = true
	self.RenderConnection = nil
	self.Humanoid = nil
	self.HumanoidRootPart = nil
	self.PositionSpring = nil
	self.Spring = Spring.new(Vector3.zero, 60, 0.99)
	
	if Properties then
		Cast(Properties) "table"
		
		for Index, Value in Properties do
			if self[Index] then
				self[Index] = Cast(Value)(typeof(self[Index]))
			else
				self[Index] = Value
			end
		end
	end
	
	self:Init()
	
	return self
end

function ThirdPersonCamera:Init()
	self.Humanoid = self.Character:WaitForChild("Humanoid")
	self.HumanoidRootPart = self.Character:WaitForChild("HumanoidRootPart")
	
	if self.Enabled then
		self:Enable()
	else
		self:Disable()
	end
	
	self.RenderConnection = RunService.RenderStepped:Connect(function()
		Expect(self.Character.Parent).toBe("Instance").andIfNot(function()
			self:Destroy()
		end)
		
		if self.Enabled then
			local RootRotation = self.HumanoidRootPart.CFrame.LookVector :: Vector3 * Vector3.new(1, 0, 1)
			local CamRotation = Camera.CFrame.LookVector :: Vector3 * Vector3.new(1, 0, 1)
			local Cross = RootRotation:Cross(CamRotation)
			local LookAccuracy = RootRotation:Dot(CamRotation)
			
			local X = math.cos(Cross.Y * math.pi / 2) * LookAccuracy
			local Y = 1
			local Z = 1 - math.abs(math.sin(Cross.Y * math.pi / 2))
			
			self.Spring.Target = Vector3.new(X, Y, Z) * OFFSET
			self.Humanoid.CameraOffset = self.Spring.Position
			self.HumanoidRootPart.CFrame = CFrame.new(self.HumanoidRootPart.Position, self.HumanoidRootPart.Position + CamRotation) * CFrame.Angles(0, math.rad(-45), 0)
			
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		else
			self.Humanoid.CameraOffset = Vector3.zero
		end
	end)
end

function ThirdPersonCamera:Enable()
	self.Enabled = true
	self.Humanoid.AutoRotate = false
	self.Spring = Spring.new(Vector3.zero, 60, 0.99)
end

function ThirdPersonCamera:Disable()
	self.Enabled = false
	self.Humanoid.AutoRotate = true
	
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end

function ThirdPersonCamera:Destroy()
	self.Active = false
	
	if self.RenderConnection then
		self.RenderConnection:Disconnect()
		self.RenderConnection = nil
	end
	
	self:Disable()
end

return ThirdPersonCamera