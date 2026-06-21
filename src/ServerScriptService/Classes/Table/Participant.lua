--[[
@HttpPeter
October 18th, 2024
This class is for creating and manages Participants in Tables
]]

local Participant = {}
Participant.__index = Participant

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

export type Participant = any

function Participant.new(player : Player, data : any?) : Participant
	local self = setmetatable({}, Participant)
	
	self.Name = player.Name
	self.UserId = player.UserId
	self.Player = player
	self.LoadedState = nil
	self.CanDrinkPotion = false
	self.IsDead = false
	self.InGame = true
	self.Cards = {}
	self.Potions = {}
	self.Spectators = {}
	self.TotalLies = 0
	self.TotalTruths = 0
	self.TotalCardsPlayed = 0
	self.PotionsDrank = 0
	self.LiarsCalled = 0
	self.RoundDied = 0
	self.BadPotion = nil
	
	if type(data) == "table" then
		for i, v in pairs(data) do
			self[i] = v
		end
	else
		self.Data = data
	end
	
	return self
end

function Participant:AddSpectator(userId : number)
	if not table.find(self.Spectators, userId) then
		table.insert(self.Spectators, userId)
	end
	
	return #self.Spectators
end

function Participant:RemoveSpectator(userId : number)
	local find = table.find(self.Spectators, userId)
	
	if find then
		table.remove(self.Spectators, find)
	end
	
	return #self.Spectators
end

function Participant:IsUserIdSpectating(userId : number)
	return (table.find(self.Spectators, userId) and true) or (false)
end

function Participant:Kill(roundDied : number)
	if not self.IsDead then
		self.IsDead = true
		table.clear(self.Cards)
	end
	
	if roundDied then
		self.RoundDied = roundDied
	end
end

function Participant:LeftGame()
	self:Kill()
	
	self.InGame = false
	
	local character = self.Player and self.Player.Character
	
	if self.Player and self.Player.Character then
		self.Player.Character = nil
	end
	
	if character then
		character:Destroy()
	end
end

function Participant:HasCard(card : string) : boolean
	for _, v in pairs(self.Cards) do
		if v == card then
			return true
		end
	end
	
	return false
end

function Participant:HasCards(cards : {string}) : boolean
	local cardsChecked = {}
	
	for _, v in pairs(cards) do
		table.insert(cardsChecked, v)
	end
	
	for _, v in pairs(self.Cards) do
		local find = table.find(cardsChecked, v)
		
		if find then
			table.remove(cardsChecked, find)
		end
	end
	
	return #cardsChecked == 0
end

function Participant:HowManyPotions()
	local totalPotions = 0
	
	for _, potion in self.Potions do
		if potion then
			totalPotions += 1
		end
	end
	
	return totalPotions
end

function Participant:ResetPotions(amount : number)
	self.Potions = {}
	
	for i = 1, amount do
		table.insert(self.Potions, true)
	end
	
	self.BadPotion = math.random(1, #self.Potions)
end

function Participant:RemovePotion(index)
	self.Potions[index] = false
end

function Participant:AddPotion(index)
	self.Potions[index] = true
end

function Participant:AddCard(card : string)
	table.insert(self.Cards, card)
end

function Participant:RemoveCard(index : number)
	self.Cards[index] = nil
end

function Participant:PlayedCards(amount : number)
	self.TotalCardsPlayed += amount or 1
end

function Participant:RemoveCards(cards : {number})
	for _, v in pairs(cards) do
		self.Cards[v] = nil
	end
end

function Participant:RemoveAllCards()
	table.clear(self.Cards)
end

function Participant:Destroy()
	setmetatable(self, nil)
	table.clear(self)
	table.freeze(self)
end

return Participant
