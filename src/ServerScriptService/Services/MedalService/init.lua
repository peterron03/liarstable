--[[
@TheAlmightyForehead
June 18th, 2025
This handles the Medal collab functions
]]

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnalyticsService = game:GetService("AnalyticsService")
local HttpService = game:GetService("HttpService")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local PlayerDataService
local InventoryService
local CurrencyService

-- UTILITIES --
local MedalAPIWrapper = require(script:WaitForChild("Handler"))

local Medal = Knit.CreateService {
	Name = "MedalService",
	
	APIKey = "API_KEY",
	QuestId = "QUEST_ID",
	
	AttemptingClaims = {},
	CheckingForClaimed = {},
	
	Client = {}
}

function Medal:CheckForQuestComplete(player : Player) : (boolean?, boolean?)
	local Result = self.Class:GetQuestData(player.UserId, self.QuestId)

	if type(Result) ~= "table" then return false end
	if Result.hasMedalUser ~= true then return false end
	if not Result.userId then return false end
	if type(Result.quests) ~= "table" then return false end
	if type(Result.quests[1]) ~= "table" then return false end

	return Result.quests[1].completed, Result.quests[1].claimed
end

function Medal:PostQuestClaimed(player : Player) : boolean?
	local medalUserId = player:GetAttribute("MedalId")
	
	if not medalUserId then return end
	
	local Result = self.Class:PostCompletion(medalUserId)
	
	return (type(Result) == "table" and Result.Success) or (nil)
end

function Medal:AttemptClaim(player : Player) : any?
	if self.AttemptingClaims[player] then return end
	
	self.AttemptingClaims[player] = true
	
	local success, result = pcall(function()
		local questComplete, questClaimed = self:CheckForQuestComplete(player)
		
		if questComplete then
			if not PlayerDataService:GetValue(player, "ClaimedMedal250Cash") then
				local success = PlayerDataService:SetValue(player, "ClaimedMedal250Cash", true)
				
				if success then
					local newBalance = CurrencyService:Add(player, "Cash", 250)
					
					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Cash",
							250,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.Gameplay.Name,
							"ClaimedMedal250Cash"
						)
					end)
					
					if not success2 then warn(err2) end
				end
			end
			
			if not InventoryService:FindItem(player, "Cards", "Medal") then
				InventoryService:AddItem(player, "Cards", "Medal")
			end
			
			if not InventoryService:FindItem(player, "Victories", "Clip That") then
				InventoryService:AddItem(player, "Victories", "Clip That")
			end
			
			if questClaimed == false then
				return self:PostQuestClaimed(player)
			end
		end
	end)
	
	task.delay(2, function()
		self.AttemptingClaims[player] = nil
	end)
	
	if not success then
		warn(result)
		return nil
	else
		return result
	end
end

function Medal:IsQuestClaimed(player : Player) : boolean
	if self.CheckingForClaimed[player] then return end
	
	self.CheckingForClaimed[player] = true
	
	local claimed
	
	local success, err = pcall(function()
		_, claimed = self:CheckForQuestComplete(player)
	end)
	
	task.delay(5, function()
		self.CheckingForClaimed[player] = nil
	end)
	
	return claimed == true
end

function Medal.Client:IsQuestClaimed(player : Player) : boolean
	return self.Server:IsQuestClaimed(player)
end

function Medal.Client:AttemptClaim(player : Player) : any?
	return self.Server:AttemptClaim(player)
end

function Medal:OnPlayerAdded(player : Player)
	if not self.Class then repeat task.wait(0.1) until self.Class end
	
	local medalUserId = self.Class:GetMedalUserIdFromRobloxUserId(player.UserId)
	
	if medalUserId then
		player:SetAttribute("MedalId", medalUserId)
	end
end

function Medal:KnitInit()
	PlayerDataService = Knit.GetService("PlayerDataService")
	InventoryService = Knit.GetService("InventoryService")
	CurrencyService = Knit.GetService("CurrencyService")
	
	self.Class = MedalAPIWrapper.new({
		APIKey = self.APIKey
	})
	
	print(script.Name .. " initialized")
end

function Medal:KnitStart()
	print(script.Name .. " started")
end

return Medal