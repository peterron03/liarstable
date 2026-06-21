--[[
@TheAlmightyForehead
May 9th, 2024
This handles (most of) the server-sided shop functions
]]

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local AnalyticsService = game:GetService("AnalyticsService")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local ItemService
local CurrencyService
local InventoryService
local PlayerDataService
local ChatTagService

-- UTILITIES --
local Utilities = ReplicatedStorage:WaitForChild("Utilities")
local Utils = require(Utilities:WaitForChild("Utils"))
local ProductIds = require(Utilities:WaitForChild("ProductIds"))

-- VALUES --
local Values = ReplicatedStorage:WaitForChild("Values")
local TimeUntilReset = Values:WaitForChild("TimeUntilReset")

-- DATE TIME --
local uTime = DateTime.now():ToUniversalTime()

local Shop = Knit.CreateService {
	Name = "ShopService",
	
	GamePassPurchaseFinished = Signal.new(),
	
	GamepassItems = {},
	OwnedPasses = {},
	GiftedPasses = {},
	GiftCredits = {},
	LastGifted = {},
	GamePassWhitelist = {},
	GamePassBlacklist = {},
	
	WeightedItems = {},
	
	AllItems = {},
	Seed = uTime.Day .. uTime.Month .. uTime.Year,
	
	DevProducts = {
		[2652699102] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			
			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Cash", 300)
					
					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Cash",
							300,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought300Cash"
						)
					end)
					
					if not success2 then warn(err2) end
					
					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,
		
		[2652699176] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)

			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Cash", 900)

					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Cash",
							900,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought900Cash"
						)
					end)

					if not success2 then warn(err2) end

					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,
		
		[2652699248] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)

			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Cash", 2700)

					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Cash",
							2700,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought2700Cash"
						)
					end)

					if not success2 then warn(err2) end

					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,
		
		[2652699314] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)

			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Cash", 5400)

					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Cash",
							5400,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought5400Cash"
						)
					end)

					if not success2 then warn(err2) end

					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,
		
		[2652699470] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)

			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Cash", 8100)

					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Cash",
							8100,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought8100Cash"
						)
					end)

					if not success2 then warn(err2) end

					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,
		
		[2652699577] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)

			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Cash", 10400)

					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Cash",
							10400,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought10400Cash"
						)
					end)

					if not success2 then warn(err2) end

					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,
		
		[ProductIds["Beach Balls"][1].Id] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)

			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Beach Balls", 100)

					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Beach Balls",
							100,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought100BeachBalls"
						)
					end)

					if not success2 then warn(err2) end

					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,

		[ProductIds["Beach Balls"][2].Id] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)

			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Beach Balls", 500)

					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Beach Balls",
							500,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought500BeachBalls"
						)
					end)

					if not success2 then warn(err2) end

					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,

		[ProductIds["Beach Balls"][3].Id] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)

			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Beach Balls", 2500)

					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Eggs",
							2500,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought2500BeachBalls"
						)
					end)

					if not success2 then warn(err2) end

					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,

		[ProductIds["Beach Balls"][4].Id] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)

			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Beach Balls", 5000)

					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Beach Balls",
							5000,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought5000BeachBalls"
						)
					end)

					if not success2 then warn(err2) end

					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,

		[ProductIds["Beach Balls"][5].Id] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)

			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Beach Balls", 10000)

					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Beach Balls",
							900,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought10KBeachBalls"
						)
					end)

					if not success2 then warn(err2) end

					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,

		[ProductIds["Beach Balls"][6].Id] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)

			if player then
				local success, result = pcall(function()
					local newBalance = CurrencyService:Add(player, "Beach Balls", 20000)

					local success2, err2 = pcall(function()
						AnalyticsService:LogEconomyEvent(
							player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Beach Balls",
							20000,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.IAP.Name,
							"Bought20KBeachBalls"
						)
					end)

					if not success2 then warn(err2) end

					return newBalance
				end)

				if success and result then
					return true
				else
					return false, "Error while handling"
				end
			else
				return false, "Player not found"
			end
		end,
		
		[ProductIds.Cash[1].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds.Cash[1]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Cash")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,

		[ProductIds.Cash[2].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds.Cash[2]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Cash")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,

		[ProductIds.Cash[3].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds.Cash[3]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Cash")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,

		[ProductIds.Cash[4].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds.Cash[4]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Cash")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,

		[ProductIds.Cash[5].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds.Cash[5]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Cash")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,

		[ProductIds.Cash[6].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds.Cash[6]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Cash")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,

		[ProductIds["Beach Balls"][1].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds["Beach Balls"][1]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Beach Balls")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,

		[ProductIds["Beach Balls"][2].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds["Beach Balls"][2]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Beach Balls")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,

		[ProductIds["Beach Balls"][3].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds["Beach Balls"][3]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Beach Balls")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,

		[ProductIds["Beach Balls"][4].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds["Beach Balls"][4]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Beach Balls")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,

		[ProductIds["Beach Balls"][5].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds["Beach Balls"][5]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Beach Balls")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,

		[ProductIds["Beach Balls"][6].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds["Beach Balls"][6]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "Product", product.Amount .. " Beach Balls")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,
		
		[ProductIds.Passes["VIP"].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local product = ProductIds.Passes["VIP"]
			local normalId = product.Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "GamePass", "VIP")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,
		
		[ProductIds.Passes["Bigger Table"].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local normalId = ProductIds.Passes["Bigger Table"].Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "GamePass", "Bigger Table")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,
		
		[ProductIds.Passes["Radio"].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local normalId = ProductIds.Passes["Radio"].Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "GamePass", "Radio")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,
		
		[ProductIds.Passes["Headspin"].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local normalId = ProductIds.Passes["Headspin"].Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "GamePass", "Headspin")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,
		
		[ProductIds.Passes["Too Many Potions"].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local normalId = ProductIds.Passes["Too Many Potions"].Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "GamePass", "Too Many Potions")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,
		
		[ProductIds.Passes["Space Pack"].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local normalId = ProductIds.Passes["Space Pack"].Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "GamePass", "Space Pack")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,
		
		[ProductIds.Passes["x2 Beach Balls"].Gift] = function(self, playerId : number)
			local player = Players:GetPlayerByUserId(playerId)
			local normalId = ProductIds.Passes["x2 Beach Balls"].Id

			if self.LastGifted[player] then
				local playerBeingGifted = self.LastGifted[player]

				if player then
					if playerBeingGifted then
						local success, result = pcall(function()
							local giftSuccess = self:AttemptGift(player, playerBeingGifted, normalId, "GamePass", "x2 Beach Balls")
							return giftSuccess
						end)

						if success and result then
							return true
						else
							return false, "Error while handling"
						end
					else
						self:AddGiftCredit(player, normalId)

						warn("Player to gift not found")

						return true
					end
				else
					return false, "Player not found"
				end
			else
				self:AddGiftCredit(player, normalId)

				warn("Last gifted not found")

				return true
			end
		end,
	},
	
	Client = {
		UserOwnsGamePassChanged = Knit.CreateSignal(),
		UpdateUserGamePasses = Knit.CreateSignal(),
		ShopItemsChanged = Knit.CreateSignal(),
		PlayerGifted = Knit.CreateSignal(),
	}
}

function Shop:GetShopFolder() : Folder
	if not self.ShopFolder then
		self.ShopFolder = Instance.new("Folder")
		self.ShopFolder.Name = script.Name .. "_STORAGE"
		self.ShopFolder.Parent = ReplicatedStorage

		for _, v in pairs(script:GetChildren()) do
			v.Parent = self.ShopFolder
		end
	end
	
	return self.ShopFolder
end

function Shop:SetSeed(seed : number?)
	local universalTime = DateTime.now():ToUniversalTime()
	self.Seed = (seed) or (universalTime.Day .. universalTime.Month .. universalTime.Year)
end

function Shop:GetSeed()
	local universalTime = DateTime.now():ToUniversalTime()
	return universalTime.Day .. universalTime.Month .. universalTime.Year
end

function Shop:SetAllItemsWith(statName : string, statAmount : any, currencyType : string, itemTypes : {string}?, forSale : boolean?)
	for _, itemType in pairs(ItemService:GetItemTypes()) do
		if itemTypes and not table.find(itemTypes, itemType) then continue end
		
		if not self.AllItems[itemType] then
			self.AllItems[itemType] = {}
		end
		
		if not self.AllItems[itemType][statName] then
			self.AllItems[itemType][statName] = {}
		end
		
		self.AllItems[itemType][statName][statAmount] = {}
		
		for _, item in pairs(ItemService:GetAllItems(itemType, forSale)) do
			if item.CurrencyType == currencyType and item[statName] == statAmount then
				if type(self.WeightedItems[itemType]) == "table" and type(self.WeightedItems[itemType][item.Name]) == "number" then
					for i = 1, self.WeightedItems[itemType][item.Name] do
						table.insert(self.AllItems[itemType][statName][statAmount], item)
					end
				else
					table.insert(self.AllItems[itemType][statName][statAmount], item)
				end
			end
		end
	end
end

function Shop:SetCurrentShopItems(statName : string)
	local randomItems = {}
	local random = Random.new(self.Seed)
	
	for itemType, allStats in pairs(self.AllItems) do
		randomItems[itemType] = {}
		
		for nameOfStat, stat in pairs(allStats) do
			if nameOfStat == statName then
				for amount, items in pairs(stat) do
					randomItems[itemType][amount] = items[random:NextInteger(1, #items)]
				end
			end
		end
	end
	
	self.CurrentShopItems = randomItems
	
	self.Client.ShopItemsChanged:FireAll(randomItems)
	
	return self.CurrentShopItems
end

function Shop:GetCurrentShopItems()
	if not self.CurrentShopItems then
		repeat task.wait() until self.CurrentShopItems
	end
	
	return self.CurrentShopItems
end

function Shop:UserOwnsGamePass(player : Player, passId : number, promptIfFalse : boolean?) : boolean
	if table.find(self.GamePassWhitelist, player.UserId) then
		return true
	elseif table.find(self.GamePassBlacklist, player.UserId) then
		return false
	end
	
	if type(self.OwnedPasses[player]) == "table" then
		if not self.OwnedPasses[player][passId] then
			self.OwnedPasses[player][passId] = (type(self.GiftedPasses[player]) == "table" and self.GiftedPasses[player][passId]) or (MarketplaceService:UserOwnsGamePassAsync(player.UserId, passId))
			
			if self.OwnedPasses[player][passId] then
				self.Client.UserOwnsGamePassChanged:Fire(player, passId, self.OwnedPasses[player][passId])
			end
		end
		
		if not self.OwnedPasses[player][passId] and promptIfFalse then
			MarketplaceService:PromptGamePassPurchase(player, passId)
		end
		
		return self.OwnedPasses[player][passId]
	else
		return false
	end
end

function Shop:GetUserOwnedGamePasses(player : Player) : {[number] : string} 
	local success, err = pcall(function()
		for _, v in pairs(ProductIds.Passes) do
			self:UserOwnsGamePass(player, v.Id)
		end
		
		if type(self.GiftedPasses[player]) == "table" then
			for productId, value in pairs(self.GiftedPasses[player]) do
				if type(self.OwnedPasses[player]) == "table" then
					self.OwnedPasses[player][tonumber(productId)] = value
				end
			end
		end
	end)
	
	if not success then
		warn(err)
	end
	
	return self.OwnedPasses[player] or {}
end

function Shop:GetAmountNeededForPrice(player : Player, currencyType : string, price : number) : number
	local currencyAmount = CurrencyService:GetAmount(player, currencyType)
	
	if type(currencyAmount) == "number" then
		return price - currencyAmount
	else
		return 0
	end
end

function Shop:AttemptPurchaseShopItem(player : Player, itemType : string, itemName : string, promptIfFalse : boolean?)
	local item
	
	if type(self.CurrentShopItems) == "table" and type(self.CurrentShopItems[itemType]) == "table" then
		for amount, shopItem in pairs(self.CurrentShopItems[itemType]) do
			if shopItem.Type == itemType and shopItem.Name == itemName then
				item = shopItem
				break
			end
		end
	end
	
	if item then
		return self:AttemptPurchase(player, item.Type, item.Name, false, false, true)
	else
		return false, "Unable to find item"
	end
end

function Shop:PromptLowestProduct(player : Player, currencyType : string, itemPrice : number)
	if ProductIds[currencyType] then
		local amountNeeded = self:GetAmountNeededForPrice(player, currencyType, itemPrice)

		if type(amountNeeded) == "number" and amountNeeded > 0 then
			local productId

			for i, v in ipairs(ProductIds[currencyType]) do
				if v.Amount >= amountNeeded or i == #ProductIds[currencyType] then
					productId = v.Id
					break
				end
			end

			if productId then
				MarketplaceService:PromptProductPurchase(player, productId)
			end
		end
	end
end

function Shop:AttemptPurchase(player : Player, itemType : string, itemName : string, equipOnPurchase : boolean?, noInventory : boolean?, promptLowestProduct : boolean?) : (boolean, string?)
	local item = ItemService:FindItem(itemType, itemName)
	
	if item and item.Price and item.ForSale and item.CurrencyType then
		if noInventory or not InventoryService:FindItem(player, itemType, itemName) then
			if item.CurrencyType ~= "Robux" and CurrencyService:CanPlayerAfford(player, item.CurrencyType, item.Price) then
				local leftoverBalance = CurrencyService:Subtract(player, item.CurrencyType, item.Price)
				
				if not noInventory then
					InventoryService:AddItem(player, itemType, itemName)
				end
				
				if equipOnPurchase then
					InventoryService:EquipItem(player, itemType, itemName)
				end
				
				local success, err = pcall(function()
					AnalyticsService:LogEconomyEvent(
						player,
						Enum.AnalyticsEconomyFlowType.Sink,
						item.CurrencyType,
						item.Price,
						leftoverBalance,
						Enum.AnalyticsEconomyTransactionType.Shop.Name,
						item.Type
					)
				end)
				
				if not success then warn(err) end
				
				return true
			elseif item.CurrencyType == "Robux" and tonumber(item.GamepassId) then
				if self:UserOwnsGamePass(player, item.GamepassId, true) then
					if not noInventory then
						InventoryService:AddItem(player, itemType, itemName)
					end

					if equipOnPurchase then
						InventoryService:EquipItem(player, itemType, itemName)
					end
					
					return true
				else
					return false
				end
			else
				if promptLowestProduct then
					self:PromptLowestProduct(player, item.CurrencyType, item.Price)
				end
				
				return false, "Insufficient funds"
			end
		else
			return false, "Item already owned"
		end
	else
		return false, "Item details not found"
	end
end

function Shop:AttemptEquip(player : Player, itemType : string, itemName : string)
	if InventoryService:FindItem(player, itemType, itemName) then
		InventoryService:EquipItem(player, itemType, itemName)
		return true
	end
	
	return false
end

function Shop:AddGiftCredit(player : Player, productId : number | string) : boolean
	productId = tostring(productId)
	
	if type(self.GiftCredits[player]) == "table" then
		if type(self.GiftCredits[player][productId]) == "number" then
			self.GiftCredits[player][productId] += 1
		else
			self.GiftCredits[player][productId] = 1
		end
		
		local saveSuccess = PlayerDataService:SetValue(player, "GiftCredits", self.GiftCredits[player])
		
		return saveSuccess
	else
		return false
	end
end

function Shop:RedeemGiftCredit(player : Player, productId : number | string) : boolean
	productId = tostring(productId)
	
	if type(self.GiftCredits[player]) == "table" then
		if type(self.GiftCredits[player][productId]) == "number" and self.GiftCredits[player][productId] > 0 then
			self.GiftCredits[player][productId] -= 1
		end

		local saveSuccess = PlayerDataService:SetValue(player, "GiftCredits", self.GiftCredits[player])

		return saveSuccess
	else
		return false
	end
end

function Shop:GetGiftCredit(player : Player, productId : number | string) : number?
	productId = tostring(productId)

	if type(self.GiftCredits[player]) == "table" then
		return self.GiftCredits[player][productId]
	end

	return nil
end

function Shop:HasGiftCredit(player : Player, productId : number | string) : boolean
	productId = tostring(productId)
	
	if type(self.GiftCredits[player]) == "table" then
		if type(self.GiftCredits[player][productId]) == "number" and self.GiftCredits[player][productId] > 0 then
			return true
		end
	end
	
	return false
end

function Shop:GetNormalIdFromGiftId(giftId : number, assetType : ("Passes" | "Cash" | "Eggs")) : number?
	if type(ProductIds[assetType]) ~= "table" then return end
	
	for _, v in pairs(ProductIds[assetType]) do
		if type(v) == "table" and v.Gift == giftId then
			return v.Id
		end
	end
	
	return nil
end

function Shop:AttemptGift(player : Player, playerBeingGifted : Player, productId : number, productType : ("GamePass" | "Product"), productName : string?) : (boolean, string?)
	if productType == "Product" then
		if self.DevProducts[productId] then
			local success, result = self.DevProducts[productId](self, playerBeingGifted.UserId)
			
			if not success then
				warn(result)
				
				self:AddGiftCredit(player, productId)
				
				return true, "Gifted credit; error while gifting dev product"
			else
				local notifSuccess, notifError = pcall(function()
					self.Client.PlayerGifted:Fire(playerBeingGifted, player.Name, productName)
					self.Client.PlayerGifted:Fire(player, playerBeingGifted.Name, productName, "SUCCESS")
				end)

				if not notifSuccess then warn(notifError) end
				
				return true, result
			end
		else
			return false, "ProductId not found"
		end
	elseif productType == "GamePass" then
		if type(self.GiftedPasses[playerBeingGifted]) == "table" then
			self.GiftedPasses[playerBeingGifted][productId] = true
			
			if type(self.OwnedPasses[playerBeingGifted]) == "table" then
				self.OwnedPasses[playerBeingGifted][productId] = true
			end
			
			self.Client.UserOwnsGamePassChanged:Fire(playerBeingGifted, productId, true)
			
			local saveSuccess = PlayerDataService:SetValue(playerBeingGifted, "GiftedPasses", self.GiftedPasses[playerBeingGifted])
			
			if not saveSuccess then
				self:AddGiftCredit(player, productId)
				
				return true, "Error while saving gifted passes"
			end
			
			local success, err = pcall(function()
				self:GiveGamePassItems(playerBeingGifted)
			end)
			
			if not success then warn(err) end
			
			local notifSuccess, notifError = pcall(function()
				self.Client.PlayerGifted:Fire(playerBeingGifted, player.Name, productName)
				self.Client.PlayerGifted:Fire(player, playerBeingGifted.Name, productName, "SUCCESS")
			end)
			
			if not notifSuccess then warn(notifError) end
			
			return true, "Gifted game pass"
		else
			self:AddGiftCredit(player, productId)
			return true, "Gifted credit; gifted passes not found"
		end
	else
		return false, "Invalid ProductType"
	end
end

function Shop:GiveGamePassItems(player : Player)
	if not self.LoadedPassItems then
		for _, itemType in pairs(ItemService:GetItemTypes()) do
			for index, item in pairs(ItemService:GetAllItems(itemType, true)) do
				if type(item.GamepassId) == "table" then
					for _, passId in pairs(item.GamepassId) do
						if type(passId) ~= "number" then continue end
						
						if not self.GamepassItems[passId] then
							self.GamepassItems[passId] = {}
						end

						self.GamepassItems[passId][itemType] = item
					end
				elseif type(item.GamepassId) == "number" then
					if not self.GamepassItems[item.GamepassId] then
						self.GamepassItems[item.GamepassId] = {}
					end

					self.GamepassItems[item.GamepassId][itemType] = item
				end
			end
		end
		
		self.LoadedPassItems = true
	end
	
	for i, v in pairs(self.GamepassItems) do
		if self:UserOwnsGamePass(player, i) and type(v) == "table" then
			for _, item in pairs(v) do
				if not InventoryService:FindItem(player, item.Type, item.Name) then
					InventoryService:AddItem(player, item.Type, item.Name)
				end
			end
		end
	end
end

function Shop:AttemptGiftPurchase(player : Player, userBeingGifted : number, assetId : number, assetType : string?) : (boolean, string?)
	if self.LastGifted[player] then return false, "Last gifted currently active" end
	
	if type(userBeingGifted) == "number" then
		self.LastGifted[player] = Players:GetPlayerByUserId(userBeingGifted)

		if not self.LastGifted[player] then
			return false, "Gifted player not found"
		end
	else
		self.LastGifted[player] = nil

		return false, "UserId for gifted user is NOT a number"
	end

	local success, err = pcall(function()
		local passNormalId = self:GetNormalIdFromGiftId(assetId, "Passes")
		local productNormalId = self:GetNormalIdFromGiftId(assetId, "Cash") or self:GetNormalIdFromGiftId(assetId, "Eggs")
		local productType = (passNormalId and "GamePass") or ("Product")
		local normalId = passNormalId or productNormalId

		if normalId then
			if productType == "GamePass" and self:UserOwnsGamePass(self.LastGifted[player], normalId) then
				self.LastGifted[player] = nil 
				
				return
			end

			if self:HasGiftCredit(player, normalId) then
				local success, msg = self.DevProducts[assetId](self, player.UserId)

				if success then
					self:RedeemGiftCredit(player, normalId)
				elseif msg then
					warn(msg)
				end

				self.LastGifted[player] = nil

				return
			end
		end

		MarketplaceService:PromptProductPurchase(player, assetId)
	end)
	
	if not success then
		warn(err)
		self.LastGifted[player] = nil
	end

	return success, err
end

function Shop:GetGiftCreditsFor(player : Player, assetId : number) : number?
	local normalId = self:GetNormalIdFromGiftId(assetId, "Cash") or self:GetNormalIdFromGiftId(assetId, "Passes")
	
	if normalId and self:HasGiftCredit(player, normalId) then
		return self:GetGiftCredit(player, normalId)
	else
		return nil
	end
end

function Shop.Client:GetGiftCreditsFor(player : Player, assetId : number) : number?
	return self.Server:GetGiftCreditsFor(player, assetId)
end

function Shop.Client:AttemptPurchaseShopItem(player : Player, itemType : string, itemName : string) : (boolean, string?)
	return self.Server:AttemptPurchaseShopItem(player, itemType, itemName)
end

function Shop.Client:PromptLowestProduct(player : Player, currencyType : string, itemPrice : string)
	return self.Server:PromptLowestProduct(player, currencyType, itemPrice)
end

--[[function Shop.Client:AttemptPurchase(player : Player, itemType : string, itemName : string, equipOnPurchase : boolean?) : (boolean, string?)
	return self.Server:AttemptPurchase(player, itemType, itemName, equipOnPurchase)
end]]

function Shop.Client:AttemptEquip(player : Player, itemType : string, itemName : string)
	return self.Server:AttemptEquip(player, itemType, itemName)
end

function Shop.Client:UserOwnsGamePass(player : Player, passId : number, promptIfFalse : boolean?) : boolean
	return self.Server:UserOwnsGamePass(player, passId, promptIfFalse)
end

function Shop.Client:GetUserOwnedGamePasses(player : Player) : {[number] : boolean}?
	return self.Server:GetUserOwnedGamePasses(player)
end

function Shop.Client:GetCurrentShopItems(player : Player)
	return self.Server:GetCurrentShopItems()
end

function Shop.Client:GetShopFolder(player : Player) : Folder
	return self.Server:GetShopFolder()
end

function Shop.Client:AttemptGiftPurchase(player : Player, userBeingGifted : number, assetId : number, assetType : string?)
	return self.Server:AttemptGiftPurchase(player, userBeingGifted, assetId, assetType)
end

function Shop.Client:AttemptPromptPurchase(player : Player, assetId : number, assetType : string)
	local success, err = pcall(function()
		if assetType == "Product" then
			MarketplaceService:PromptProductPurchase(player, assetId)
		elseif assetType == "GamePass" then
			MarketplaceService:PromptGamePassPurchase(player, assetId)
		end
	end)
	
	return success, err
end

function Shop:OnPlayerRemoved(player : Player)
	self.OwnedPasses[player] = nil
	self.GiftedPasses[player] = nil
	self.GiftCredits[player] = nil
	self.LastGifted[player] = nil
end

function Shop:OnDataLoaded(player : Player, data : any)
	self.OwnedPasses[player] = {}
	self.GiftedPasses[player] = data.Data.GiftedPasses or {}
	self.GiftCredits[player] = data.Data.GiftCredits or {}
	
	local ownedPasses = self:GetUserOwnedGamePasses(player)
	
	if type(ownedPasses) == "table" then
		self.Client.UpdateUserGamePasses:Fire(player, ownedPasses)
	end
	
	if self.LoadedPassItems then
		self:GiveGamePassItems(player)
	end
	
	if self:UserOwnsGamePass(player, ProductIds.Passes.VIP.Id) then
		ChatTagService:AddTag(player, "⭐VIP", Color3.fromRGB(255, 215, 25))
	end
end

function Shop:InventoryDataLoaded(player : Player, data : any)
	self:GiveGamePassItems(player)
end

function Shop:KnitInit()
	ItemService = Knit.GetService("ItemService")
	CurrencyService = Knit.GetService("CurrencyService")
	InventoryService = Knit.GetService("InventoryService")
	PlayerDataService = Knit.GetService("PlayerDataService")
	ChatTagService = Knit.GetService("ChatTagService")
	
	task.spawn(function()
		local itemTypes = {"Potions", "Voices", "Cards", "Victories"}

		table.clear(self.AllItems)
		
		self:SetAllItemsWith("Price", 250, "Cash", itemTypes, true)
		self:SetAllItemsWith("Price", 750, "Cash", itemTypes, true)
		self:SetAllItemsWith("Price", 2000, "Cash", itemTypes, true)
		self:SetAllItemsWith("Price", 5000, "Cash", itemTypes, true)
		self:SetSeed()
		self:SetCurrentShopItems("Price")

		while task.wait(1) do
			local universalTime = DateTime.now():ToUniversalTime()
			local currentSeed = self:GetSeed()
			
			if self.Seed ~= currentSeed then
				self:SetSeed(currentSeed)
				self:SetCurrentShopItems("Price")
			end

			local secondsLeft = ((23 - universalTime.Hour) * 60 * 60) + ((59 - universalTime.Minute) * 60) + (59 - universalTime.Second)

			TimeUntilReset.Value = secondsLeft
		end
	end)

	task.spawn(function()
		if not self.LoadedPassItems then
			for _, itemType in pairs(ItemService:GetItemTypes()) do
				for index, item in pairs(ItemService:GetAllItems(itemType, true)) do
					if type(item.GamepassId) == "table" then
						for _, passId in pairs(item.GamepassId) do
							if type(passId) ~= "number" then continue end

							if not self.GamepassItems[passId] then
								self.GamepassItems[passId] = {}
							end

							self.GamepassItems[passId][itemType] = item
						end
					elseif type(item.GamepassId) == "number" then
						if not self.GamepassItems[item.GamepassId] then
							self.GamepassItems[item.GamepassId] = {}
						end

						self.GamepassItems[item.GamepassId][itemType] = item
					end
				end
			end

			self.LoadedPassItems = true
		end
	end)
	
	MarketplaceService.PromptProductPurchaseFinished:Connect(function(userId)
		local player = Players:GetPlayerByUserId(userId)
		
		if player then
			self.LastGifted[player] = nil
		end
	end)
	
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, wasPurchased)
		if wasPurchased then
			if type(self.GamepassItems[gamePassId]) == "table" then
				for _, item in pairs(self.GamepassItems[gamePassId]) do
					if type(item) == "table" and item.Type and item.Name then
						if not InventoryService:FindItem(player, item.Type, item.Name) then
							InventoryService:AddItem(player, item.Type, item.Name)
						end
					end
				end
			end
			
			if not self.OwnedPasses[player] then
				self.OwnedPasses[player] = {}
			end

			self.OwnedPasses[player][gamePassId] = true

			self.GamePassPurchaseFinished:Fire(player, gamePassId)
			self.Client.UserOwnsGamePassChanged:Fire(player, gamePassId, self.OwnedPasses[player][gamePassId])
		end
	end)
	
	MarketplaceService.ProcessReceipt = function(receiptInfo)
		local result = nil
		local msg = nil
		
		local success, err = pcall(function()
			result, msg = self.DevProducts[receiptInfo.ProductId](self, receiptInfo.PlayerId)
		end)

		if not success then
			warn(err, receiptInfo.PlayerId)
			return Enum.ProductPurchaseDecision.NotProcessedYet
		elseif not result then
			warn((msg or "Unable to process receipt for "), receiptInfo.PlayerId)
			return Enum.ProductPurchaseDecision.NotProcessedYet
		else
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
	end
	
	print(script.Name .. " initialized")
end

function Shop:KnitStart()
	print(script.Name .. " started")
end

return Shop