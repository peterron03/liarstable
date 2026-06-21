--[[
@TheAlmightyForehead
May 21st, 2024
Using ProfileService, this handles (mostly) all player data
]]

-- ROBLOX SERVICES --
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- MODULES --
local Utilities = ReplicatedStorage:WaitForChild("Utilities")
local Settings = require(Utilities:WaitForChild("Settings"))

-- PROFILESERVICE --
local ProfileService = require(script.ProfileService)

-- PROFILE STORES --
local ProfileStore = ProfileService.GetProfileStore("PLAYER_DATA_" .. Settings.DataStoreVersion, {})

local PlayerData = Knit.CreateService {
	Name = "PlayerDataService",
	
	Profiles = {},
	OrderedDataStores = {},
	NormalDataStores = {},
	
	DataLoaded = Signal.new(),
	
	Client = {}
}

function PlayerData:UpdateOrderedData(player : Player, valueName : string, value : number)
	if player and type(valueName) == "string" and tonumber(value) then
		if not self.OrderedDataStores[valueName] then
			self.OrderedDataStores[valueName] = DataStoreService:GetOrderedDataStore(valueName .. "_" .. Settings.DataStoreVersion)
		end
		
		local success, err = pcall(function()
			self.OrderedDataStores[valueName]:SetAsync(player.UserId .. "_" .. valueName .. "_DATA", value)
		end)
		
		if not success then
			warn("Error while updating Ordered " .. valueName .. " Data for " .. player.Name .. " (" .. player.UserId .. ") |", err)
		end
	end
end

function PlayerData:GetOrderedData(valueName : string, ascending : boolean?, amount : number?) : DataStorePages?
	if not self.OrderedDataStores[valueName] then
		self.OrderedDataStores[valueName] = DataStoreService:GetOrderedDataStore(valueName .. "_" .. Settings.DataStoreVersion)
	end
	
	local success, data = pcall(function()
		return self.OrderedDataStores[valueName]:GetSortedAsync(ascending, amount or 100)
	end)

	return (success and data) or (nil)
end

function PlayerData:UpdateNormalData(player : Player, valueName : string, value : any)
	if player and type(valueName) == "string" then
		if not self.NormalDataStores[valueName] then
			self.NormalDataStores[valueName] = DataStoreService:GetDataStore(valueName .. "_" .. Settings.DataStoreVersion)
		end

		local success, err = pcall(function()
			self.NormalDataStores[valueName]:SetAsync(player.UserId .. "_" .. valueName .. "_DATA", value)
		end)
		
		if not success then
			warn("Error while updating Normal " .. valueName .. " Data for " .. player.Name .. " (" .. player.UserId .. ") |", err)
		end
	end
end

function PlayerData:UpdateNormalDataWithUserId(userId : number, valueName : string, value : any)
	if userId and type(valueName) == "string" then
		if not self.NormalDataStores[valueName] then
			self.NormalDataStores[valueName] = DataStoreService:GetDataStore(valueName .. "_" .. Settings.DataStoreVersion)
		end

		local success, err = pcall(function()
			self.NormalDataStores[valueName]:SetAsync(userId .. "_" .. valueName .. "_DATA", value)
		end)

		if not success then
			warn("Error while updating Normal " .. valueName .. " Data for " .. userId .. " |", err)
		end
	end
end

function PlayerData:GetNormalData(userId : number, valueName : string)
	if not self.NormalDataStores[valueName] then
		self.NormalDataStores[valueName] = DataStoreService:GetDataStore(valueName .. "_" .. Settings.DataStoreVersion)
	end

	local success, data = pcall(function()
		return self.NormalDataStores[valueName]:GetAsync(userId .. "_" .. valueName .. "_DATA")
	end)

	return (success and data) or (nil)
end

function PlayerData:SetValue(player : Player, valueName : string, value : any?)
	if self.Profiles[player] ~= nil then
		self.Profiles[player].Data[valueName] = value
		return true
	else
		return false
	end
end

function PlayerData:GetValue(player : Player, valueName : string) : any?
	if self.Profiles[player] ~= nil then
		return self.Profiles[player].Data[valueName]
	end
	
	return nil
end

function PlayerData:LoadData(player : Player)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
	
	if profile ~= nil then
		profile:AddUserId(player.UserId)

		profile:ListenToRelease(function()
			self.Profiles[player] = nil
			player:Kick("Error while loading your data, please rejoin.")
		end)
		
		if player:IsDescendantOf(Players) == true then
			self.Profiles[player] = profile
			self.DataLoaded:Fire(player, self.Profiles[player])
		else
			profile:Release()
		end
	else
		player:Kick("Error while loading your data, please rejoin.")
	end
end

function PlayerData:OnPlayerAdded(player : Player)
	self:LoadData(player)
end

function PlayerData:OnPlayerRemoved(player : Player)
	local profile = self.Profiles[player]

	if profile ~= nil then
		profile:Release()
	end
end

function PlayerData:KnitInit()
	print(script.Name .. " initialized")
end

function PlayerData:KnitStart()
	print(script.Name .. " started")
end

return PlayerData