--[[
@TheAlmightyForehead
October 18th, 2024
This handles (mostly) the specific components of Liar's Table
]]

-- ROBLOX SERVICES --
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local AnalyticsService = game:GetService("AnalyticsService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- KNIT --
local ReplicatedPackages = ReplicatedStorage:WaitForChild("Packages")
local Knit = require(ReplicatedPackages:WaitForChild("Knit"))
local Accessory = require(ReplicatedPackages:WaitForChild("Accessory"))
local Signal = require(Knit.Util.Signal)
local EnumList = require(Knit.Util.EnumList)

-- KNIT SERVICES --
local ItemService
local InventoryService
local CurrencyService
local ShopService
local ModerationService
local PlayerDataService
local SettingsService
local LeaderboardService

-- MODULES --
local Utilities = ReplicatedStorage:WaitForChild("Utilities")
local Utils = require(Utilities:WaitForChild("Utils"))
local Classes = ServerScriptService:WaitForChild("Classes")
local Table = require(Classes:WaitForChild("Table"))
local BadgeIds = require(Utilities:WaitForChild("BadgeIds"))
local ProductIds = require(Utilities:WaitForChild("ProductIds"))
local UtilSettings = require(Utilities:WaitForChild("Settings"))

-- OBJECTS --
local Objects = ReplicatedStorage:WaitForChild("Objects")
local SeatExample = Objects:WaitForChild("Seat")
local PlacementExample = Objects:WaitForChild("Placement")

-- TYPES --
type Table = Table.Table
type Participant = Table.Participant

local Gameplay = Knit.CreateService {
	Name = "GameplayService",
	
	Tables = {},
	TableSlots = {},
	TableSeats = {},
	
	MotorCFrames = {
		[1] = CFrame.new(-0.4, -0.077, -0.95) * CFrame.Angles(0, math.rad(30), 0),
		[2] = CFrame.new(-0.2, -0.074, -1) * CFrame.Angles(0, math.rad(15), 0),
		[3] = CFrame.new(0, -0.071, -1) * CFrame.Angles(0, 0, 0),
		[4] = CFrame.new(0.2, -0.068, -1) * CFrame.Angles(0, math.rad(-15), 0),
		[5] = CFrame.new(0.4, -0.065, -0.925) * CFrame.Angles(0, math.rad(-30), 0),
	},
	
	Client = {
		TableChanged = Knit.CreateSignal(),
		TableTimerChanged = Knit.CreateSignal(),
		GameLoaded = Knit.CreateSignal(),
		MovementUpdate = Knit.CreateSignal(),
		CardsPlayed = Knit.CreateSignal(),
		PotionDrank = Knit.CreateSignal(),
		PlayerKnockedOut = Knit.CreateSignal(),
		ServerForced = Knit.CreateSignal(),
		PlayerCalledOut = Knit.CreateSignal(),
		RoundStarted = Knit.CreateSignal(),
		TableCancelled = Knit.CreateSignal(),
		GameEnded = Knit.CreateSignal(),
		LivingParticipantsChanged = Knit.CreateSignal(),
		GameStarted = Knit.CreateSignal(),
		RoundEnded = Knit.CreateSignal(),
		StartPotionChoice = Knit.CreateSignal(),
		LoadingGame = Knit.CreateSignal(),
		TurnStarted = Knit.CreateSignal(),
		PlayerLeaving = Knit.CreateSignal(),
		UpdatedVR = Knit.CreateSignal(),
		UpdateEndGame = Knit.CreateSignal(),
		GameEffect = Knit.CreateSignal(),
		SpectatorsChanged = Knit.CreateSignal(),
		RadioUpdated = Knit.CreateSignal(),
		UpdateRadioSongList = Knit.CreateSignal(),
		UpdatedAnimation = Knit.CreateSignal(),
		PotionAdded = Knit.CreateSignal()
	}
}

function Gameplay:GetAllTablesWithPlayer(player : Player) : {Table : Table?, Participant : Participant?}
	local tables = {}
	
	for _, v in self.Tables do
		local index, participant = v:FindParticipantInGame(player)
		
		if participant then
			table.insert(tables, {Table = v, Participant =  participant})
		end
	end
	
	return tables
end

function Gameplay:FindTableWithPlayer(player : Player) : (Table?, Participant?)
	for _, v in self.Tables do
		local index, participant = v:FindParticipantInGame(player)
		
		if participant then
			return v, participant
		end
	end
	
	return nil
end

function Gameplay:FindTableWithHost(player : Player) : Table?
	for _, v in self.Tables do
		if v.Host.Player == player and not v.InProgress then
			return v
		end
	end
	
	return nil
end

function Gameplay:FindTableWithHostId(userId : number) : Table?
	for _, v in self.Tables do
		if v.Host.UserId == userId and not v.InProgress then
			return v
		end
	end

	return nil
end

function Gameplay:GetParticipantPropertiesWithout(participants : {Participant}, without : string) : {Participant}
	local newParticipants = {}
	
	for _, v in participants do
		if type(v) == "table" then
			local newParticipant = {}
			
			for property, value in pairs(v) do
				if property ~= without and type(value) ~= "function" then
					newParticipant[property] = value
				end
			end
			
			table.insert(newParticipants, newParticipant)
		end
	end
	
	return newParticipants
end

function Gameplay:WaitForState(tbl, state, timeout, setStatus)
	local secondsPassed = 0
	local loadedParticipants = tbl:GetLoadedParticipants(state)
	
	if setStatus then
		tbl:SetValue("Status", #loadedParticipants .. "/" .. #tbl:GetParticipantsInGame())
	end

	repeat task.wait(0.5)
		secondsPassed += 0.5
		loadedParticipants = tbl:GetLoadedParticipants(state)
		
		if setStatus then
			tbl:SetValue("Status", #loadedParticipants .. "/" .. #tbl:GetParticipantsInGame())
		end
	until (#loadedParticipants >= #tbl:GetParticipantsInGame()) or (secondsPassed == timeout)
	
	return true
end

function Gameplay:StartTurn(tbl, noLastTurn)
	tbl:SetValue("CurrentState", "TURN START")
	
	tbl.LastAmountLost = 0
	
	if not tbl.CurrentTurn then
		tbl:SetTurn(tbl.Host)
	else
		tbl:AdvanceTurn(noLastTurn)
	end
	
	task.spawn(function()
		task.wait(0.5)

		local countdownFrom = (tbl:IsEffectActive("Speedrun") and 5) or (15)

		for i = countdownFrom, 1, -1 do
			if tbl.CanPlayCard and tbl.CurrentTurn and tbl.CurrentTurn.InGame then
				tbl:SetValue("Status", i)
				task.wait(1)
			else
				break
			end
		end

		if tbl.CanPlayCard then
			local success, result = self:AttemptPlayCard(tbl.CurrentTurn and tbl.CurrentTurn.Player, tbl.CurrentTurn and tbl.CurrentTurn.GrabbedCards, false, true, tbl)

			if not success then
				if result ~= "Skipped card play" and tbl.CanPlayCard then
					tbl.CanPlayCard = false
					tbl.CanCallOut = false

					tbl:SetValue("CurrentState", "SKIPPING TURN")

					local livingParticipantsBefore = #tbl:GetLivingParticipants()
					local eligibleParticipantsBefore = #tbl:GetEligibleParticipantsForTurn()

					task.wait(1)

					if eligibleParticipantsBefore > 1 then
						self:StartTurn(tbl)
					elseif livingParticipantsBefore > 1 then
						self:StartRound(tbl, true)
					else
						self:EndGame(tbl, true)
					end
				end

				warn(result)
			end
		end
	end)
	
	if type(tbl) == "table" and type(tbl.CurrentTurn) == "table" then
		tbl.CurrentTurn.GrabbedCards = nil
	end
	
	local eligibleParticipants = tbl:GetEligibleParticipantsForTurn()
	
	if #eligibleParticipants > 1 or not tbl.AutoLiar then
		self.Client.TurnStarted:FireFor(tbl:GetPlayers(), tbl.CurrentTurn, (tbl:IsEffectActive("Speedrun") and 5) or (15))
		
		tbl.CanPlayCard = true
		tbl.PlayerCallingOut = nil
		tbl.CanCallOut = true
	else
		local success, result = self:AttemptCallOut(tbl.CurrentTurn and tbl.CurrentTurn.Player, nil, true)
		
		if not success then
			warn(result)
			
			if #tbl:GetLivingParticipants() > 1 then
				self:StartRound(tbl, true)
			else
				self:EndGame(tbl, true)
			end
		end
	end
end

function Gameplay:StartRound(tbl, endedPrevious)
	if endedPrevious then
		self.Client.RoundEnded:FireFor(tbl:GetPlayers())
		tbl:SetValue("CurrentState", "ROUND END")
		self:WaitForState(tbl, "ROUND END", 10)
	end
	
	tbl:RoundStarted()
	
	local success, err = pcall(function()
		if tbl.CurrentRound >= 10 then
			for _, v in pairs(tbl:GetLivingParticipants()) do
				Utils.awardBadge(v.Player, BadgeIds.Survive10Rounds)
			end
		end
	end)
	
	if not success then warn(err) end
	
	tbl:SetValue("CurrentState", "ROUND START")
	
	tbl.LastTurn = nil
	tbl.CanPlayCard = false
	tbl.CanCallOut = false
	tbl.CanDrinkPotion = false
	
	local amountOfPlayers = #tbl:GetLivingParticipants(false)
	local normalAmount = (tbl.IncludeJokers and math.round(amountOfPlayers * 1.5)) or (math.round(amountOfPlayers * 2))
	local jokerAmount = math.round(amountOfPlayers * 0.5)
	local cardDeck = {}
	
	local amountOfCards = {
		["Ace"] = normalAmount,
		["King"] = normalAmount,
		["Queen"] = normalAmount,
		["Joker"] = (tbl.IncludeJokers and jokerAmount) or (nil),
	}
	
	local randomClaimCard = math.random(1, 3)
	local claimedCard = (randomClaimCard == 1 and "Ace") or (randomClaimCard == 2 and "King") or ("Queen")
	
	for i, v in pairs(amountOfCards) do
		for n = 1, v do
			if tbl.IncludeDemon and i == claimedCard and n == 1 then
				table.insert(cardDeck, "Demon")
			elseif tbl.IncludeAngel and i == claimedCard and n == 2 then
				table.insert(cardDeck, "Angel")
			else
				table.insert(cardDeck, i)
			end
		end
	end

	--[[for a = 1, #cardTypes do
		for b = 1, normalAmount do
			if cardTypes[a].Name ~= "Joker" and cardTypes[a].Name ~= "Demon" then
				table.insert(cardDeck, cardTypes[a].Name)
			end
		end
	end]]
	
	--[[if tbl.IncludeJokers then
		for c = 1, jokerAmount do
			table.insert(cardDeck, "Joker")
		end
	end]]
	
	local randomizedDeck = {}

	for Index = 1, #cardDeck do -- idk why I randomized this way when Random.new():Shuffle() exists
		local RandomIndex = math.random(#cardDeck)
		table.insert(randomizedDeck, cardDeck[RandomIndex])
		table.remove(cardDeck, RandomIndex)
	end
	
	local cardAmounts = {}
	local adminCards = {}
	
	for pIndex, v in pairs(tbl:GetLivingParticipants(false)) do
		v:RemoveAllCards()
		
		for i = 1, tbl.MaxCards do
			local pickedCard = randomizedDeck[i + ((pIndex - 1) * 5)]
			
			if pickedCard == "Angel" and v:HowManyPotions() == tbl.MaxPotions then
				v:AddCard(claimedCard)
			else
				v:AddCard(pickedCard)
			end
		end

		cardAmounts[tostring(v.UserId)] = {}
		
		for i, _ in pairs(v.Cards) do
			cardAmounts[tostring(v.UserId)][i] = true
		end
		
		adminCards[tostring(v.UserId)] = v.Cards
	end
	
	tbl:SetCard(claimedCard)
	
	task.wait(1)
	
	for _, v in pairs(tbl:GetParticipantsInGame()) do
		local isAdmin = ModerationService:IsPlayerWhitelisted(v.Player, "cheats")
		self.Client.RoundStarted:Fire(v.Player, tbl:GetPlayers(), v.Cards, cardAmounts, claimedCard, amountOfCards, tbl.IncludeDemon, tbl.IncludeAngel, (isAdmin and adminCards) or (nil))
	end
	
	self:WaitForState(tbl, "ROUND START", 10)
	
	task.wait(1)
	
	self:StartTurn(tbl, true)
end

function Gameplay:ChangeSpectate(player : Player, nowSpectating : number)
	local pTable, participant = self:FindTableWithPlayer(player)

	if not pTable then return false, "Player is not currently in a game to spectate" end
	if not pTable.Active then return false, "Table is not currently active to spectate" end
	if not pTable.InProgress then return false, "Player is not currently in an active game to spectate" end
	if not participant then return false, "Error while finding player in game to spectate" end
	
	local userId = tonumber(nowSpectating)
	
	if not userId then return false, "Attempting to spectate invalid UserId" end
	
	for _, v in pairs(pTable:GetParticipantsInGame()) do
		local newAmount
		
		if v.UserId == userId then
			newAmount = v:AddSpectator(player.UserId)
		else
			newAmount = v:RemoveSpectator(player.UserId)
		end
		
		if newAmount then
			self.Client.SpectatorsChanged:Fire(v.Player, newAmount)
		end
	end
	
	return true
end

function Gameplay:AttemptStartGame(player : Player, playingAgain : boolean?) : (boolean, string?)
	local findTable = self:FindTableWithHost(player)
	
	if not findTable then return false, "Unable to find table with host" end
	if findTable.InProgress then return false, "Game already in progress" end
	if not RunService:IsStudio() and #findTable.Participants <= 1 then return false, "Not enough participants" end
	
	findTable.InProgress = true
	
	task.spawn(function()
		local success, err = pcall(function()
			local actualParticipants = {}
			
			for i = #findTable.Participants, 1, -1 do
				local participant = findTable.Participants[i]
				local tables = self:GetAllTablesWithPlayer(participant.Player)
				
				if #tables <= 1 then continue end
				
				findTable:Leave(participant.Player)
			end
			
			self.Client.LoadingGame:FireFor(findTable:GetPlayers(), playingAgain)
			
			findTable:SetValue("CurrentState", "LOADING GAME")
			findTable:SetValue("Status", "")
			
			if playingAgain then
				self:WaitForState(findTable, "PLAYING AGAIN", 10)
			end
			
			local tableSettings = {
				MaxPotions = findTable.MaxPotions,
				MaxPlayers = findTable.MaxParticipants,
				MaxCards = findTable.MaxCards,
				JoinType = findTable.JoinType,
				AnyLiar = findTable.AnyLiar,
				IncludeJokers = findTable.IncludeJokers,
				IncludeDemon = findTable.IncludeDemon,
				IncludeAngel = findTable.IncludeAngel,
				AutoLiar = findTable.AutoLiar,
				OnLastPotion = findTable.OnLastPotion,
				EffectsEnabled = findTable.EffectsEnabled,
				Room = findTable.Room
			}

			self.Client.TableChanged:FireAll(findTable.Host, findTable.Participants, findTable.InProgress, tableSettings)
			
			for _, v in pairs(findTable:GetPlayers()) do
				local isAdmin = ModerationService:IsPlayerWhitelisted(v, "cheats")
				self.Client.LivingParticipantsChanged:Fire(v, (isAdmin and self:GetParticipantPropertiesWithout(findTable:GetLivingParticipants(), "")) or (self:GetParticipantPropertiesWithout(findTable:GetLivingParticipants(), "Cards")))
			end
			
			local current = 0

			repeat task.wait()
				current += 1
			until not self.TableSlots[current]

			self.TableSlots[current] = findTable

			local ceiling = math.ceil(#findTable.Participants/6)
			local placement = PlacementExample:Clone()
			
			placement.Size *= Vector3.new(ceiling, 1, ceiling)
			placement.Position = Vector3.new(-1000 + current * 200, placement.Position.Y, 0)

			findTable:AddObject(placement)
			
			local participants = findTable.Participants
			local cf = placement.CFrame
			local multiplier = (ceiling == 1 and .3) or (.16)
			local radius = placement.Size.Z / 2 * (1 + multiplier)
			local Positions = {}
			local single = 360/#participants
			
			findTable.ParticipantsStartedWith = #participants

			for i = #participants, 1, -1 do
				local loadSuccess, loadError = pcall(function()
					local v = participants[i]
					
					if v and v.Player and v.Player.Parent and v.InGame then
						local angle = single*i
						local cheating = cf * CFrame.Angles(math.rad(angle), 0, 0)
						local pos = cheating.Position + cheating.LookVector * radius
						
						Positions[tostring(v.UserId)] = pos
						
						local oldChair = workspace:FindFirstChild(v.UserId)

						if oldChair then
							oldChair:Destroy()
						end
						
						local newChair = SeatExample:Clone()

						findTable:AddObject(newChair, v.UserId .. "_CHAIR")

						newChair.Parent = workspace
						newChair.CFrame = CFrame.new(Vector3.new(pos.X, placement.Position.Y - 1.2, pos.Z), Vector3.new(placement.Position.X, placement.Position.Y - 1.2, placement.Position.Z))

						newChair.Name = v.UserId
						
						v:ResetPotions(findTable.MaxPotions)
						
						local plyr = v.Player

						--[[newChair.Changed:Connect(function(property)
							if property == "Occupant" and newChair and newChair.Parent and not newChair.Occupant then
								local secondsPassed = 0

								repeat
									secondsPassed += RunService.Heartbeat:Wait()
								until secondsPassed >= 5 or newChair.Occupant or not newChair or not newChair.Parent

								if secondsPassed >= 5 and newChair and newChair.Parent == workspace and plyr and plyr.Parent and plyr.Character and plyr.Character.Parent == workspace then
									ModerationService:KickPlayer(v.Player, "Anti-Exploit", "Invalid occupant; if you believe this to be an error, please report it")
								end
							end
						end)]]
						
						plyr:LoadCharacter()
					else
						v:LeftGame()
					end
				end)
				
				if not loadSuccess then
					warn(loadError)
				end
			end
			
			local plyrs = findTable:GetPlayers()
			local items = {}
			local passes = {}
			
			local hostRoom = findTable.Room or "Default"
			
			for _, v in plyrs do
				local vSuccess, vError = pcall(function()
					PlayerDataService:SetValue(player, "WinStreakAntiCheat", true)
					
					local data = InventoryService:GetData(v)
					items[tostring(v.UserId)] = (type(data) == "table" and data.Equipped) or ({})
					
					if type(items[tostring(v.UserId)]) == "table" then
						if hostRoom and hostRoom == "Santa's Workshop" then -- chosen room
							items[tostring(v.UserId)]["Chairs"] = "Santa's Helper"
						elseif hostRoom and hostRoom == "Cafeteria" then
							items[tostring(v.UserId)]["Chairs"] = "Cafeteria Chair"
						elseif hostRoom and hostRoom == "Space Bunker" then
							items[tostring(v.UserId)]["Chairs"] = "Bunker Chair"
						else
							items[tostring(v.UserId)]["Chairs"] = "Default"
						end
					end
					
					passes[tostring(v.UserId)] = {}
					
					for passName, passId in pairs(ProductIds.Passes) do
						if passName == "Radio" and SettingsService:GetSetting(v, "RadioEnabled") == "Disabled" then
							passes[tostring(v.UserId)][passName] = false
						else
							passes[tostring(v.UserId)][passName] = ShopService:UserOwnsGamePass(v, passId.Id)
						end
					end
				end)
				
				if not vSuccess then
					warn(vError)
				end
			end

			self.Client.GameLoaded:FireFor(plyrs, cf, Positions, hostRoom or "Default", items, passes, findTable.ValueFolder, ceiling > 1, tableSettings, playingAgain)
			
			self:WaitForState(findTable, "GAME", 10, true)
			
			task.wait(1)
			
			self.Client.GameStarted:FireFor(plyrs)
			
			findTable:SetValue("CurrentState", "GAME START")
			
			task.wait(1)
			
			self:StartRound(findTable)
		end)
		
		if not success then
			warn(err)
			self:EndGame(findTable, true)
		end
	end)
	
	return true
end

function Gameplay:ClearTable(tbl)
	local findTable = table.find(self.Tables, tbl)

	if findTable then
		table.remove(self.Tables, findTable)
	end
	
	tbl:Destroy()
	
	task.delay(10, function()
		local findSlot

		for i, v in pairs(self.TableSlots) do
			if v == tbl then
				findSlot = i
			end
		end

		if findSlot then
			self.TableSlots[findSlot] = nil
		end
	end)
end

-- 1 cash per card played
-- 10 cash per round survived
-- 10 cash per game played
-- 75 cash per win

-- 75 * (players/6)

-- 1 Beach Ball per card played
-- 10 Beach Balls per game played
-- 5 Beach Balls per round survived
-- 30 Beach Balls per win

-- 30 * (players/6)

function Gameplay:EndGame(tbl, ineligible)
	local participants = tbl:GetLivingParticipants(false)
	local winner = participants and participants[1]
	
	local success, err = pcall(function()
		if (not ineligible or tbl.CurrentRound > 1) and (tbl.MaxPotions > 1 or tbl.ParticipantsStartedWith > 2) then
			if winner then
				local totalWins = CurrencyService:Add(winner.Player, "Wins", 1)
				
				PlayerDataService:SetValue(winner.Player, "WinStreakAntiCheat", false)
				CurrencyService:Add(winner.Player, "WinStreak", 1)
				CurrencyService:Add(winner.Player, "GamesPlayed", 1)
				
				if type(totalWins) == "number" then
					for i, v in pairs(BadgeIds.Wins) do
						if totalWins >= i then
							Utils.awardBadge(winner.Player, v)
						end
					end
				end
				
				local isVIP = ShopService:UserOwnsGamePass(winner.Player, ProductIds.Passes.VIP.Id)
				local hasDoubleEventCurrency = ShopService:UserOwnsGamePass(winner.Player, ProductIds.Passes["x2 Beach Balls"].Id)
				local multiplier = ((isVIP and 2) or (1)) + ((winner.Player:IsInGroup(4620969) and 0.5) or (0))
				local EventCurrencyMultiplier = (hasDoubleEventCurrency and 2) or (1)
				local participantsAdjusted = tbl.ParticipantsStartedWith / 6
				local cashEarnedAdjusted = math.round(75 * participantsAdjusted)
				local cashEarned = math.round((cashEarnedAdjusted + 10 + (tbl.CurrentRound * 10) + winner.TotalCardsPlayed) * multiplier)
				local EventCurrencyEarnedAdjusted = math.round(30 * participantsAdjusted)
				local EventCurrencyEarned = math.round((EventCurrencyEarnedAdjusted + 10 + (tbl.CurrentRound * 5) + winner.TotalCardsPlayed) * EventCurrencyMultiplier)
				
				winner.RoundDied = tbl.CurrentRound
				winner.CashEarned = cashEarned
				winner.EventCurrencyEarned = EventCurrencyEarned
				
				if cashEarned >= 250 then
					Utils.awardBadge(winner.Player, BadgeIds.BigMoney, 5)
				end
				
				local newBalance = CurrencyService:Add(winner.Player, "Cash", cashEarned)
				--local newEventBalance = CurrencyService:Add(winner.Player, "Beach Balls", EventCurrencyEarned)
				
				local success2, err2 = pcall(function()
					AnalyticsService:LogEconomyEvent(
						winner.Player,
						Enum.AnalyticsEconomyFlowType.Source,
						"Cash",
						cashEarned,
						newBalance,
						Enum.AnalyticsEconomyTransactionType.Gameplay.Name
					)
				end)
				
				--[[local success3, err3 = pcall(function()
					AnalyticsService:LogEconomyEvent(
						winner.Player,
						Enum.AnalyticsEconomyFlowType.Source,
						"Beach Balls",
						EventCurrencyEarned,
						newEventBalance,
						Enum.AnalyticsEconomyTransactionType.Gameplay.Name
					)
				end)]]

				if tbl.ParticipantsStartedWith >= 12 then
					Utils.awardBadge(winner.Player, BadgeIds.Win12PlayerGame)
				end

				if tbl.ParticipantsStartedWith >= 3 then
					if winner.LiarsCalled <= 0 then
						Utils.awardBadge(winner.Player, BadgeIds.SilentVictory)
					end

					if winner.TotalLies <= 0 then
						Utils.awardBadge(winner.Player, BadgeIds.HonestVictory)
					end

					if winner.TotalTruths <= 0 then
						Utils.awardBadge(winner.Player, BadgeIds.LiarsVictory)
					end
				end

				if tbl.MaxPotions >= 3 then
					if winner.PotionsDrank <= 0 then
						Utils.awardBadge(winner.Player, BadgeIds.PureVictory)
						
						if tbl.MaxPotions >= 8 then
							Utils.awardBadge(winner.Player, BadgeIds.NotThirsty)
						end
					end
				end
				
				if winner.UsedAngel and winner:HowManyPotions() == 1 then
					Utils.awardBadge(winner.Player, BadgeIds.AngelsHand)
				end
				
				if tbl.LastAmountLost and tbl.LastAmountLost >= 2 and tbl.LastTurn == winner then
					Utils.awardBadge(winner.Player, BadgeIds.DevilsVictory)
				end
			end
		end
	end)
	
	if not success then
		warn(err)
	end
	
	local inGameParticipants = tbl:GetParticipantsInGame()
	local canPlayAgain = inGameParticipants and #inGameParticipants > 1
	
	tbl:SetValue("CurrentState", "GAME END")
	
	for _, part in pairs(inGameParticipants) do
		self.Client.GameEnded:Fire(part.Player, winner, #inGameParticipants, tbl.ParticipantsStartedWith, part, part.Player:IsInGroup(4620969), canPlayAgain)
	end
	
	task.wait(1)
	
	self:WaitForState(tbl, "END GAME", 3)
	
	task.wait(1)
	
	local tableSettings = {
		MaxPotions = tbl.MaxPotions,
		MaxPlayers = tbl.MaxParticipants,
		MaxCards = tbl.MaxCards,
		JoinType = tbl.JoinType,
		IncludeJokers = tbl.IncludeJokers and "Yes",
		IncludeDemon = tbl.IncludeDemon and "Yes",
		IncludeAngel = tbl.IncludeAngel and "Yes",
		AnyLiar = tbl.AnyLiar and "Yes",
		AutoLiar = tbl.AutoLiar and "Yes",
		OnLastPotion = tbl.OnLastPotion and "Yes",
		EffectsEnabled = tbl.EffectsEnabled and "Yes"
	}
	
	local lastUpdate = nil
	
	if canPlayAgain then
		local playingAgain = tbl:GetParticipantsPlayingAgain()
		
		for i = 20, 1, -1 do
			playingAgain = tbl:GetParticipantsPlayingAgain()
			inGameParticipants = tbl:GetParticipantsInGame()
			
			if lastUpdate ~= #playingAgain .. "/" .. #inGameParticipants then
				lastUpdate = #playingAgain .. "/" .. #inGameParticipants
				self.Client.UpdateEndGame:FireFor(tbl:GetPlayers(), "Participants", lastUpdate)
			end
			
			if (#inGameParticipants > 1) and (#playingAgain < #inGameParticipants) then
				tbl:SetValue("Status", i)
				task.wait(1)
			else
				break
			end
		end

		if #tbl:GetParticipantsPlayingAgain() > 1 then
			canPlayAgain = true
		else
			canPlayAgain = false
		end
	end
	
	self.Client.UpdateEndGame:FireFor(tbl:GetPlayers(), "Ended")
	
	local host = nil
	local newGamePlayers = {}
	
	if canPlayAgain then
		for _, part in pairs(tbl:GetParticipantsInGame()) do
			local playingAgain = canPlayAgain and part.InGame and part.PlayingAgain
			
			if playingAgain then
				part:LeftGame()
				tbl:DestroyObject(part.UserId .. "_CHAIR")
				
				if not host then
					host = part.Player
				else
					table.insert(newGamePlayers, part.Player)
				end
			end
		end
	end
	
	tbl:SetValue("CurrentState", "GAME ENDED")
	
	self:ClearTable(tbl)
	
	if host and #newGamePlayers >= 1 then
		local success, err = self:AttemptCreateTable(host, tableSettings, newGamePlayers)
		
		if success then
			local success2, err2 = self:AttemptStartGame(host, true)
			
			if not success2 then
				local newTbl = self:FindTableWithHostId(host.UserId)
				
				if newTbl then
					newTbl:Destroy()
					self:ClearTable(newTbl)
				end
				
				warn(err2)
			end
		else
			warn(err)
		end
	end
end

function Gameplay:AttemptPlayAgain(player : Player) : (boolean, string?)
	local pTable, participant = self:FindTableWithPlayer(player)

	if not pTable then return false, "Player is not currently in a game to play again" end
	if not pTable.Active then return false, "Table is not currently active" end
	if not pTable.InProgress then return false, "Player is not currently in an active game to play again" end
	if not participant then return false, "Error while finding player in game to play again" end
	if participant.PlayingAgain then return false, "Participant is already playing again" end
	if pTable:GetValue("CurrentState") ~= "GAME END" then return false, "Current state is not ended" end
	
	participant.PlayingAgain = true
	
	local playingAgain = pTable:GetParticipantsPlayingAgain()
	local inGameParticipants = pTable:GetParticipantsInGame()
	
	return true, ((playingAgain and inGameParticipants) and (#playingAgain .. "/" .. #inGameParticipants))
end

function Gameplay:AttemptCreateTable(player : Player, data : Table, participantPlayers : {Participant}?, playingAgain : boolean?) : (boolean, string?)
	if self:FindTableWithHostId(player.UserId) then return false, "Player is already hosting a table" end
	if self:FindTableWithPlayer(player) then return false, "Player is already in a table" end
	
	local hostRoom = InventoryService:GetEquipped(player, "Rooms") or "Default"
	local newTable = Table.new(player, data, playingAgain or ShopService:UserOwnsGamePass(player, ProductIds.Passes["Bigger Table"].Id), playingAgain or ShopService:UserOwnsGamePass(player, ProductIds.Passes["Too Many Potions"].Id), hostRoom or "Default", participantPlayers)
	
	if newTable then
		table.insert(self.Tables, newTable)
		
		if not playingAgain then
			table.insert(newTable.Connections, newTable.ParticipantsChanged:Connect(function()
				if not newTable.Active then return end
				if not newTable.Host then return end
				
				local tableSettings = {
					MaxPotions = newTable.MaxPotions,
					MaxPlayers = newTable.MaxParticipants,
					MaxCards = newTable.MaxCards,
					JoinType = newTable.JoinType,
					IncludeJokers = newTable.IncludeJokers,
					IncludeDemon = newTable.IncludeDemon,
					IncludeAngel = newTable.IncludeAngel,
					AutoLiar = newTable.AutoLiar,
					AnyLiar = newTable.AnyLiar,
					OnLastPotion = newTable.OnLastPotion,
					EffectsEnabled = newTable.EffectsEnabled,
					Room = newTable.Room
				}
				
				self.Client.TableChanged:FireFilter(function(player : Player)
					return (not newTable:IsPlayerBlacklisted(player.UserId) and (newTable.JoinType ~= "Friends" or player == newTable.Host.Player or player:IsFriendsWith(newTable.Host.UserId)))
						or (table.find(newTable:GetPlayers(), player))
				end, newTable.Host, newTable.Participants, newTable.InProgress, tableSettings)
			end))
			
			local tableSettings = {
				MaxPotions = newTable.MaxPotions,
				MaxPlayers = newTable.MaxParticipants,
				MaxCards = newTable.MaxCards,
				JoinType = newTable.JoinType,
				IncludeJokers = newTable.IncludeJokers,
				IncludeDemon = newTable.IncludeDemon,
				IncludeAngel = newTable.IncludeAngel,
				AutoLiar = newTable.AutoLiar,
				AnyLiar = newTable.AnyLiar,
				OnLastPotion = newTable.OnLastPotion,
				EffectsEnabled = newTable.EffectsEnabled,
				Room = newTable.Room
			}
			
			self.Client.TableChanged:FireFilter(function(player : Player)
				return (not newTable:IsPlayerBlacklisted(player.UserId) and (newTable.JoinType ~= "Friends" or player == newTable.Host.Player or player:IsFriendsWith(newTable.Host.UserId)))
					or (table.find(newTable:GetPlayers(), player))
			end, newTable.Host, newTable.Participants, newTable.InProgress, tableSettings)
			
			task.spawn(function()
				local timePassed = 0
				
				while not newTable.InProgress and newTable.Active and #newTable.Participants > 0 do
					if #newTable.Participants == newTable.MaxParticipants then
						timePassed += 1
					else
						timePassed = 0
					end
					
					if timePassed >= 10 then
						self:AttemptStartGame(player)
						break
					end
					
					self.Client.TableTimerChanged:FireFor(newTable:GetPlayers(), timePassed)
					
					task.wait(1)
				end
			end)
		end
		
		return true, newTable.Password
	else		
		return false, "Unable to make table; unknown error"
	end
end

function Gameplay:AttemptJoinTable(player : Player, hostUserId : number, password : string?) : (boolean, string?)
	local tbl = self:FindTableWithHostId(hostUserId)
	local tbl2, participant = self:FindTableWithPlayer(player)
	
	if tbl2 then return false, "Player is already in a table" end
	if not tbl then return false, "Table not found" end
	if tbl.InProgress then return false, "Game already in progress" end
	
	return tbl:AttemptJoin(player, password)
end

function Gameplay:AttemptKickFromTable(player : Player, userIdToKick : number?) : (boolean, string?)
	local tbl, participant = self:FindTableWithPlayer(player)
	
	if not tbl then return false, "Table not found" end
	if tbl.InProgress then return false, "Table is in progress" end
	if not participant then return false, "Participant not found" end
	if tbl.Host ~= participant then return false, "Player is not host" end
	
	local idToNum = tonumber(userIdToKick)
	
	if not idToNum then return false, "UserId is not a number" end
	if tbl.Host.UserId == idToNum then return false, "Host can't kick themselves" end
	
	for _, v in pairs(tbl.Participants) do
		if v.UserId == userIdToKick then
			tbl:BlacklistPlayer(v.UserId)
			self:AttemptLeaveTable(v.Player, true)
			return true
		end
	end
	
	return false, "Unable to kick player from table; most likely not in table"
end

function Gameplay:AttemptLeaveTable(player : Player, fromServer : boolean) : (boolean, string?)
	local tbl, participant = self:FindTableWithPlayer(player)
	
	if not tbl then return false, "Table not found" end
	if tbl.InProgress then return false, "Table is in progress" end
	
	tbl:Leave(player)
	
	task.spawn(function()
		if tbl.Host == participant or #tbl.Participants == 0 then
			self.Client.TableCancelled:FireAll(tbl.Host, tbl.Participants)
			self:ClearTable(tbl)
		end
	end)
	
	if fromServer then
		self.Client.ServerForced:Fire(player, "AttemptLeaveTable", tbl.Host.UserId)
	end
	
	return true
end

function Gameplay:DoChoice(participant : Participant, chosenPotion : number, onLastPotion : boolean?) : boolean
	local chosenNumber = tonumber(chosenPotion)
	
	if participant and participant.Potions[chosenNumber] then
		local remainingPotions = 0
		
		for _, v in pairs(participant.Potions) do
			if v then
				remainingPotions += 1
			end
		end
		
		participant:RemovePotion(chosenPotion)
		
		if not onLastPotion and chosenNumber == participant.BadPotion then
			return true
		else
			return remainingPotions == 1
		end
	else
		return false
	end
end

function Gameplay:AttemptPlayCard(player : Player, cardIndexs : {number}?, isVR : boolean?, fromServer : boolean?, tbl : Table?) : (boolean, string?)	
	if not player then return false, "Player not provided" end
	
	local cards = {}
	local pTable, participant = self:FindTableWithPlayer(player)
	
	pTable = pTable or tbl

	if not pTable then return false, "No table found to play cards" end
	if not pTable.InProgress then return false, "Player is not currently in an active game to play cards" end
	
	local livingParticipantsBefore = #pTable:GetLivingParticipants(false)
	local eligibleParticipantsBefore = #pTable:GetEligibleParticipantsForTurn(false)
	
	if not fromServer then
		if pTable.CurrentTurn ~= participant then return false, "It is not player's turn to play cards" end
		if not participant then return false, "Error while finding player in game to play cards" end
		if type(cardIndexs) ~= "table" then return false, "Card index not valid to play cards" end

		for _, v in pairs(cardIndexs) do
			local index = tonumber(v)
			local cardName = index and participant.Cards[v]
			
			if not cardName then continue end
			
			if cardName == "Demon" or cardName == "Angel" then
				table.clear(cards)
				table.insert(cards, cardName)
				cardIndexs = {v}
				break
			end
			
			table.insert(cards, cardName)
		end
		
		if #cards <= 0 then return false, "Unable to find card(s) to play" end
		if not participant:HasCards(cards) then return false, "Player does not have card(s) to play" end
		if not pTable.CanPlayCard then return false, "Player is unable to play card(s)" end
		
		pTable.CanPlayCard = false
		pTable.CanCallOut = false
	else
		if not pTable.CanPlayCard then return false, "Player is unable to play card(s)" end
		
		pTable.CanPlayCard = false
		pTable.CanCallOut = false
		
		cardIndexs = (type(cardIndexs) == "table" and cardIndexs) or ({})
		
		if not cardIndexs then return false, "Error with card indexs" end
		
		local skipTurn = true
		
		if cardIndexs then
			if participant then
				if not participant.IsDead and participant.InGame and participant.Cards then
					if #cardIndexs == 0 then
						for i, v in pairs(participant.Cards) do
							table.insert(cardIndexs, i)
							table.insert(cards, v)
							break
						end
						
						if #cards > 0 then
							skipTurn = false
						end
					else
						for _, v in pairs(cardIndexs) do
							local index = tonumber(v)
							local cardName = index and participant.Cards[v]

							if not cardName then continue end

							if cardName == "Demon" or cardName == "Angel" then
								table.clear(cards)
								table.insert(cards, cardName)
								cardIndexs = {v}
								break
							end

							table.insert(cards, cardName)
						end
						
						skipTurn = false
					end
				end
			end
		end
		
		if skipTurn then
			pTable:SetValue("CurrentState", "SKIPPING TURN")
			
			task.wait(1)
			
			--pTable:SetTurn(self.LastTurn)
			
			if eligibleParticipantsBefore > 1 then
				self:StartTurn(pTable)
			elseif livingParticipantsBefore > 1 then
				self:StartRound(pTable, true)
			else
				self:EndGame(pTable, true)
			end

			return false, "Skipped card play"
		end
	end
	
	local success, err = pcall(function()
		if (pTable.MaxPotions > 1 or pTable.ParticipantsStartedWith > 2) then
			if type(pTable.LastTurn) == "table" and pTable.LastTurn.Player then
				if pTable:CheckLastCard() == false then
					pTable.LastTurn.TotalLies += 1
					Utils.awardBadge(pTable.LastTurn.Player, BadgeIds.LieSuccess)
				elseif pTable:CheckLastCard() == true then
					pTable.LastTurn.TotalTruths += 1
				end
			end
		end
	end)
	
	local cardAmounts
	
	if participant then
		local success, err = pcall(function()
			participant:RemoveCards(cardIndexs)
			participant:PlayedCards(#cards)
			
			cardAmounts = {}

			for i = 1, pTable.MaxCards do
				cardAmounts[i] = (participant.Cards[i] and true) or (false)
			end		
		end)
		
		if not success then warn(err) end
	end
	
	pTable:PlayCards(cards)
	
	task.delay(0.1, function()
		pTable:SetValue("Status", #cards)
		pTable:SetValue("CurrentState", "CARDS PLAYED")
	end)
	
	task.spawn(function()
		local success, err = pcall(function()
			if (pTable.MaxPotions > 1 or pTable.ParticipantsStartedWith > 2) then
				CurrencyService:Add(player, "CardsPlayed", #cards)
			end
		end)
		
		if not success then
			warn(err)
		end
		
		for _, v in pairs(pTable:GetPlayers()) do
			local isAdmin = ModerationService:IsPlayerWhitelisted(v, "cheats")
			self.Client.CardsPlayed:Fire(v, player, cardAmounts, #cards, (isAdmin and cards) or (nil), isVR)
		end
		
		task.wait(1)
		
		self:WaitForState(pTable, tostring(player.UserId) .. " CARD PLAYED", 10)
		
		if eligibleParticipantsBefore > 1 then
			self:StartTurn(pTable)
		elseif livingParticipantsBefore > 1 then
			self:StartRound(pTable, true)
		else
			self:EndGame(pTable)
		end
	end)
	
	if fromServer then
		self.Client.ServerForced:Fire(player, "AttemptPlayCard")
	end
	
	return true
end

function Gameplay:AttemptDrinkPotion(player : Player, potionChosen : number?, fromServer : boolean?, tbl : Table?, isVR : boolean?) : (boolean, string?)
	if not player then return false, "Player not found" end
	
	local pTable, participant = self:FindTableWithPlayer(player)
	
	pTable = pTable or tbl

	if not pTable then return false, "No table found for potion drink" end
	if not pTable.InProgress then return false, "Player is not currently in an active game for potion drink" end
	if not participant then return false, "No participant found for potion drink" end
	
	if not fromServer then
		if not pTable.choosingParticipants then return false, "No current participants to choose" end
		if not table.find(pTable.choosingParticipants, participant) then return false, "Current choice participant is not player" end
		
		local toNum = tonumber(potionChosen)
		
		if toNum then
			if not participant.Potions[toNum] then return false, "Potion already drank" end
		else
			for i, v in pairs(participant.Potions) do
				if v then
					potionChosen = i
					break
				end
			end
		end
	end
	
	if not pTable.CanDrinkPotion then return false, "Table isn't allowing potion drinking right now" end
	if not participant.CanDrinkPotion then return false, "Player can't currently drink potion" end
	
	participant.CanDrinkPotion = false
	
	if fromServer and not potionChosen then
		local skipTurn = true
		
		if participant then
			if participant.Potions then
				for i, v in pairs(participant.Potions) do
					if v then
						potionChosen = i
						break
					end
				end

				if potionChosen then
					skipTurn = false
				end
			end
		end
		
		if skipTurn then
			return false, "Skipped potion drink"
		end
	end
	
	local shouldKnockout = false
	
	if participant then
		local success, err = pcall(function()
			shouldKnockout = self:DoChoice(participant, potionChosen, pTable.OnLastPotion)

			if shouldKnockout then
				if (pTable.MaxPotions > 1 or pTable.ParticipantsStartedWith > 2) then
					local success2, err2 = pcall(function()
						local isVIP = ShopService:UserOwnsGamePass(participant.Player, ProductIds.Passes.VIP.Id)
						local multiplier = (isVIP and 2) or (1)
						local cashEarned = (10 + (pTable.CurrentRound * 10) + participant.TotalCardsPlayed) * multiplier
						
						local hasDoubleEventCurrency = ShopService:UserOwnsGamePass(participant.Player, ProductIds.Passes["x2 Beach Balls"].Id)
						local EventCurrencyMultiplier = (hasDoubleEventCurrency and 2) or (1)
						local EventCurrencyEarned = (10 + (pTable.CurrentRound * 5) + participant.TotalCardsPlayed) * EventCurrencyMultiplier
						
						participant.CashEarned = cashEarned
						participant.EventCurrencyEarned = EventCurrencyEarned
						
						local newBalance = CurrencyService:Add(participant.Player, "Cash", cashEarned)
						--local newEventBalance = CurrencyService:Add(participant.Player, "Beach Balls", EventCurrencyEarned)
						
						CurrencyService:SetAmount(participant.Player, "WinStreak", 0)
						CurrencyService:Add(participant.Player, "GamesPlayed", 1)
						
						Utils.awardBadge(participant.Player, BadgeIds.GetKnockedOut, 5)
						
						if pTable.MaxPotions >= 3 then
							if participant.PotionsDrank <= 0 then
								Utils.awardBadge(participant.Player, BadgeIds.PotionsLuck, 5)
							end
						end
						
						if pTable.PlayerCallingOut and pTable.PlayerCallingOut ~= participant.Player then
							Utils.awardBadge(pTable.PlayerCallingOut, BadgeIds.KnockOut, 5)
						elseif pTable.LastTurn and pTable.LastTurn.Player and pTable.LastTurn ~= participant then
							Utils.awardBadge(pTable.LastTurn.Player, BadgeIds.KnockOut, 5)
						end
						
						if cashEarned >= 250 then
							Utils.awardBadge(participant.Player, BadgeIds.BigMoney, 5)
						end
						
						AnalyticsService:LogEconomyEvent(
							participant.Player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Cash",
							cashEarned,
							newBalance,
							Enum.AnalyticsEconomyTransactionType.Gameplay.Name
						)
						
						--[[AnalyticsService:LogEconomyEvent(
							participant.Player,
							Enum.AnalyticsEconomyFlowType.Source,
							"Beach Balls",
							EventCurrencyEarned,
							newEventBalance,
							Enum.AnalyticsEconomyTransactionType.Gameplay.Name
						)]]
					end)
					
					if not success2 then warn(err2) end
				end
				
				if pTable.LastAmountLost then
					pTable.LastAmountLost += 1
				end
				
				participant:Kill(pTable.CurrentRound)
				
				for _, v in pairs(pTable:GetPlayers()) do
					local isAdmin = ModerationService:IsPlayerWhitelisted(v, "cheats")
					self.Client.LivingParticipantsChanged:Fire(v, (isAdmin and self:GetParticipantPropertiesWithout(pTable:GetLivingParticipants(), "")) or (self:GetParticipantPropertiesWithout(pTable:GetLivingParticipants(), "Cards")))
				end
			end
		end)
		
		if not success then warn(err) end
	end

	task.spawn(function()
		local success, err = pcall(function()
			if (pTable.MaxPotions > 1 or pTable.ParticipantsStartedWith > 2) then
				CurrencyService:Add(player, "PotionsDrank", 1)
				participant.PotionsDrank += 1
			end
		end)
		
		if not success then
			warn(err)
		end
		
		self.Client.PotionDrank:FireFor(pTable:GetPlayers(), player, potionChosen, shouldKnockout, isVR)
	end)
	
	if fromServer then
		self.Client.ServerForced:Fire(player, "AttemptDrinkPotion", shouldKnockout)
	end
	
	return true, shouldKnockout
end

function Gameplay:AttemptCallOut(player : Player, isVR : boolean?, fromServer : boolean?) : (boolean, string?)
	if not player then return false, "Player not found" end
	
	local pTable, participant = self:FindTableWithPlayer(player)
	
	if not pTable then return false, "Player is not currently in a game for call out" end
	if not pTable.InProgress then return false, "Player is not currently in an active game for call out" end
	if not participant then return false, "Error while finding player in game for call out" end
	if participant.IsDead or not participant.InGame then return false, "Participant is not active for call out" end
	if (not pTable.CurrentTurn) or (pTable.CurrentTurn ~= participant and not pTable.AnyLiar) then return false, "Current turn is not participant for call out" end
	if not pTable.CurrentCard then return false, "No current card for call out" end
	if not pTable.LastTurn then return false, "Unable to find player to call out" end
	if pTable.LastTurn == participant then return false, "Last turn is trying to call itself out" end
	if not pTable.CanPlayCard and not fromServer then return false, "Unable to play card; already played for call out" end
	if not pTable.CanCallOut and not fromServer then return false, "Unable to call out player" end
	
	pTable.CanPlayCard = false
	pTable.CanCallOut = false
	pTable.PlayerCallingOut = player
	
	task.spawn(function()
		local checkLast = pTable:CheckLastCard()
		local choosingParticipants = {}
		local isAngel = pTable.LastPlayed[1] == "Angel"
		local isDemon = pTable.LastPlayed[1] == "Demon"
		
		if not isAngel then
			if checkLast then
				if isDemon then
					choosingParticipants = pTable:GetLivingParticipants(false, {pTable.LastTurn})
				else
					choosingParticipants = {participant}
				end
			else
				choosingParticipants = {pTable.LastTurn}
			end
		end
		
		local success, err = pcall(function()
			if (pTable.MaxPotions > 1 or pTable.ParticipantsStartedWith > 2) then
				CurrencyService:Add(player, "LiarsCalled", 1)
				participant.LiarsCalled += 1
				
				if checkLast then
					Utils.awardBadge(pTable.LastTurn.Player, BadgeIds.Fooled)
					
					if isDemon then
						Utils.awardBadge(pTable.LastTurn.Player, BadgeIds.SuccessfulDemon)
						Utils.awardBadge(player, BadgeIds.CalledOutDemon)
					elseif isAngel then
						Utils.awardBadge(pTable.LastTurn.Player, BadgeIds.SuccessfulAngel)
						Utils.awardBadge(player, BadgeIds.CalledOutAngel)
					end
				else
					Utils.awardBadge(player, BadgeIds.CallOut)
				end
			end
		end)
		
		if type(choosingParticipants) == "table" then
			pTable:SetChoosingParticipants(choosingParticipants)
			
			self.Client.PlayerCalledOut:FireFor(pTable:GetPlayers(), pTable.LastTurn, participant, pTable.LastPlayed, pTable.CurrentCard)
			
			pTable:SetValue("CurrentState", "CALL OUT ATTEMPTED")
			
			task.spawn(function()
				self:WaitForState(pTable, "CALL OUT", 10)
				
				if not isAngel then
					self.Client.StartPotionChoice:FireFor(pTable:GetPlayers(), choosingParticipants, (pTable:IsEffectActive("Speedrun") and 5) or (10))
					
					for _, choosingParticipant in choosingParticipants do
						choosingParticipant.CanDrinkPotion = true
					end
					
					pTable.CanDrinkPotion = true
					
					pTable:SetValue("CurrentState", "DRINK POTION CHOICE")
					
					local countdownFrom = (pTable:IsEffectActive("Speedrun") and 5) or (10)
					
					for i = countdownFrom, 1, -1 do
						local participantsInGame = 0
						
						for _, choosingParticipant in choosingParticipants do
							if choosingParticipant.CanDrinkPotion and choosingParticipant.InGame then
								participantsInGame += 1
							end
						end
						
						if pTable.CanDrinkPotion and participantsInGame > 0 then
							pTable:SetValue("Status", i)
							task.wait(1)
						else
							break
						end
					end
					
					local participantsCanDrink = 0

					for _, choosingParticipant in pairs(choosingParticipants) do
						if choosingParticipant.CanDrinkPotion then
							participantsCanDrink += 1
						end
					end

					if pTable.CanDrinkPotion and participantsCanDrink > 0 then
						local success = nil
						
						for _, choosingParticipant in pairs(choosingParticipants) do
							local success, result = self:AttemptDrinkPotion(choosingParticipant.Player, nil, true, pTable)
							
							if not success then
								warn(result)
							end
							
							success = success or result == "Skipped potion drink"
						end
						
						if success and pTable.CanDrinkPotion then
							pTable.CanDrinkPotion = false
							
							pTable:SetValue("CurrentState", "SKIPPING TURN")

							task.wait(1)
						else
							pTable:SetValue("CurrentState", "FINISHED POTION DRINK")
							
							task.wait(5)
						end
					else
						pTable:SetValue("CurrentState", "FINISHED POTION DRINK")

						task.wait(5)
					end
				else
					task.wait(0.5)
					
					local potionToAdd = nil
					
					for i = 1, pTable.MaxPotions do
						if not pTable.LastTurn.Potions[i] then
							potionToAdd = i
							break
						end
					end
					
					if potionToAdd then
						pTable.LastTurn:AddPotion(potionToAdd)
						self.Client.PotionAdded:FireFor(pTable:GetPlayers(), pTable.LastTurn.Player, potionToAdd)
						pTable.LastTurn.UsedAngel = true
					end
					
					task.wait(1.5)
				end
				
				if #pTable:GetLivingParticipants(false) <= 1 then
					self:EndGame(pTable)
				else
					self:StartRound(pTable, true)
				end
			end)
		end
	end)
	
	if fromServer then
		self.Client.ServerForced:Fire(player, "AttemptCallOut")
	end
	
	return true
end

function Gameplay:AttemptBackToMenu(player : Player) : (boolean, string?)
	local pTable, participant = self:FindTableWithPlayer(player)
	
	if not pTable then return false, "Player is not currently in a game for back to menu" end
	if not pTable.InProgress then return false, "Player is not currently in an active game for back to menu" end
	if not participant then return false, "Error while finding player in game for back to menu" end
	
	local status = pTable:GetValue("CurrentState")
	
	if status == "LOADING GAME" or status == "GAME START" then return false, "Player is in a new game" end
	
	participant.PlayingAgain = false
	
	participant:LeftGame()
	
	self.Client.PlayerLeaving:FireFor(pTable:GetPlayers(), player)
	
	pTable:DestroyObject(participant.UserId .. "_CHAIR")
	
	task.spawn(function()
		for _, v in pairs(pTable:GetParticipantsInGame()) do
			local newAmount = v:RemoveSpectator(player.UserId)
			
			if newAmount then
				self.Client.SpectatorsChanged:Fire(v.Player, newAmount)
			end
		end
	end)
	
	return true
end

function Gameplay:AttemptPurchaseEffect(player : Player, effectName : string) : (boolean, string?)
	local pTable, participant = self:FindTableWithPlayer(player)

	if not pTable then return false, "Player is not currently in a game for effect" end
	if not pTable.InProgress then return false, "Player is not currently in an active game for effect" end
	if not pTable.EffectsEnabled then return false, "Effects are not enabled for table" end
	if not participant then return false, "Error while finding player in game for effect" end
	if not participant.InGame then return false, "Participant is not in game for effect" end
	
	local effectItem = ItemService:FindItem("Effects", effectName)
	
	if not effectItem then return false, "Effect item not found" end
	if type(effectItem) ~= "table" then return false, "Effect is not a table" end
	if type(effectItem.Data) ~= "table" then return false, "Effect data not found" end
	if type(effectItem.Data.BlacklistedBy) ~= "table" then return false, "Unable to find blacklist for effect" end
	if type(effectItem.Data.TimeLength) ~= "number" then return false, "Unable to find effect time length" end
	if pTable:IsEffectActiveFromArray(effectItem.Data.BlacklistedBy) then return false, "Effect blacklisted by other effect(s)" end
	if pTable:IsEffectActive(effectName) then return false, "Effect already active" end
	
	local success, result = ShopService:AttemptPurchase(player, "Effects", effectName, false, true, true)
	
	if not success then return false, result end
	
	pTable:AddEffect(effectName, effectItem.Data.TimeLength)
	
	self.Client.GameEffect:FireFor(pTable:GetPlayers(), true, effectName, player.Name)
	
	return true
end

function Gameplay:ClientLoaded(player : Player, state : string)
	local pTable, participant = self:FindTableWithPlayer(player)
	
	if pTable and pTable.InProgress and participant then
		participant.LoadedState = state
	end
end

function Gameplay:GetRadioSongList(player : Player) : {{Name : string, Id : number}?}
	local songList = PlayerDataService:GetValue(player, "RadioSongList")
	
	if type(songList) ~= "table" then
		songList = {}
	end

	local listToReturn = {}
	
	for _, v in pairs(songList) do
		local num = tonumber(v)
		local info = num and MarketplaceService:GetProductInfo(num)

		if type(info) == "table" then
			table.insert(listToReturn, {Name = info.Name, Id = num})
		end
	end
	
	return listToReturn
end

function Gameplay:UpdateRadio(player : Player, updateType : string, ...) : (boolean, any?)
	local ownsPass = ShopService:UserOwnsGamePass(player, ProductIds.Passes.Radio.Id)
	local args = table.pack(...)
	
	if ownsPass then
		if updateType == "SONG" then
			local tbl = self:FindTableWithPlayer(player)
			
			if not tbl then return false, "Table not found" end
			
			self.Client.RadioUpdated:FireFor(tbl:GetPlayers(), player, updateType, ...)

			return true
		elseif updateType == "ADD" or updateType == "REMOVE" then
			local songList = PlayerDataService:GetValue(player, "RadioSongList")

			if type(songList) ~= "table" then
				songList = {}
			end

			local toNum = tonumber(args[1])
			local productInfo = toNum and MarketplaceService:GetProductInfo(toNum)

			if type(productInfo) == "table" then
				local findId = table.find(songList, toNum)

				if findId then
					if updateType == "REMOVE" then
						table.remove(songList, findId)
					else
						return false, "Audio already added"
					end
				elseif updateType == "ADD" and productInfo.AssetTypeId == 3 and productInfo.IsPublicDomain then
					table.insert(songList, toNum)
				else
					return false, "Unable to find ID or asset type is not a valid audio"
				end

				PlayerDataService:SetValue(player, "RadioSongList", songList)
				
				local listToReturn = {}
				
				for _, v in pairs(songList) do
					local num = tonumber(v)
					local info = num and MarketplaceService:GetProductInfo(num)
					
					if type(info) == "table" then
						table.insert(listToReturn, {Name = info.Name, Id = num})
					end
				end

				return true, listToReturn
			else
				return false, "Product info not found"
			end
		else
			return false, "Invalid update type"
		end
	else
		return false, "Player does not own game pass"
	end
end

function Gameplay:SearchForAudio(player : Player, audioName : string) : {{Name : string, Description : string, Id : number, Creator : string}}?
	local ownsPass = ShopService:UserOwnsGamePass(player, ProductIds.Passes.Radio.Id)
	
	if not ownsPass then return nil end
	
	local searchLink = "https://apis.roproxy.com/toolbox-service/v1/marketplace/3?keyword=" .. audioName .. "&limit=25&audioTypes=0&includeOnlyVerifiedCreators=false&uiSortIntent=1"
	
	local success, result = pcall(function()
		return HttpService:GetAsync(searchLink)
	end)
	
	if success then
		result = HttpService:JSONDecode(result)
		
		if type(result) == "table" and type(result.data) == "table" then
			local audios = {}
			
			for _, v in pairs(result.data) do
				if type(v) == "table" and v.id then
					local success2, result2 = pcall(function()
						return MarketplaceService:GetProductInfo(v.id)
					end)
					
					if success2 and type(result2) == "table" and result2.Creator.Name ~= "DistrokidOfficial" then
						table.insert(audios, {Name = result2.Name, Description = result2.Description, Id = v.id, Creator = result2.Creator.Name})
					end
				end
			end
			
			return audios
		end
	else
		warn(result)
	end
	
	return nil
end

function Gameplay:UpdateAnimation(player : Player, animName : string, animStatus : string)
	local tbl = self:FindTableWithPlayer(player)
	
	if (tbl) and (animStatus == "Play" or animStatus == "Stop") and (type(animName) == "string" and animName ~= "") then
		self.Client.UpdatedAnimation:FireFor(tbl:GetPlayers(), player, animName, animStatus)
	end
end

function Gameplay:UpdateVR(player : Player, updateType : string, ...)
	local tbl, participant = self:FindTableWithPlayer(player)
	local args = table.pack(...)
	
	if tbl and participant then
		if updateType == "CARD_GRAB" and type(args[2]) == "table" then
			participant.GrabbedCards = args[2]
		end
		
		self.Client.UpdatedVR:FireFor(tbl:GetPlayers(), player, updateType, ...)
	end
end

function Gameplay:ActivateVR(player : Player)
	if not player:FindFirstChild("isVR") then
		local newValue = Instance.new("BoolValue")
		newValue.Name = "isVR"
		newValue.Parent = player
		newValue.Value = true
	end
end

function Gameplay:UpdateMovement(player : Player?, object : any?, newCFrame : CFrame)
	local tbl = self:FindTableWithPlayer(player)
	
	if tbl then
		self.Client.MovementUpdate:FireFor(tbl:GetPlayers(), object, newCFrame)
	end
end

function Gameplay:GetTableData(player : Player, data : {string})
	local toReturn = {}
	
	if type(data) == "table" then
		for _, tbl in pairs(self.Tables) do
			if tbl.JoinType ~= "Friends" or player:IsFriendsWith(tbl.Host.UserId) or table.find(tbl:GetPlayers(), player) then
				if not tbl.InProgress then
					local tblData = {}

					for i, v in pairs(data) do
						tblData[v] = tbl[v]
					end

					table.insert(toReturn, tblData)
				end
			end
		end
	end
	
	return toReturn
end

function Gameplay.Client:ChangeSpectate(player : Player, nowSpectating : number)
	return self.Server:ChangeSpectate(player, nowSpectating)
end

function Gameplay.Client:AttemptStartGame(player : Player) : (boolean, string?)
	return self.Server:AttemptStartGame(player)
end

function Gameplay.Client:AttemptPlayAgain(player : Player) : (boolean, string?)
	return self.Server:AttemptPlayAgain(player)
end

function Gameplay.Client:AttemptCreateTable(player : Player, data : Table) : (boolean, string?)
	return self.Server:AttemptCreateTable(player, data)
end

function Gameplay.Client:AttemptJoinTable(player : Player, hostUserId : number, password : string?) : (boolean, string?)
	return self.Server:AttemptJoinTable(player, hostUserId, password)
end

function Gameplay.Client:AttemptKickFromTable(player : Player, userIdToKick : number) : (boolean, string?)
	return self.Server:AttemptKickFromTable(player, userIdToKick)
end

function Gameplay.Client:AttemptLeaveTable(player : Player) : (boolean, string?)
	return self.Server:AttemptLeaveTable(player)
end

function Gameplay.Client:AttemptPlayCard(player : Player, cards : {number}, isVR : boolean?) : (boolean, string?)
	return self.Server:AttemptPlayCard(player, cards, isVR)
end

function Gameplay.Client:AttemptDrinkPotion(player : Player, potion : number?, isVR : boolean?) : (boolean, string?)
	return self.Server:AttemptDrinkPotion(player, potion, nil, nil, isVR)
end

function Gameplay.Client:AttemptCallOut(player : Player, isVR : boolean?) : (boolean, string?)
	return self.Server:AttemptCallOut(player)
end

function Gameplay.Client:AttemptBackToMenu(player : Player) : (boolean, string?)
	return self.Server:AttemptBackToMenu(player)
end

function Gameplay.Client:AttemptPurchaseEffect(player : Player, effectName : string) : (boolean, string?)
	return self.Server:AttemptPurchaseEffect(player, effectName)
end 

function Gameplay.Client:ClientLoaded(player : Player, state : string)
	return self.Server:ClientLoaded(player, state)
end

function Gameplay.Client:GetRadioSongList(player : Player) : {{Name : string, Id : number}?}
	return self.Server:GetRadioSongList(player)
end

function Gameplay.Client:UpdateRadio(player : Player, updateType : string, ...) : (boolean, any?)
	return self.Server:UpdateRadio(player, updateType, ...)
end

function Gameplay.Client:SearchForAudio(player : Player, audioName : string) : {{Name : string, Description : string, Id : number, Creator : string}}?
	return self.Server:SearchForAudio(player, audioName)
end

function Gameplay.Client:UpdateAnimation(player : Player, animName : string, animStatus : string)
	return self.Server:UpdateAnimation(player, animName, animStatus)
end

function Gameplay.Client:UpdateVR(player : Player, updateType : string, ...)
	return self.Server:UpdateVR(player, updateType, ...)
end

function Gameplay.Client:ActivateVR(player : Player)
	return self.Server:ActivateVR(player)
end

function Gameplay.Client:UpdateMovement(player : Player, object : any, newCFrame : CFrame)
	self.Server:UpdateMovement(player, object, newCFrame)
end

function Gameplay.Client:GetTableData(player : Player, data : {string}) : {Table}
	return self.Server:GetTableData(player, data)
end

function Gameplay:OnDataLoaded(player : Player)
	self.Client.UpdateRadioSongList:Fire(player, self:GetRadioSongList(player))
end

function Gameplay:InventoryDataLoaded(player : Player)
	for _, v in pairs(ItemService:GetItemTypes()) do
		InventoryService:CreateInventory(player, v, "Default")
	end
	
	if player.UserId == 20271737 then -- ciera
		if not InventoryService:FindItem(player, "Cards", "The Liar") then
			InventoryService:AddItem(player, "Cards", "The Liar")
		end
	elseif player.UserId == 607342413 then -- phoebe
		if not InventoryService:FindItem(player, "Cards", "Art of the Lie") then
			InventoryService:AddItem(player, "Cards", "Art of the Lie")
		end
		
		if not InventoryService:FindItem(player, "Cards", "Double Sided") then
			InventoryService:AddItem(player, "Cards", "Double Sided")
		end
		
		if not InventoryService:FindItem(player, "Cards", "Pixel Bee") then
			InventoryService:AddItem(player, "Cards", "Pixel Bee")
		end
		
		if not InventoryService:FindItem(player, "Cards", "Pink Leopard") then
			InventoryService:AddItem(player, "Cards", "Pink Leopard")
		end
	elseif player.UserId == 1216065703 then -- hiroev
		if not InventoryService:FindItem(player, "Cards", "Devil's Mark") then
			InventoryService:AddItem(player, "Cards", "Devil's Mark")
		end
		
		if not InventoryService:FindItem(player, "Cards", "Golden Lie") then
			InventoryService:AddItem(player, "Cards", "Golden Lie")
		end
	elseif player.UserId == 1466858004 then -- nexus
		if not InventoryService:FindItem(player, "Cards", "Lantern in the Night") then
			InventoryService:AddItem(player, "Cards", "Lantern in the Night")
		end
	end
	
	if Utils.playerOwnsBadge(player, 2341060474770176) then
		if not InventoryService:FindItem(player, "Cards", "Tennis Ball") then
			InventoryService:AddItem(player, "Cards", "Tennis Ball")
		end
	end
	
	if Utils.playerOwnsBadge(player, 685602167925084) then
		if not InventoryService:FindItem(player, "Cards", "Egg Hunt") then
			InventoryService:AddItem(player, "Cards", "Egg Hunt")
		end
	end

	if Utils.playerOwnsBadge(player, 1611887807562580) then
		if not InventoryService:FindItem(player, "Cards", "Tennis Simulator") then
			InventoryService:AddItem(player, "Cards", "Tennis Simulator")
		end
	end

	if Utils.playerOwnsBadge(player, 2128668224) then
		if not InventoryService:FindItem(player, "Cards", "Anvil Drop") then
			InventoryService:AddItem(player, "Cards", "Anvil Drop")
		end
	end
	
	if Utils.playerOwnsBadge(player, 978543569247880) then
		if not InventoryService:FindItem(player, "Potions", "Tip Jar") then
			InventoryService:AddItem(player, "Potions", "Tip Jar")
		end
	end

	if Utils.playerOwnsBadge(player, 2124710024) then
		if not InventoryService:FindItem(player, "Cards", "BEDTIME") then
			InventoryService:AddItem(player, "Cards", "BEDTIME")
		end
	end

	if Utils.playerOwnsBadge(player, 2129624276) then
		if not InventoryService:FindItem(player, "Cards", "Flickball Frenzy") then
			InventoryService:AddItem(player, "Cards", "Flickball Frenzy")
		end
	end
end

function Gameplay:CurrencyDataLoaded(player : Player)
	CurrencyService:CreateCurrency(player, "Cash")
	--CurrencyService:CreateCurrency(player, "Beach Balls")
	CurrencyService:CreateCurrency(player, "Wins", 0, true)
	CurrencyService:CreateCurrency(player, "GamesPlayed")
	CurrencyService:CreateCurrency(player, "TimePlayed")
	CurrencyService:CreateCurrency(player, "LiarsCalled")
	CurrencyService:CreateCurrency(player, "CardsPlayed")
	CurrencyService:CreateCurrency(player, "PotionsDrank")
	CurrencyService:CreateCurrency(player, "WinStreak")
	
	if game.PlaceId == UtilSettings.Pro_Server and CurrencyService:GetAmount(player, "Wins") < 50 then
		TeleportService:Teleport(UtilSettings.Main_Server, player)
	else
		local LeftWhileInGame = PlayerDataService:GetValue(player, "WinStreakAntiCheat")
		
		if LeftWhileInGame then
			CurrencyService:SetAmount(player, "WinStreak", 0)
			PlayerDataService:SetValue(player, "WinStreakAntiCheat", false)
		end
		
		task.spawn(function()
			while player and player.Parent do
				task.wait(1)
				CurrencyService:Add(player, "TimePlayed", 1)
			end
		end)
		
		local playerWins = CurrencyService:GetAmount(player, "Wins")
		
		if playerWins then
			for i, v in pairs(BadgeIds.Wins) do
				if playerWins >= i then
					Utils.awardBadge(player, v)
				end
			end
		end
	end
end

function Gameplay:OnPlayerAdded(player : Player)
	player.CharacterAppearanceLoaded:Connect(function(character)
		task.wait(1)

		local hum = character:FindFirstChildWhichIsA("Humanoid")
		local pTable, participant = self:FindTableWithPlayer(player)
		local seat = (pTable and pTable:GetObject(player.UserId .. "_CHAIR")) or (workspace:FindFirstChild(player.UserId))
		
		if hum then
			if seat then
				seat:Sit(hum)
			else
				hum.Health = 0
			end
		end
		
		local CardsFolder = Instance.new("Folder")
		
		CardsFolder.Name = "Cards"
		CardsFolder.Parent = character
		
		local head = character:FindFirstChild("Head")
		local LeftHand = character:FindFirstChild("LeftHand")
		local RightHand = character:FindFirstChild("RightHand")
		local getCard = ItemService:FindItem("Cards", InventoryService:GetEquipped(player, "Cards") or "Default")
		local getPotion = ItemService:FindItem("Potions", InventoryService:GetEquipped(player, "Potions") or "Default")
		local cardModel = getCard and getCard.Model
		local potionModel = getPotion and getPotion.Model
		
		if LeftHand and RightHand and cardModel and potionModel then
			for i = 1, 5 do
				local newCard = cardModel:Clone()
				
				newCard.Name = "Card" .. i
				newCard.Transparency = 1
				newCard.CanCollide = false
				newCard.Anchored = false
				newCard.Parent = CardsFolder
				
				for _, v in pairs(newCard:GetChildren()) do
					if v:IsA("Decal") then
						v.Transparency = 1
					end
				end
				
				local motor6D = Instance.new("Motor6D")
				
				motor6D.Part1 = newCard
				motor6D.Part0 = LeftHand
				motor6D.C0 = self.MotorCFrames[i]
				motor6D.Parent = newCard
			end
			
			local newCard = cardModel:Clone()
			local findBack = newCard:FindFirstChild("Back")
			
			if findBack then
				findBack.Face = Enum.NormalId.Top
				findBack.Transparency = 1
			end
			
			newCard.Name = "RightHandCard"
			newCard.Transparency = 1
			newCard.CanCollide = false
			newCard.Anchored = false
			newCard.Parent = character
			
			local motor6D = Instance.new("Motor6D")
			
			motor6D.Part1 = newCard
			motor6D.Part0 = RightHand
			motor6D.C0 = CFrame.new(-0.1, -0.2, -0.5) * CFrame.Angles(-20, 10, 0)
			motor6D.Parent = newCard
			
			local newPotion = potionModel:Clone()
			
			newPotion.Name = "RightHandPotion"
			newPotion.CanCollide = false
			newPotion.Transparency = 1
			newPotion.Anchored = false
			newPotion.Parent = character
			
			for _, p in pairs(newPotion:GetDescendants()) do
				if p:IsA("BasePart") or p:IsA("Decal") or p:IsA("Texture") then
					p.Transparency = 1
				elseif Utils.isEffect(p) then
					p.Enabled = false
				end
			end
			
			local new6D = Instance.new("Motor6D")

			new6D.Part1 = newPotion
			new6D.Part0 = RightHand
			new6D.C0 = CFrame.new(0, -0.25, -0.45) * CFrame.Angles(math.rad(-90), 0, 0)
			new6D.Parent = newPotion
		end
		
		pcall(function()
			Accessory.CheckPlayer(character, 1000)
		end)
	end)
	
	repeat task.wait() until player.PlayerGui or not player or not player.Parent
	
	if player.PlayerGui then
		for _, v in pairs(ServerStorage:WaitForChild("StarterGui"):GetChildren()) do
			v:Clone().Parent = player.PlayerGui
		end
	end
	
	if player and player.Parent then
		if game.PlaceId == 80342862330041 then
			Utils.awardBadge(player, 2519168769635825)
		elseif game.PlaceId == 132313578914910 then
			Utils.awardBadge(player, 1493824208134819)
		end
		
		for _, v in pairs(Players:GetPlayers()) do
			if v and v.Parent then
				if v:GetRankInGroup(4620969) >= 251 then
					for _, v2 in pairs(Players:GetPlayers()) do
						Utils.awardBadge(v2, 418560954545496)
					end
					
					break
				end
			end
		end
	end
end

function Gameplay:OnPlayerRemoved(player : Player)
	local pTable, participant = self:FindTableWithPlayer(player)
	
	if pTable then
		if pTable.InProgress then
			if participant then
				participant:LeftGame()
				
				pTable:DestroyObject(participant.UserId .. "_CHAIR")
				
				for _, v in pairs(pTable:GetPlayers()) do
					local isAdmin = ModerationService:IsPlayerWhitelisted(v, "cheats")
					self.Client.LivingParticipantsChanged:Fire(v, (isAdmin and self:GetParticipantPropertiesWithout(pTable:GetLivingParticipants(), "")) or (self:GetParticipantPropertiesWithout(pTable:GetLivingParticipants(), "Cards")))
				end
				
				task.spawn(function()
					for _, v in pairs(pTable:GetParticipantsInGame()) do
						local newAmount = v:RemoveSpectator(player.UserId)

						if newAmount then
							self.Client.SpectatorsChanged:Fire(v.Player, newAmount)
						end
					end
				end)	
			end
		else
			pTable:Leave(player)
			
			task.spawn(function()
				if pTable.Host == participant or #pTable.Participants == 0 then
					self.Client.TableCancelled:FireAll(pTable.Host, pTable.Participants)
					self:ClearTable(pTable)
				end
			end)
		end
	end
	
	local findChair = workspace:FindFirstChild(player.UserId)
	
	if findChair then
		findChair:Destroy()
	end
end

function Gameplay:KnitInit()
	LeaderboardService = Knit.GetService("LeaderboardService")
	ItemService = Knit.GetService("ItemService")
	InventoryService = Knit.GetService("InventoryService")
	CurrencyService = Knit.GetService("CurrencyService")
	ShopService = Knit.GetService("ShopService")
	ModerationService = Knit.GetService("ModerationService")
	PlayerDataService = Knit.GetService("PlayerDataService")
	SettingsService = Knit.GetService("SettingsService")
	
	print(script.Name .. " initialized")
end

function Gameplay:KnitStart()
	print(script.Name .. " started")
end

return Gameplay