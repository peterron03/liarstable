--[[
@TheAlmightyForehead
March 18th, 2024
This service handles currencies
]]

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local PlayerDataService

local Currency = Knit.CreateService {
	Name = "CurrencyService",
	
	AddedCurrency = Signal.new(),
	RemovedCurrency = Signal.new(),
	CurrencyChanged = Signal.new(),
	DataChanged = Signal.new(),
	DataLoaded = Signal.new(),
	
	PlayerData = {},
	Leaderstats = {},
	
	Client = {
		AddedCurrency = Knit.CreateSignal(),
		RemovedCurrency = Knit.CreateSignal(),
		CurrencyChanged = Knit.CreateSignal(),
		DataChanged = Knit.CreateSignal(),
		DataLoaded = Knit.CreateSignal()
	}
}

function Currency:CreateCurrency(player : Player, currencyName : string, startAmount : number?, isLeaderstat : boolean?)
	if not self.PlayerData[player] then return end
	
	if not self.PlayerData[player][currencyName] then
		self.PlayerData[player][currencyName] = startAmount or 0

		self:SelfCurrencyChanged(player, currencyName, self.PlayerData[player][currencyName])
		self.CurrencyChanged:Fire(player, currencyName, self.PlayerData[player][currencyName])
		self:SelfDataChanged(player, self.PlayerData[player])
		self.DataChanged:Fire(player, self.PlayerData[player])
		self.Client.CurrencyChanged:Fire(player, currencyName, self.PlayerData[player][currencyName])
		--self.Client.DataChanged:Fire(player, self.PlayerData[player])
	end
	
	if isLeaderstat then
		if not self.Leaderstats[player] then return end
		
		local newLeaderstat = Instance.new("NumberValue")
		newLeaderstat.Value = self.PlayerData[player][currencyName]
		newLeaderstat.Name = currencyName
		newLeaderstat.Parent = self.Leaderstats[player]
	end

	return self.PlayerData[player]
end

function Currency:DestroyCurrency(player : Player, currencyName : string)
	if not self.PlayerData[player] then return end
	
	self.PlayerData[player][currencyName] = nil
	
	self:SelfDataChanged(player, self.PlayerData[player])
	self.DataChanged:Fire(player, self.PlayerData[player])
	--self.Client.DataChanged:Fire(player, self.PlayerData[player])

	return self.PlayerData[player]
end

function Currency:ResetCurrency(player : Player, currencyName : string, startAmount : number?, isLeaderstat : boolean?)
	if not self.PlayerData[player] then return end

	self:DestroyCurrency(player, currencyName)

	return self:CreateCurrency(player, currencyName, startAmount, isLeaderstat)
end

function Currency:GetData(player : Player)
	return self.PlayerData[player]
end

function Currency:DoesCurrencyExist(player : Player, currencyName : string) : boolean?
	if not self.PlayerData[player] then return false end
	return self.PlayerData[player][currencyName]
end

function Currency:GetAmount(player : Player, currencyName : string) : number
	return (self.PlayerData[player] and self.PlayerData[player][currencyName]) or (0)
end

function Currency:CanPlayerAfford(player : Player, currencyName : string, amountToCheck : number) : boolean
	if self.PlayerData[player] and self.PlayerData[player][currencyName] then
		return self.PlayerData[player][currencyName] >= amountToCheck
	else
		return false
	end
end

function Currency:SetAmount(player : Player, currencyName : string, amountToSet : number) : number?
	if not self.PlayerData[player] then return end
	
	self.PlayerData[player][currencyName] = amountToSet
	
	self:SelfCurrencyChanged(player, currencyName, self.PlayerData[player][currencyName])
	self.CurrencyChanged:Fire(player, currencyName, self.PlayerData[player][currencyName])
	self:SelfDataChanged(player, self.PlayerData[player])
	self.DataChanged:Fire(player, self.PlayerData[player])
	self.Client.CurrencyChanged:Fire(player, currencyName, self.PlayerData[player][currencyName])
	--self.Client.DataChanged:Fire(player, self.PlayerData[player])
	
	return self.PlayerData[player][currencyName] or 0
end

