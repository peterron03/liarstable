--[[
@TheAlmightyForehead
April 18th, 2024
This handles (mostly) everything on the server
]]

-- SERVICES --
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- PACKAGES --
local Packages = ReplicatedStorage:WaitForChild("Packages")

-- KNIT SET UP --
local Knit = require(Packages:WaitForChild("Knit"))

Knit.AddServices(script.Parent.Services)

Knit.Start({ServicePromises = false}):andThen(function()
	print("Knit started")
end):catch(warn)

-- KNIT SERVICES --
local CurrencyService = Knit.GetService("CurrencyService")
local InventoryService = Knit.GetService("InventoryService")
local PlayerDataService = Knit.GetService("PlayerDataService")

local function RunServiceFunction(functionName : string, ...)
	for name, service in pairs(Knit.GetServices()) do
		if (type(service) == "table") and (type(service[functionName]) == "function") then
			service[functionName](service, ...)
		end
	end
end

CurrencyService.DataLoaded:Connect(function(player, data)
	RunServiceFunction("CurrencyDataLoaded", player, data)
end)

InventoryService.DataLoaded:Connect(function(player, data)
	RunServiceFunction("InventoryDataLoaded", player, data)
end)

PlayerDataService.DataLoaded:Connect(function(player, data)
	RunServiceFunction("OnDataLoaded", player, data)
end)

for _, player in pairs(Players:GetPlayers()) do
	RunServiceFunction("OnPlayerAdded", player)
end

Players.PlayerAdded:Connect(function(player)
	RunServiceFunction("OnPlayerAdded", player)
end)

Players.PlayerRemoving:Connect(function(player)
	RunServiceFunction("OnPlayerRemoved", player)
end)

game:BindToClose(function()
	for _, player in pairs(Players:GetPlayers()) do
		RunServiceFunction("OnPlayerRemoved", player)
	end
end)