--[[
@HttpPeter
October 18th, 2024
This class is for creating and managing Tables for Liar's Table
]]

local Table = {}
Table.__index = Table

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- MODULES --
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)
local EnumList = require(Knit.Util.EnumList)
local Participant = require(script.Participant)

-- OBJECTS --
local Values = ReplicatedStorage:WaitForChild("Values")

-- ENUMS --
local JoinTypes = {"Public", "Private", "Friends"}
local JoinType = EnumList.new("JoinType", JoinTypes)

-- TYPES --
export type Participant = Participant.Participant

export type Table = {
	Host : Participant,
	Participants : {Participant},
	CardStack : {string?},
	MaxCards : number,
	MaxPotions : number,
	MaxParticipants : number,
	InProgress : boolean,
	PlayerCallingOut : Player?,
	CanCallOut : boolean,
	CanPlayCard : boolean,
	CanDrinkPotion : boolean,
	choosingParticipants : Participant?,
	LastTurn : Participant?,
	CurrentTurn : Participant?,
	CurrentCard : string?,
	Password : string?,
	CurrentRound : number,
	Room : string,
	JoinType : EnumItem?,
	IncludeJokers : ("Yes" | "No")?,
	IncludeDemon : ("Yes" | "No")?,
	IncludeAngel : ("Yes" | "No")?,
	AutoLiar : ("Yes" | "No")?,
	AnyLiar : ("Yes" | "No")?,
	OnLastPotion : ("Yes" | "No")?,
	EffectsEnabled : ("Yes" | "No")?,
	Objects : {any?},
	ActiveEffects : {string?}?,
	Blacklist : {UserId : number}?
}

export type TableData = {
	MaxCards : number?,
	MaxPotions : number?,
	MaxParticipants : number?,
	JoinType : EnumItem?,
	IncludeJokers : "Yes"? | "No"?,
	IncludeDemon : "Yes"? | "No"?,
	IncludeAngel : "Yes"? | "No"?,
	AutoLiar : "Yes"? | "No"?,
	AnyLiar : "Yes"? | "No"?,
	OnLastPotion : "Yes"? | "No"?,
	EffectsEnabled : "Yes"? | "No"?,
}

-- TABLES --
local TableValues = {
	["CurrentState"] = "StringValue",
	["Status"] = "StringValue",
	["CurrentCard"] = "StringValue",
	["CurrentTurn"] = "NumberValue",
	["LastCardAmount"] = "NumberValue"
}