function Currency:Add(player : Player, currencyName : string, amountToAdd : number) : number?
	if not self.PlayerData[player] then return end
	
	if not self.PlayerData[player][currencyName] then
		self.PlayerData[player][currencyName] = 0
	end
	
	self.PlayerData[player][currencyName] += amountToAdd
	
	self.AddedCurrency:Fire(player, currencyName, amountToAdd)
	self:SelfCurrencyChanged(player, currencyName, self.PlayerData[player][currencyName])
	self.CurrencyChanged:Fire(player, currencyName, self.PlayerData[player][currencyName])
	self:SelfDataChanged(player, self.PlayerData[player])
	self.DataChanged:Fire(player, self.PlayerData[player])
	self.Client.AddedCurrency:Fire(player, currencyName, amountToAdd)
	self.Client.CurrencyChanged:Fire(player, currencyName, self.PlayerData[player][currencyName])
	--self.Client.DataChanged:Fire(player, self.PlayerData[player])
	
	return self.PlayerData[player][currencyName] or 0
end

function Currency:Subtract(player : Player, currencyName : string, amountToSubtract : number) : number?
	if not self.PlayerData[player] then return end
	
	if not self.PlayerData[player][currencyName] then
		self.PlayerData[player][currencyName] = 0
	end
	
	self.PlayerData[player][currencyName] -= amountToSubtract
	
	self.RemovedCurrency:Fire(player, currencyName, amountToSubtract)
	self:SelfCurrencyChanged(player, currencyName, self.PlayerData[player][currencyName])
	self.CurrencyChanged:Fire(player, currencyName, self.PlayerData[player][currencyName])
	self:SelfDataChanged(player, self.PlayerData[player])
	self.DataChanged:Fire(player, self.PlayerData[player])
	--self.Client.RemovedCurrency:Fire(player, currencyName, amountToSubtract)
	self.Client.CurrencyChanged:Fire(player, currencyName, self.PlayerData[player][currencyName])
	--self.Client.DataChanged:Fire(player, self.PlayerData[player])

	return self.PlayerData[player][currencyName] or 0
end

function Currency.Client:GetAmount(player : Player, currencyName : string) : number
	return self.Server:GetAmount(player, currencyName)
end

function Currency.Client:CanPlayerAfford(player : Player, currencyName : string, amountToCheck : number) : boolean
	return self.Server:CanPlayerAfford(player, currencyName, amountToCheck)
end

function Currency.Client:DoesCurrencyExist(player : Player, currencyName : string) : boolean?
	return self.Server:DoesCurrencyExist(player, currencyName)
end

function Currency:OnPlayerAdded(player : Player)
	if self.Leaderstats[player] then return end
	
	self.Leaderstats[player] = Instance.new("Folder")
	self.Leaderstats[player].Name = "leaderstats"
	self.Leaderstats[player].Parent = player
end

function Currency:OnPlayerRemoved(player : Player)
	self.PlayerData[player] = nil
	self.Leaderstats[player] = nil
end

function Currency:OnDataLoaded(player : Player, data : any)
	self.PlayerData[player] = data.Data.CurrencyData or {}

	for currencyName, amount in pairs(self.PlayerData[player]) do
		self:SelfCurrencyChanged(player, currencyName, self.PlayerData[player][currencyName])
		self.CurrencyChanged:Fire(player, currencyName, amount)
		self.Client.CurrencyChanged:Fire(player, currencyName, amount)
	end

	self.DataLoaded:Fire(player, self.PlayerData[player])
	--self.Client.DataLoaded:Fire(player, self.PlayerData[player])
end

function Currency:SelfDataChanged(player : Player, data : any)
	PlayerDataService:SetValue(player, "CurrencyData", data)
end

function Currency:SelfCurrencyChanged(player : Player, currencyName : string, currencyAmount : string)
	if not self.Leaderstats[player] then return end

	local leaderstat = self.Leaderstats[player]:FindFirstChild(currencyName)

	if leaderstat then
		leaderstat.Value = currencyAmount
	end
end

function Currency:KnitInit()
	PlayerDataService = Knit.GetService("PlayerDataService")
	
	print(script.Name .. " initialized")
end

function Currency:KnitStart()
	print(script.Name .. " started")
end

return Currency