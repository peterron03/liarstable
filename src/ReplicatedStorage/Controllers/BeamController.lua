--[[
@TheAlmightyForehead
June 1st ,2024
This controller handles most, if not all, of the tutorial stuff
]]

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))

local Beam = Knit.CreateController {
	Name = "BeamController",
}

export type BeamProperties = {
	Color : Color3?,
	Enabled : boolean?,
	LightEmission : number?,
	LightInfluence : number?,
	Texture : string?,
	TextureLength : number?,
	TextureMode : Enum.TextureMode?,
	TextureSpeed : number?,
	Transparency : number?,
	ZOffset : number?,
	CurveSize0 : number?,
	CurveSize1 : number?,
	FaceCamera : boolean?,
	Segments : number?,
	Width0 : number?,
	Width1 : number?
}

export type AttachmentProperties = {
	Visible : boolean?,
	CFrame : CFrame?,
	Axis : Vector3?,
	SecondaryAxis : Vector3?
}

function Beam:Enable(enabled : boolean?)
	if not self.Beam then
		self:Create()
	end
	
	self.Beam.Enabled = enabled
end

function Beam:Attach(basePart : BasePart, enable : boolean?, properties : {BeamProperties : BeamProperties, Attachment0Properties : AttachmentProperties, Attachment1Properties : AttachmentProperties}?)
	if self.Beam then
		if not self.Attachment1 then
			self.Attachment1 = Instance.new("Attachment")
		end
		
		print(self.Attachment1, basePart)
		
		self.Attachment1.Parent = basePart
		
		self:Enable(enable)
	else
		self:Create(properties)
		self:Attach(basePart, enable)
	end
end

function Beam:Create(properties : {BeamProperties : BeamProperties, Attachment0Properties : AttachmentProperties, Attachment1Properties : AttachmentProperties}?) : (Beam?, Attachment?, Attachment?)
	if not self.Beam then
		if Players.LocalPlayer and Players.LocalPlayer.Character then
			local findBeam = script:FindFirstChildWhichIsA("Beam")
			self.Beam = (findBeam and findBeam:Clone()) or (Instance.new("Beam"))
			self.Attachment0 = Instance.new("Attachment")
			self.Attachment1 = Instance.new("Attachment")
			self.Beam.Enabled = false
			
			if type(properties) == "table" then
				if type(properties.BeamProperties) == "table" then
					for i, v in pairs(properties.BeamProperties) do
						if self.Beam[i] ~= nil then
							self.Beam[i] = v
						end
					end
				end
				
				if type(properties.Attachment1Properties) == "table" then
					for i, v in pairs(properties.Attachment1Properties) do
						if self.Attachment1[i] ~= nil then
							self.Attachment1[i] = v
						end
					end
				end
				
				if type(properties.Attachment0Properties) == "table" then
					for i, v in pairs(properties.Attachment0Properties) do
						if self.Attachment0[i] ~= nil then
							self.Attachment0[i] = v
						end
					end
				end
			end
			
			self.Beam.Parent = Players.LocalPlayer.Character.HumanoidRootPart
			self.Attachment0.Parent = Players.LocalPlayer.Character.HumanoidRootPart
			self.Beam.Attachment0 = self.Attachment0
			self.Beam.Attachment1 = self.Attachment1
			
			return self.Beam, self.Attachment0, self.Attachment1
		end
		
		return nil
	else
		return self.Beam, self.Attachment0, self.Attachment1
	end
end

function Beam:Destroy()
	if self.Beam then
		self.Beam:Destroy()
		self.Beam = nil
	end
	
	if self.Attachment0 then
		self.Attachment0:Destroy()
		self.Attachment0 = nil
	end
	
	if self.Attachment1 then
		self.Attachment1:Destroy()
		self.Attachment1 = nil
	end
end

function Beam:KnitInit()
	print(script.Name .. " initialized")
end

function Beam:KnitStart()
	print(script.Name .. " started")
end

return Beam