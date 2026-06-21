--[[
@HttpPeter
October 18th, 2024
This class is for creating and managing AI participants
]]

local Faker = {}
Faker.__index = Faker

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

export type Faker = any

function Faker.new(model : Model, data : any?) : Faker
	local self = setmetatable({}, Faker)
	
	self.Name = "Player_" .. math.random(1000, 9999)
	self.UserId = self.Name .. DateTime.now().UnixTimestamp
	self.Character = model:Clone()
	
	if type(data) == "table" then
		for i, v in pairs(data) do
			self[i] = v
		end
	else
		self.Data = data
	end
	
	return self
end

function Faker:LoadCharacter(callback : (Faker) -> ()?) : boolean?
	if not self.Character then warn("Character not found") return false end
	
	self.Character.Parent = workspace
	
	if callback then
		callback(self)
	end
	
	return true
end

function Faker:Destroy()
	setmetatable(self, nil)
	table.clear(self)
	table.freeze(self)
end

return Faker