function Table.new(playerHost : Player, data : TableData, ownsBiggerTable : boolean?, ownsMorePotions : boolean?, hostRoom : string?, participantPlayers : {Participant}?) : Table
	local self = setmetatable({}, Table)
	
	self.Host = Participant.new(playerHost)
	self.Participants = {self.Host}
	self.CardStack = {}
	self.LastPlayed = {}
	self.Active = true
	self.InProgress = false
	self.PlayerCallingOut = nil
	self.CanCallOut = false
	self.CanPlayCard = false
	self.CanDrinkPotion = false
	self.choosingParticipants = nil
	self.LastTurn = nil
	self.CurrentTurn = nil
	self.CurrentCard = nil
	self.Password = nil
	self.CurrentRound = 0
	self.ParticipantsStartedWith = 0
	self.Room = hostRoom or "Default"
	self.Objects = {}
	self.ActiveEffects = {}
	self.Blacklist = {}
	self.Connections = {}
	
	if participantPlayers then
		for _, v in pairs(participantPlayers) do
			table.insert(self.Participants, Participant.new(v))
		end
	end
	
	self.ValueFolder = Instance.new("Folder")
	self.ValueFolder.Parent = Values
	
	self.ParticipantsChanged = Signal.new()
	
	if type(data) == "table" then
		local maxCards = tonumber(data.MaxCards) or 5
		local maxPotions = tonumber(data.MaxPotions) or 3
		local maxParticipants = tonumber(data.MaxParticipants) or 4
		local joinType = ((type(data.JoinType) == "string" and table.find(JoinTypes, data.JoinType)) and data.JoinType) or ("Public")
		local includeJokers = data.IncludeJokers == "Yes"
		local includeDemon = data.IncludeDemon == "Yes"
		local includeAngel = data.IncludeAngel == "Yes"
		local autoLiar = data.AutoLiar == "Yes"
		local anyLiar = data.AnyLiar == "Yes"
		local lastPotion = data.OnLastPotion == "Yes"
		local effectsEnabled = data.EffectsEnabled == "Yes"
		
		if type(includeJokers) ~= "boolean" then
			includeJokers = true
		end
		
		if type(includeDemon) ~= "boolean" then
			includeDemon = false
		end
		
		if type(includeAngel) ~= "boolean" then
			includeAngel = false
		end
		
		if type(autoLiar) ~= "boolean" then
			autoLiar = false
		end
		
		if type(anyLiar) ~= "boolean" then
			anyLiar = false
		end
		
		if type(lastPotion) ~= "boolean" then
			lastPotion = false
		end
		
		if type(effectsEnabled) ~= "boolean" then
			effectsEnabled = false
		end
		
		if maxCards < 3 then
			maxCards = 3
		elseif maxCards > 5 then
			maxCards = 5
		end
		
		if maxPotions < 1 then
			maxPotions = 1
		elseif maxPotions > 4 then
			if ownsMorePotions then
				if maxPotions > 8 then
					maxPotions = 8
				end
			else
				maxPotions = 4
			end
		end
		
		if maxParticipants < 2 then
			maxParticipants = 2
		elseif maxParticipants > 6 then
			if ownsBiggerTable then
				if maxParticipants > 12 then
					maxParticipants = 12
				end
			else
				maxParticipants = 6
			end
		end
		
		self.MaxCards = maxCards
		self.MaxPotions = maxPotions
		self.MaxParticipants = maxParticipants
		self.JoinType = joinType
		self.IncludeJokers = includeJokers
		self.IncludeDemon = includeDemon
		self.IncludeAngel = includeAngel
		self.AutoLiar = autoLiar
		self.AnyLiar = anyLiar
		self.OnLastPotion = lastPotion
		self.EffectsEnabled = effectsEnabled
		
		if self.JoinType == "Private" then
			self.Password = math.random(1, 9) .. math.random(1, 9) .. math.random(1, 9) .. math.random(1, 9) .. math.random(1, 9)
		end
	else
		self.MaxCards = 5
		self.MaxPotions = 3
		self.MaxParticipants = 4
		self.JoinType = "Public"
		self.IncludeJokers = true
		self.IncludeDemon = false
		self.IncludeAngel = false
		self.AutoLiar = false
		self.AnyLiar = false
		self.OnLastPotion = false
		self.EffectsEnabled = false
	end
	
	for i, v in pairs(TableValues) do
		local newValue = Instance.new(v)
		
		if self[i] then
			newValue.Value = self[i]
		end
		
		newValue.Name = i
		newValue.Parent = self.ValueFolder
	end
	
	return self
end

function Table:RoundStarted()
	self.CurrentRound += 1
end

function Table:SetValue(index : string, value : any)
	local findValue = self.ValueFolder:FindFirstChild(index)
	
	if findValue then
		findValue.Value = value
	end
end

function Table:GetValue(index : string) : any?
	local findValue = self.ValueFolder:FindFirstChild(index)
	return (findValue and findValue.Value) or (nil)
end

function Table:IsPlayerBlacklisted(userId : number) : boolean?
	return (table.find(self.Blacklist, userId) and true) or (false)
end

function Table:BlacklistPlayer(userId : number)
	if not table.find(self.Blacklist, userId) then
		table.insert(self.Blacklist, userId)
	end
end

