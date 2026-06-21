--[[
@TheAlmightyForehead
September 16th, 2025
This handles creating and managing server lists
]]

-- ROBLOX SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- MODULES --
local Utils = require(ReplicatedStorage.Utilities.Utils)

local ServerList = Knit.CreateService {
	Name = "ServerListService",
	
	Servers = {},
	
	INCLUDE_PRIVATE_SERVERS = false,
	
	Client = {
		UpdateServers = Knit.CreateSignal()
	}
}

function ServerList:Publish()
	local players = Players:GetPlayers()
	local playerIds = {}
	
	for _, player in players do
		table.insert(playerIds, player.UserId)
	end
	
	local message = {
		UpdateTick = DateTime.now().UnixTimestamp,
		JobId = game.JobId,
		PlaceId = game.PlaceId,
		PlayerCount = #players,
		PlayerIds = playerIds,
		MaxPlayers = Players.MaxPlayers,
		IsPrivate = Utils.isPrivateServer()
	}
	
	self.Servers[game.JobId] = message
	
	MessagingService:PublishAsync("ServerList", message)
end

function ServerList:ClearInactives()
	local currentTick = DateTime.now().UnixTimestamp
	
	for jobId, server in self.Servers do
		if currentTick - server.UpdateTick > 65 then
			self.Servers[jobId] = nil
		end
	end
end

function ServerList:GetServers()
	return self.Servers
end

function ServerList.Client:GetServers()
	return self.Server:GetServers()
end

function ServerList:KnitInit()
	MessagingService:SubscribeAsync("ServerList", function(message)
		local info = message.Data
		
		if (info.JobId) and (self.INCLUDE_PRIVATE_SERVERS or not info.IsPrivate) then
			self.Servers[info.JobId] = info
		end
	end)
	
	task.spawn(function()
		while task.wait(30) do
			self:Publish()
			self:ClearInactives()
			self.Client.UpdateServers:FireAll(self.Servers)
		end
	end)
	
	print(script.Name .. " initialized")
end

function ServerList:KnitStart()
	print(script.Name .. " started")
end

return ServerList