--[[
@TheAlmightyForehead
November 10th, 2024
This handles server-sided methods involving player or game settings
]]

-- ROBLOX SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local PlayerDataService

local Settings = Knit.CreateService {
	Name = "SettingsService",
	
	PlayerSettings = {},
	
	Client = {
		SettingsLoaded = Knit.CreateSignal()
	}
}

function Settings:Update(player : Player, setting : string, value : (string | number)) : (boolean, string?)
	if type(setting) ~= "string" then return false, "Setting name is not a string" end
	if type(value) ~= "string" and type(value) ~= "number" then return false, "Setting value is not a string or number" end
	
	self.PlayerSettings[player][setting] = value
	self:DataChanged(player, self.PlayerSettings[player])
	
	return true
end

function Settings:Get(player : Player) : {setting : (string | number)}?
	return self.PlayerSettings[player]
end

function Settings:GetSetting(player : Player, setting : string) : (string | number)?
	if type(self.PlayerSettings[player]) == "table" then
		return self.PlayerSettings[player][setting]
	else
		return nil
	end
end

function Settings.Client:Update(player : Player, setting : string, value : (string | number)) : (boolean, string?)
	return self.Server:Update(player, setting, value)
end

function Settings.Client:Get(player : Player) : {setting : (string | number)}?
	return self.Server:Get(player)
end

function Settings.Client:GetSetting(player : Player, setting : string) : (string | number)?
	return self.Server:GetSetting(player, setting)
end

function Settings:DataChanged(player : Player, data : any)
	PlayerDataService:SetValue(player, "SettingsData", data)
end

function Settings:OnDataLoaded(player : Player, data : any)
	self.PlayerSettings[player] = data.Data.SettingsData or {}
	self.Client.SettingsLoaded:Fire(player, self.PlayerSettings[player])
end

function Settings:OnPlayerRemoved(player : Player)
	self.PlayerSettings[player] = nil
end

function Settings:KnitInit()
	PlayerDataService = Knit.GetService("PlayerDataService")
	
	print(script.Name .. " initialized")
end

function Settings:KnitStart()
	print(script.Name .. " started")
end

return Settings