function Table:UnblacklistPlayer(userId : number)
	local findBlacklist = table.find(self.Blacklist, userId)
	
	if findBlacklist then
		table.remove(self.Blacklist, findBlacklist)
	end
end

function Table:AddEffect(effectName : string, timeDelay : number?)
	table.insert(self.ActiveEffects, effectName)
	
	if timeDelay then
		task.delay(timeDelay, function()
			if self and self.Active then
				self:RemoveEffect(effectName)
			end
		end)
	end
end

function Table:RemoveEffect(effectName : string)
	local findEffect = table.find(self.ActiveEffects, effectName)
	
	if findEffect then
		table.remove(self.ActiveEffects, findEffect)
	end
end

function Table:IsEffectActive(effectName : string)
	return (table.find(self.ActiveEffects, effectName) and true) or (false)
end

function Table:IsEffectActiveFromArray(effects : {string})
	for _, v in pairs(effects) do
		if table.find(self.ActiveEffects, v) then
			return true
		end
	end
	
	return false
end

function Table:GetParticipantsPlayingAgain(notArray : boolean?)
	local participants = {}

	for i, v in pairs(self.Participants) do
		if v.PlayingAgain then
			if not notArray then
				table.insert(participants, v)
			else
				participants[i] = v
			end
		end
	end

	return participants
end

function Table:GetParticipantsInGame(notArray : boolean?)
	local participants = {}

	for i, v in pairs(self.Participants) do
		if v.InGame then
			if not notArray then
				table.insert(participants, v)
			else
				participants[i] = v
			end
		end
	end

	return participants
end

function Table:GetLoadedParticipants(state : string, notArray : boolean?)
	local participants = {}
	
	for i, v in pairs(self.Participants) do
		if v.LoadedState == state then
			if not notArray then
				table.insert(participants, v)
			else
				participants[i] = v
			end
		end
	end

	return participants
end

function Table:GetLivingParticipants(notArray : boolean?, exclude : {Participant}?)
	local participants = {}
	
	for i, v in pairs(self.Participants) do
		if (not v.IsDead) and (v.InGame) and (v.Player) and (v.Player.Parent) and (not exclude or not table.find(exclude, v)) then
			if not notArray then
				table.insert(participants, v)
			else
				participants[i] = v
			end
		end
	end
	
	return participants
end

function Table:GetEligibleParticipantsForTurn(notArray : boolean?, include : Participant?)
	local participants = {}

	for i, v in pairs(self.Participants) do
		local amountOfCards = 0
		
		for i, c in pairs(v.Cards) do
			if c then
				amountOfCards += 1
			end
		end
		
		if (not v.IsDead and v.InGame and amountOfCards > 0 and v.Player and v.Player.Parent) or (include and v == include) then
			if not notArray then
				table.insert(participants, v)
			else
				participants[i] = v
			end
		end
	end

	return participants
end

function Table:GetPlayers()
	local plyrs = {}
	
	for _, v in pairs(self.Participants) do
		if v.InGame then
			table.insert(plyrs, v.Player)
		end
	end
	
	return plyrs
end

function Table:AddObject(newObject, objectName : string?)
	self.Objects[objectName or newObject.Name] = newObject
end

function Table:GetObject(objectName : string) : Instance?
	return self.Objects[objectName]
end

function Table:DestroyObject(objectName : string)
	if self.Objects[objectName] then
		self.Objects[objectName]:Destroy()
	end
end

function Table:FindParticipantInGame(player : Player) : (number | boolean, Participant?)
	for i, v in pairs(self.Participants) do
		if v.Player == player and v.InGame then
			return i, v
		end
	end
	
	return false
end

function Table:FindParticipant(player : Player) : (number | boolean, Participant?)
	for i, v in pairs(self.Participants) do
		if v.Player == player then
			return i, v
		end
	end
	
	return false
end

function Table:SetChoosingParticipants(participant : Participant)
	self.choosingParticipants = participant
