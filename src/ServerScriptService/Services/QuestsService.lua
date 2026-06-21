--[[
@TheAlmightyForehead
June 6th, 2024
This service handles rewards such as daily rewards, friend rewards, etc.
]]

-- ROBLOX SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local CurrencyService
local PlayerDataService
local ShopService

-- CLASSES --
local Classes = script.Parent.Parent:WaitForChild("Classes")
local LogIn = require(Classes:WaitForChild("LogIn"))

-- UTILITIES --
local Utilities = ReplicatedStorage:WaitForChild("Utilities")
local Utils = require(Utilities:WaitForChild("Utils"))
local Settings = require(Utilities:WaitForChild("Settings"))
local ProductIds = require(Utilities:WaitForChild("ProductIds"))

-- VALUES --
local Values = ReplicatedStorage:WaitForChild("Values")

local Quests = Knit.CreateService {
	Name = "QuestsService",
	
	PlayerData = {},
	
	QuestOptions = {
		{
			Currency = "Wins",
			Display = "Win _ games",
			
			RewardMultipliers = {
				["Beach Balls"] = 35,
			},
			
			Range = {
				Min = 3,
				Max = 8
			}
		},
		
		{
			Currency = "GamesPlayed",
			Display = "Play _ games",
			
			RewardMultipliers = {
				["Beach Balls"] = 15,
			},

			Range = {
				Min = 5,
				Max = 15
			}
		},
		
		{
			Currency = "LiarsCalled",
			Display = "Call Liar _ times",

			RewardMultipliers = {
				["Beach Balls"] = 20,
			},

			Range = {
				Min = 3,
				Max = 6
			}
		},
		
		{
			Currency = "CardsPlayed",
			Display = "Play _ cards",

			RewardMultipliers = {
				["Beach Balls"] = 5,
			},

			Range = {
				Min = 20,
				Max = 50
			}
		},
		
		{
			Currency = "WinStreak",
			Display = "Win _ in a row",

			RewardMultipliers = {
				["Beach Balls"] = 50,
			},

			Range = {
				Min = 2,
				Max = 3
			}
		},
	},
	
	Client = {
		DataChanged = Knit.CreateSignal()
	}
}

function Quests:GetRandomQuests(currency : string)
	local randomQuests = {}
	local choices = {}
	
	for i = 1, #self.QuestOptions do
		table.insert(choices, i)
	end
	
	for i = 1, 3 do
		local choice = choices[math.random(1, #choices)]
		local random = self.QuestOptions[choice]
		local randomRange = math.random(random.Range.Min, random.Range.Max)
		local reward = random.RewardMultipliers[currency] * randomRange
		local display = string.gsub(random.Display, "_", randomRange)
		
		table.insert(randomQuests, {
			Stat = random.Currency,
			Value = 0,
			Goal = randomRange,
			Display = display,
			Currency = currency,
			Reward = reward
		})
		
		table.remove(choices, choice)
	end
	
	return randomQuests
end

function Quests:GetData(player : Player)
	return self.PlayerData[player]
end

function Quests.Client:GetData(player : Player)
	return self.Server:GetData(player)
end

function Quests:OnDataLoaded(player : Player, data : any)
	local questData = data.Data.QuestData or {
		LastRefresh = nil,
		CurrentQuests = {},
	}
	
	if not questData.LastRefresh or os.time() - questData.LastRefresh > 86400 then
		questData.CurrentQuests = self:GetRandomQuests("Beach Balls")
		questData.LastRefresh = os.time()
	end
	
	self.PlayerData[player] = questData
	PlayerDataService:SetValue(player, "QuestData", self.PlayerData[player])
	
	self.Client.DataChanged:Fire(player, self.PlayerData[player])
end

function Quests:OnPlayerRemoved(player : Player)
	self.PlayerData[player] = nil
	
	task.delay(5, function()
		self.PlayerData[player] = nil
	end)
end

function Quests:KnitInit()
	CurrencyService = Knit.GetService("CurrencyService")
	PlayerDataService = Knit.GetService("PlayerDataService")
	ShopService = Knit.GetService("ShopService")
	
	CurrencyService.AddedCurrency:Connect(function(player, currencyName, amountAdded)
		if type(self.PlayerData[player]) == "table" and type(self.PlayerData[player].CurrentQuests) == "table" then
			for _, quest in pairs(self.PlayerData[player].CurrentQuests) do
				if quest.Stat == currencyName and quest.Value < quest.Goal then
					quest.Value += amountAdded
					
					if quest.Value >= quest.Goal then
						quest.Value = quest.Goal
						
						local hasDoubleEventCurrency = ShopService:UserOwnsGamePass(player, ProductIds.Passes["x2 Beach Balls"].Id)
						local eventCurrencyMultiplier = (hasDoubleEventCurrency and 2) or (1)
						
						CurrencyService:Add(player, quest.Currency, quest.Reward * eventCurrencyMultiplier)
					end
				end
			end
		end
		
		PlayerDataService:SetValue(player, "QuestData", self.PlayerData[player])
		self.Client.DataChanged:Fire(player, self.PlayerData[player])
	end)
	
	CurrencyService.RemovedCurrency:Connect(function(player, currencyName, amountAdded)
		if type(self.PlayerData[player]) == "table" and type(self.PlayerData[player].CurrentQuests) == "table" then
			for _, quest in pairs(self.PlayerData[player].CurrentQuests) do
				if quest.Stat == currencyName and quest.Value < quest.Goal then
					quest.Value -= amountAdded
				end
			end
		end
		
		PlayerDataService:SetValue(player, "QuestData", self.PlayerData[player])
		self.Client.DataChanged:Fire(player, self.PlayerData[player])
	end)
	
	task.spawn(function()
		while task.wait(1) do
			for player, data in pairs(self.PlayerData) do
				if player and player.Parent and type(data) == "table" and data.LastRefresh and os.time() - data.LastRefresh > 86400 then
					data.CurrentQuests = self:GetRandomQuests("Beach Balls")
					data.LastRefresh = os.time()
					PlayerDataService:SetValue(player, "QuestData", self.PlayerData[player])
					self.Client.DataChanged:Fire(player, data)
				end
			end
		end
	end)

	print(script.Name .. " initialized")
end

function Quests:KnitStart()
	print(script.Name .. " started")
end

return Quests