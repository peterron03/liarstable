--[[
@TheAlmightyForehead
June 6th, 2024
This service handles rewards such as daily rewards, friend rewards, etc.
]]

-- ROBLOX SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local AnalyticsService = game:GetService("AnalyticsService")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local ItemService
local CurrencyService
local InventoryService
local PlayerDataService

-- CLASSES --
local Classes = script.Parent.Parent:WaitForChild("Classes")
local LogIn = require(Classes:WaitForChild("LogIn"))

-- UTILITIES --
local Utilities = ReplicatedStorage:WaitForChild("Utilities")
local Utils = require(Utilities:WaitForChild("Utils"))
local Settings = require(Utilities:WaitForChild("Settings"))
local BadgeIds = require(Utilities:WaitForChild("BadgeIds"))
local BattlePassItems = require(Utilities:WaitForChild("BattlePassItems"))

-- VALUES --
local Values = ReplicatedStorage:WaitForChild("Values")
local CurrentTick = Values:WaitForChild("CurrentTick")
local EventTimer = Values:WaitForChild("EventTimer")

local Rewards = Knit.CreateService {
	Name = "RewardsService",

	GroupId = 4620969,

	PlayerLogIns = {},
	LogInConnections = {},
	PlayerUsedCodes = {},
	PlayerPlayRewards = {},
	SummerBattlePasses = {},

	PromoCodes = {
		IsEligible = function(self, player : Player, code : string)
			local success, result = pcall(function()
				if type(code) ~= "string" then return {false, "Invalid string"} end

				local usedCodes = self.PlayerUsedCodes[player]

				if type(usedCodes) == "table" then
					if not table.find(usedCodes, code) then
						if self.PromoCodes[code] then
							return {true}
						else
							return {false, "Invalid code"}
						end
					else
						return {false, "Already redeemed"}
					end
				else
					return {false, "Handling error; try again"}
				end
			end)

			if not success then
				if result then
					warn(result)
				end

				return false, "Handling error; try again"
			else
				return result[1], result[2]
			end
		end,

		Handle = function(self, player : Player, code : string)
			if self.PlayerUsedCodes[player] then
				table.insert(self.PlayerUsedCodes[player], string.upper(code))
				PlayerDataService:SetValue(player, "UsedCodes", self.PlayerUsedCodes[player])
				return true
			else
				return false
			end
		end,

		["EXAMPLECODE"] = function(player : Player)
			local success, result = pcall(function()
				-- give reward(s)
				return true
			end)

			if success and result then
				return true
			end

			return false
		end,

		["DEV_CODE_0723"] = function(player : Player)
			local success, result = pcall(function()
				local newBalance = CurrencyService:Add(player, "Cash", 1000)

				local success2, err2 = pcall(function()
					AnalyticsService:LogEconomyEvent(
						player,
						Enum.AnalyticsEconomyFlowType.Source,
						"Cash",
						1000,
						newBalance,
						Enum.AnalyticsEconomyTransactionType.ContextualPurchase.Name,
						"PromoCodes"
					)
				end)

				if not success2 then warn(err2) end

				return newBalance
			end)

			if success and result then
				return true
			end

			return false
		end,

		["10KLIKES"] = function(player : Player)
			local success, result = pcall(function()
				local newBalance = CurrencyService:Add(player, "Cash", 100)

				local success2, err2 = pcall(function()
					AnalyticsService:LogEconomyEvent(
						player,
						Enum.AnalyticsEconomyFlowType.Source,
						"Cash",
						100,
						newBalance,
						Enum.AnalyticsEconomyTransactionType.ContextualPurchase.Name,
						"PromoCodes"
					)
				end)

				if not success2 then warn(err2) end

				return newBalance
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		["20KLIKES"] = function(player : Player)
			local success, result = pcall(function()
				local newBalance = CurrencyService:Add(player, "Cash", 200)

				local success2, err2 = pcall(function()
					AnalyticsService:LogEconomyEvent(
						player,
						Enum.AnalyticsEconomyFlowType.Source,
						"Cash",
						200,
						newBalance,
						Enum.AnalyticsEconomyTransactionType.ContextualPurchase.Name,
						"PromoCodes"
					)
				end)

				if not success2 then warn(err2) end

				return newBalance
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		["30KLIKES"] = function(player : Player)
			local success, result = pcall(function()
				local newBalance = CurrencyService:Add(player, "Cash", 300)

				local success2, err2 = pcall(function()
					AnalyticsService:LogEconomyEvent(
						player,
						Enum.AnalyticsEconomyFlowType.Source,
						"Cash",
						300,
						newBalance,
						Enum.AnalyticsEconomyTransactionType.ContextualPurchase.Name,
						"PromoCodes"
					)
				end)

				if not success2 then warn(err2) end

				return newBalance
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		["40KLIKES"] = function(player : Player)
			local success, result = pcall(function()
				local newBalance = CurrencyService:Add(player, "Cash", 400)

				local success2, err2 = pcall(function()
					AnalyticsService:LogEconomyEvent(
						player,
						Enum.AnalyticsEconomyFlowType.Source,
						"Cash",
						400,
						newBalance,
						Enum.AnalyticsEconomyTransactionType.ContextualPurchase.Name,
						"PromoCodes"
					)
				end)

				if not success2 then warn(err2) end

				return newBalance
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		["SPACE"] = function(player : Player)
			local success, result = pcall(function()
				local newBalance = CurrencyService:Add(player, "Cash", 250)

				local success2, err2 = pcall(function()
					AnalyticsService:LogEconomyEvent(
						player,
						Enum.AnalyticsEconomyFlowType.Source,
						"Cash",
						250,
						newBalance,
						Enum.AnalyticsEconomyTransactionType.ContextualPurchase.Name,
						"PromoCodes"
					)
				end)

				if not success2 then warn(err2) end

				return newBalance
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		["RUSSO"] = function(player : Player)
			local success, result = pcall(function()
				if not InventoryService:FindItem(player, "Cards", "Blue") then
					InventoryService:AddItem(player, "Cards", "Blue")
				end
				
				if not InventoryService:FindItem(player, "Potions", "Blue") then
					InventoryService:AddItem(player, "Potions", "Blue")
				end
				
				if not InventoryService:FindItem(player, "Voices", "Russo") then
					InventoryService:AddItem(player, "Voices", "Russo")
				end
				
				return true
			end)

			if success and result then
				return true
			end

			return false
		end,
	},

	GroupRewards = {
		IsEligible = function(self, player : Player, rewardNum : number)
			local success, result = pcall(function()
				if type(rewardNum) ~= "number" then return {false, "Invalid reward number"} end

				if self.PlayerLogIns and self.PlayerLogIns[player] and self.PlayerLogIns[player].Data then
					if Utils.isInGroupAsync(player.UserId, self.GroupId) then
						return {(tonumber(self.PlayerLogIns[player].Data.LogInData.CurrentDay) == rewardNum) and (not self.PlayerLogIns[player].Data:GetLastDate() or self.PlayerLogIns[player].Data:HasDayPassed())}
					else
						return {false, "Not in group"}
					end
				else
					return {false, "Handling error; try again"}
				end
			end)

			if not success then
				if result then
					warn(result)
				end

				return false, "Handling error; try again"
			else
				return result[1], result[2]
			end
		end,

		Handle = function(self, player : Player)
			if self.PlayerLogIns and self.PlayerLogIns[player] and self.PlayerLogIns[player].Data then
				local previousDate = self.PlayerLogIns[player].Data:GetLastDate()

				self.PlayerLogIns[player].Data:SetLastDate(os.time())
				self.PlayerLogIns[player].Data:AddDay()

				if not previousDate then
					self.PlayerLogIns[player].Data:SetDayStreak(1)
				else
					self.PlayerLogIns[player].Data:SetDayStreak(self.PlayerLogIns[player].Data.LogInData.DayStreak + 1)
				end

				return true
			else
				return false
			end
		end,

		[1] = function(player : Player)
			local success, result = pcall(function()
				-- give reward(s)
				return true
			end)

			if success and result then
				return true
			end

			return false
		end,
	},

	PlayTimeRequirements = {
		[1] = 60,
		[2] = 60*5,
		[3] = 60*10,
		[4] = 60*15,
		[5] = 60*30,
		[6] = 60*45,
		[7] = 60*60,
		[8] = 60*120,
		[9] = 60*300
	},

	PlayRewards = {
		IsEligible = function(self, player : Player, rewardNum : number)
			local success, result = pcall(function()
				if type(rewardNum) ~= "number" then return false end

				local playerTick = player:FindFirstChild("JoinTick")
				local playerTickVal = playerTick and playerTick.Value

				if playerTickVal and self.PlayTimeRequirements[rewardNum] and os.time() - playerTickVal > self.PlayTimeRequirements[rewardNum] and not table.find(self.PlayerPlayRewards[player], rewardNum) then
					return true
				else
					return false
				end
			end)

			if not success then
				if result then
					warn(result)
				end

				return false, "Handling error; try again"
			else
				return result
			end
		end,

		Handle = function(self, player : Player, rewardNum : number)
			if self.PlayerPlayRewards[player] then
				table.insert(self.PlayerPlayRewards[player], rewardNum)
				return true
			else
				return false
			end
		end,

		[1] = function(player : Player)
			local success, result = pcall(function()
				-- give reward(s)
				return true
			end)

			if success and result then
				return true
			end

			return false
		end,
	},

	BattlePassRequirements = {
		[1] = BattlePassItems[1].Price,
		[2] = BattlePassItems[2].Price,
		[3] = BattlePassItems[3].Price,
		[4] = BattlePassItems[4].Price,
		[5] = BattlePassItems[5].Price,
		[6] = BattlePassItems[6].Price,
		[7] = BattlePassItems[7].Price,
		[8] = BattlePassItems[8].Price,
		[9] = BattlePassItems[9].Price,
		[10] = BattlePassItems[10].Price,
		[11] = BattlePassItems[11].Price,
		[12] = BattlePassItems[12].Price,
		[13] = BattlePassItems[13].Price,
		[14] = BattlePassItems[14].Price,
		[15] = BattlePassItems[15].Price,
		[16] = BattlePassItems[16].Price,
		[17] = BattlePassItems[17].Price,
		[18] = BattlePassItems[18].Price,
		[19] = BattlePassItems[19].Price,
		[20] = BattlePassItems[20].Price,
		[21] = BattlePassItems[21].Price,
		[22] = BattlePassItems[22].Price,
		[23] = BattlePassItems[23].Price,
		[24] = BattlePassItems[24].Price,
		[25] = BattlePassItems[25].Price,
		[26] = BattlePassItems[26].Price,
		[27] = BattlePassItems[27].Price,
		[28] = BattlePassItems[28].Price,
		[29] = BattlePassItems[29].Price,
		[30] = BattlePassItems[30].Price,
		[31] = BattlePassItems[31].Price,
		[32] = BattlePassItems[32].Price,
		[33] = BattlePassItems[33].Price,
		[34] = BattlePassItems[34].Price,
		[35] = BattlePassItems[35].Price,
		[36] = BattlePassItems[36].Price,
		[37] = BattlePassItems[37].Price,
		[38] = BattlePassItems[38].Price,
		[39] = BattlePassItems[39].Price,
		[40] = BattlePassItems[40].Price,
		[41] = BattlePassItems[41].Price,
		[42] = BattlePassItems[42].Price,
		[43] = BattlePassItems[43].Price,
		[44] = BattlePassItems[44].Price,
		[45] = BattlePassItems[45].Price,
		[46] = BattlePassItems[46].Price,
		[47] = BattlePassItems[47].Price,
		[48] = BattlePassItems[48].Price,
	},
	
	BattlePass = {
		IsEligible = function(self, player : Player, rewardNum : number)
			local success, result = pcall(function()
				if type(rewardNum) ~= "number" then return {false, "Invalid reward number"} end

				local redeemedPasses = self.SummerBattlePasses[player]

				if type(redeemedPasses) == "table" and not table.find(redeemedPasses, rewardNum) and self.BattlePassRequirements[rewardNum] and CurrencyService:CanPlayerAfford(player, "Beach Balls", self.BattlePassRequirements[rewardNum]) then
					return true
				else
					return false
				end
			end)

			if not success then
				if result then
					warn(result)
				end

				return false, "Handling error; try again"
			else
				return result
			end
		end,

		Handle = function(self, player : Player, rewardNum : number)
			if type(self.SummerBattlePasses[player]) == "table" then
				table.insert(self.SummerBattlePasses[player], rewardNum)
				PlayerDataService:SetValue(player, "Summer2025BattlePass", self.SummerBattlePasses[player])
				return true
			else
				return false
			end
		end,

		[1] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		[2] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		[3] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[4] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		[5] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[6] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		[7] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[8] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		[9] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[10] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		[11] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[12] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		[13] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[14] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[15] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[16] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[17] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[18] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[19] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[20] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[21] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[22] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[23] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[24] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		[25] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[26] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[27] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[28] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[29] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[30] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[31] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[32] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[33] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[34] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[35] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[36] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,
		
		[37] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[38] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[39] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[40] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[41] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[42] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[43] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[44] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[45] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[46] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[47] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,

		[48] = function(player : Player, rewardNum : number)
			local success, result = pcall(function()
				if InventoryService:FindItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value) then warn("Reward item already owned") return false end

				local inv = InventoryService:AddItem(player, BattlePassItems[rewardNum].Type, BattlePassItems[rewardNum].Value)

				return inv
			end)

			if success and result then
				return true
			end

			return false
		end,
	},

	Client = {
		DataChanged = Knit.CreateSignal()
	}
}

function Rewards:GetPlayTimeRequirements() : {number}
	return self.PlayTimeRequirements
end

function Rewards:GetBattlePassRequirements() : {number}
	return self.BattlePassRequirements
end

function Rewards:AttemptClaim(player : Player, rewardType : string, currentReward : any) : boolean?
	if currentReward ~= "Eligible" and currentReward ~= "Handle" then
		local rewardNum = (tonumber(currentReward)) or (type(currentReward) == "string" and string.upper(currentReward)) or (currentReward)
		local rewards = rewardNum and self[rewardType]

		if rewards and rewards.IsEligible then
			local isEligible, result = rewards.IsEligible(self, player, rewardNum)

			if isEligible then
				if rewards.Handle then
					local successfulHandle = rewards.Handle(self, player, rewardNum)

					if not successfulHandle then
						return nil, "Handling error; try again"
					end
				end

				if rewards[rewardNum] then
					rewards[rewardNum](player, rewardNum)
				end

				return true, "Successfully redeemed!"
			else
				return false, result
			end
		end
	end

	return nil, "Invalid"
end

function Rewards:GetFriendsOfPlayer(player : Player) : {Player}
	local playerFriends = {}

	for _, v in pairs(Players:GetPlayers()) do
		if v.UserId ~= player.UserId and v:IsFriendsWith(player.UserId) then
			table.insert(playerFriends, v)
		end
	end

	return playerFriends
end

function Rewards:GetLogInData(player : Player) : LogIn.LogInData?
	if self.PlayerLogIns[player] and self.PlayerLogIns[player].Data then
		return self.PlayerLogIns[player].Data.LogInData
	else
		return nil
	end
end

function Rewards.Client:GetPlayTimeRequirements(player : Player) : {number}
	return self.Server:GetPlayTimeRequirements()
end

function Rewards.Client:GetBattlePassRequirements(player : Player) : {number}
	return self.Server:GetBattlePassRequirements()
end

function Rewards.Client:AttemptClaim(player : Player, rewardType : string, currentReward : number | string) : boolean
	return self.Server:AttemptClaim(player, rewardType, currentReward)
end

function Rewards.Client:GetFriendsOfPlayer(player : Player) : {Player}
	return self.Server:GetFriendsOfPlayer(player)
end

function Rewards.Client:GetLogInData(player : Player) : LogIn.LogInData?
	return self.Server:GetLogInData(player)
end

function Rewards:OnPlayerRemoved(player : Player)
	local success, err = pcall(function()
		if self.PlayerLogIns[player] then
			if self.PlayerLogIns[player].Data then
				self.PlayerLogIns[player].Data:Destroy()
			end

			if self.PlayerLogIns[player].Connection then
				self.PlayerLogIns[player].Connection:Disconnect()
			end
		end
	end)

	if not success then
		warn(err)
	end

	self.PlayerLogIns[player] = nil
	self.PlayerPlayRewards[player] = nil
	self.SummerBattlePasses[player] = nil
	self.PlayerUsedCodes[player] = nil
end

function Rewards:OnDataLoaded(player : Player, data : any)
	self.PlayerLogIns[player] = {}
	self.PlayerPlayRewards[player] = {}
	self.SummerBattlePasses[player] = data.Data.Summer2025BattlePass or {}
	self.PlayerUsedCodes[player] = data.Data.UsedCodes or {}
	self.PlayerLogIns[player].Data = LogIn.new(player, data.Data.LogInData)
	self.PlayerLogIns[player].Connection = self.PlayerLogIns[player].Data.DataChanged:Connect(function(newData)
		PlayerDataService:SetValue(player, "LogInData", newData)
		self.Client.DataChanged:Fire(player, newData)
	end)
end

function Rewards:KnitInit()
	CurrencyService = Knit.GetService("CurrencyService")
	ItemService = Knit.GetService("ItemService")
	InventoryService = Knit.GetService("InventoryService")
	PlayerDataService = Knit.GetService("PlayerDataService")

	CurrencyService.CurrencyChanged:Connect(function(player, currencyName, currencyAmount)
		local requirements = self:GetBattlePassRequirements()
		
		if currencyName == "Beach Balls" then
			if type(self.SummerBattlePasses[player]) == "table" and type(requirements) == "table" then
				for i, v in requirements do
					if currencyAmount >= v and not table.find(self.SummerBattlePasses[player], i) then
						local success, result = self:AttemptClaim(player, "BattlePass", i)
						
						if not success then
							warn(result)
						end
					end
				end
			end
			
			if currencyAmount >= 60000 then
				Utils.awardBadge(player, BadgeIds.Summer, 5)
			end
		end
	end)

	RunService.Heartbeat:Connect(function()
		CurrentTick.Value = os.time()

		local timeLeft = DateTime.fromUniversalTime(2025, 9, 8, 3).UnixTimestamp - DateTime.now().UnixTimestamp
		
		if timeLeft > 0 or EventTimer.Value ~= 0 then
			EventTimer.Value = timeLeft
		end
	end)

	print(script.Name .. " initialized")
end

function Rewards:KnitStart()
	print(script.Name .. " started")
end

return Rewards