end

function Table:AdvanceTurn(noLastTurn)
	local eligibleParticipants = self:GetEligibleParticipantsForTurn(false, self.CurrentTurn)
	local index = table.find(eligibleParticipants, self.CurrentTurn)
	local nextIndex = index + 1
	
	if not eligibleParticipants[nextIndex] then
		nextIndex = 1
	end
	
	if not noLastTurn then
		self.LastTurn = self.CurrentTurn
	end
	
	self.CurrentTurn = eligibleParticipants[nextIndex]
	
	if type(self.CurrentTurn) == "table" and self.CurrentTurn.UserId then
		self:SetValue("CurrentTurn", self.CurrentTurn.UserId)
	else
		self:SetValue("CurrentTurn", 0)
	end
end

function Table:SetCard(card : string)
	self.CurrentCard = card
	
	if card then
		self:SetValue("CurrentCard", card)
	else
		self:SetValue("CurrentCard" , "")
	end
end

function Table:SetTurn(participant : Participant)
	self.CurrentTurn = participant
	
	if type(self.CurrentTurn) == "table" and self.CurrentTurn.UserId then
		self:SetValue("CurrentTurn", self.CurrentTurn.UserId)
	else
		self:SetValue("CurrentTurn", 0)
	end
end

function Table:PlayCards(cards : {string})
	for _, v in pairs(cards) do
		table.insert(self.CardStack, v)
	end
	
	self.LastPlayed = cards	
	self.LastCardAmount = #self.LastPlayed
end

function Table:CheckLastCard(card : string?)
	if #self.LastPlayed ~= 0 then
		for _, v in pairs(self.LastPlayed) do
			if v ~= card and v ~= self.CurrentCard and v ~= "Joker" and v ~= "Demon" and v ~= "Angel" then
				return false
			end
		end
	end
	
	return true
end

function Table:AttemptJoin(player : Player, password : string?) : (boolean, string?)
	if self.JoinType == "Private" and tostring(self.Password) ~= tostring(password) then return false, "Password incorrect" end
	if self.JoinType == "Friends" and not self.Host.Player:IsFriendsWith(player.UserId) then return false, "Players are not friends" end
	if self:IsPlayerBlacklisted(player.UserId) then return false, "Player is blacklisted from table" end
	
	if #self.Participants < self.MaxParticipants then
		if not self:FindParticipantInGame(player) then
			table.insert(self.Participants, Participant.new(player))
			
			self.ParticipantsChanged:Fire()
			
			return true
		else
			return false, "Already in table"
		end
	else
		return false, "Table is full"
	end
end

function Table:Leave(player : Player)
	local index, participant = self:FindParticipant(player)
	
	if index then
		table.remove(self.Participants, index)
		
		self.ParticipantsChanged:Fire()
		
		task.delay(5, function() 
			if participant ~= self.Host then
				participant:Destroy()
			end
		end)
	end
end

function Table:Destroy()
	for _, v in pairs(self.Connections) do
		v:Disconnect()
	end
	
	for _, v in pairs(self.Participants) do
		local character
		
		if v.InGame then
			character = v.Player and v.Player.Character
			local hrt = character and character:FindFirstChild("HumanoidRootPart")
			
			if hrt then
				hrt.Anchored = true
				hrt.CFrame *= CFrame.new(0, 1000, 0)
			end
		end
			
		task.delay(1, function()
			if character then
				if v.Player and v.Player.Character then
					v.Player.Character = nil
				end
				
				character:Destroy()
			end
		
			v:Destroy()
		end)
	end
	
	for _, v in pairs(self.Objects) do
		v:Destroy()
	end
	
	if self.ValueFolder then
		self.ValueFolder:Destroy()
	end
	
	self.ParticipantsChanged:Destroy()
	
	self.Active = false
	
	setmetatable(self, nil)
	table.clear(self)
	table.freeze(self)
end

return Table

