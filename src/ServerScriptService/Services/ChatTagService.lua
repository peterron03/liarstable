--[[
@TheAlmightyForehead
May 23rd, 2024
This handles chat tags
]]

-- ROBLOX SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- UTILS --
local Utilities = ReplicatedStorage:WaitForChild("Utilities")
local ProductIds = require(Utilities:WaitForChild("ProductIds"))

-- KNIT SERVICES --
local ShopService

local ChatTag = Knit.CreateService {
	Name = "ChatTagService",
	
	GamepassTag = ProductIds.Passes.VIP.Id,
	GroupId = 4620969,
	DeveloperRank = 251,
	TesterRank = 5,
	
	Testers = {
		108304522,
		2526535450
	},
	
	PlayerTags = {},
	
	Client = {}
}

function ChatTag:SetPassId(passId : number)
	self.GamepassTag = tonumber(passId) or self.GamepassTag
end

function ChatTag:DoesPlayerHaveTag(player : Player, tag : string) : boolean
	if self.PlayerTags[player] then
		for i,v in pairs(self.PlayerTags[player]) do
			if v.Name == tag then
				return true
			end
		end
	end

	return false
end

function ChatTag:FindTag(player : Player, tagName : string) : {Name : string, Color : Color3?}?
	if type(self.PlayerTags[player]) == "table" then
		for _, tag in pairs(self.PlayerTags[player]) do
			if type(tag) == "table" and tag.Name == tagName then
				return tag
			end
		end
	end
	
	return nil
end

function ChatTag:AddTag(player : Player, tag : string, color : Color3?)
	if not self.PlayerTags[player] then
		self.PlayerTags[player] = {}
	end

	if self:FindTag(player, tag) then return end

	if not color then
		color = Color3.fromRGB(255, 255, 255)
	end

	if color then
		table.insert(self.PlayerTags[player], {Name = tag, Color = color})
	end
end

function ChatTag:RemoveTag(player : Player, tag : string)
	if self.PlayerTags[player] then
		for i,v in pairs(self.PlayerTags[player]) do
			if v.Name == tag then
				table.remove(self.PlayerTags[player], i)
			end
		end
	end
end

function ChatTag:SetTags(player : Player, tags : {Tag : string})
	self.PlayerTags[player] = tags
end

function ChatTag:GetTags(player : Player, userId : number?) : {Tag : string?}?
	if userId then
		player = Players:GetPlayerByUserId(userId)
	end

	if player then
		return self.PlayerTags[player] or {}
	else
		return {}
	end
end

function ChatTag.Client:GetTags(player : Player, targetId : number?) : {Tag : string?}?
	return self.Server:GetTags(player, targetId or player.UserId) or {}
end

function ChatTag:OnPlayerAdded(player : Player)
	if not self.PlayerTags[player] then
		self.PlayerTags[player] = {}

		if self.GroupId and self.DeveloperRank and player:GetRankInGroup(self.GroupId) >= self.DeveloperRank then
			self:AddTag(player, "⚒️DEV", Color3.fromRGB(75, 165, 255))
		end

		if self.GroupId and ((self.TesterRank and player:GetRankInGroup(self.GroupId) == self.TesterRank) or (table.find(self.Testers, player.UserId))) then
			self:AddTag(player, "🎮TESTER", Color3.fromRGB(25, 25, 25))
		end
	end
end

function ChatTag:OnPlayerRemoved(player : Player)
	self.PlayerTags[player] = nil
end

function ChatTag:KnitInit()
	ShopService = Knit.GetService("ShopService")

	ShopService.GamePassPurchaseFinished:Connect(function(player, passId)
		if self.GamepassTag and passId == self.GamepassTag then
			self:AddTag(player, "⭐VIP", Color3.fromRGB(255, 215, 25))
		end
	end)

	print(script.Name .. " initialized")
end

function ChatTag:KnitStart()
	print(script.Name .. " started")
end

return ChatTag