--[[
@TheAlmightyForehead
May 16th, 2024
This service handles a lot to do with collisions for the game
]]

-- ROBLOX SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

local Collision = Knit.CreateService {
	Name = "CollisionService",
	Client = {}
}

function Collision:RegisterCollisionGroup(group : string)
	PhysicsService:RegisterCollisionGroup(group)
end

function Collision:IsCollisionGroupRegistered(group : string) : boolean
	return PhysicsService:IsCollisionGroupRegistered(group)
end

function Collision:SetCollisionGroupCollidable(group1 : string, group2 : string, canCollide : boolean)
	if not self:IsCollisionGroupRegistered(group1) then
		self:RegisterCollisionGroup(group1)
	end
	
	if not self:IsCollisionGroupRegistered(group2) then
		self:RegisterCollisionGroup(group2)
	end
	
	PhysicsService:CollisionGroupSetCollidable(group1, group2, false)
end

function Collision:AddPartToCollisionGroup(part : BasePart, group : string)
	part.CollisionGroup = group
end

function Collision:AddModelToCollisionGroup(model : Model, group : string)
	for _, descendant in model:GetDescendants() do
		if descendant:IsA("BasePart") then
			self:AddPartToCollisionGroup(descendant, group)
		end
	end

	model.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("BasePart") then
			self:AddPartToCollisionGroup(descendant, group)
		end
	end)
end

function Collision:RemovePartFromCollisionGroup(part : BasePart)
	part.CollisionGroup = "Default"
end

function Collision:GetPartCollisionGroup(part : BasePart) : string
	return part.CollisionGroup
end

function Collision:CanPartsCollide(part1 : BasePart, part2 : BasePart) : boolean
	local part1Group = self:GetPartCollisionGroup(part1)
	local part2Group = self:GetPartCollisionGroup(part2)
	local part1Registered = part1Group ~= "Default" and self:IsCollisionGroupRegistered(part1Group)
	local part2Registered = part2Group ~= "Default" and self:IsCollisionGroupRegistered(part2Group)
	
	if part1Registered and part2Registered then
		return PhysicsService:CollisionGroupsAreCollidable(part1Group, part2Group)
	else
		return part1.CanCollide and part2.CanCollide
	end
end

function Collision:OnCharacterAppearanceLoaded(player : Player, character : Model)
	self:AddModelToCollisionGroup(character, "Characters")
end

function Collision:KnitInit()
	self:SetCollisionGroupCollidable("Characters", "Characters", false)
	
	print(script.Name .. " initialized")
end

function Collision:KnitStart()
	print(script.Name .. " started")
end

return Collision