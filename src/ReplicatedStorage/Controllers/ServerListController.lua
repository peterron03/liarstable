--[[
@TheAlmightyForehead
September 16th, 2025
This handles updating the client with server list
]]

-- SERVICES --
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local VoiceChatService = game:GetService("VoiceChatService")
local TeleportService = game:GetService("TeleportService")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local ServerListService

-- MODULES --
local Icon = require(ReplicatedStorage.Packages.Icon)
local Settings = require(ReplicatedStorage.Utilities.Settings)

-- PLAYER --
local Player = Players.LocalPlayer

-- UI --
local PlayerGui = Players.LocalPlayer.PlayerGui
local ServerListGui = PlayerGui:WaitForChild("ServerListGui")
local ServerListFrame = ServerListGui:WaitForChild("ServerList")
local ServerListInsideFrame = ServerListFrame:WaitForChild("InsideFrame")
local ServerScrollingFrame = ServerListInsideFrame:WaitForChild("ScrollingFrame")
local ServerExampleFrame = ServerScrollingFrame:WaitForChild("EXAMPLE")
local VCServerListFrame = ServerListFrame:Clone()
VCServerListFrame.Name = "VCServerList"
VCServerListFrame.Description.Text = "VOICE CHAT SERVERS"
VCServerListFrame.Parent = ServerListFrame.Parent
local VCServerListInsideFrame = VCServerListFrame:WaitForChild("InsideFrame")
local VCServerScrollingFrame = VCServerListInsideFrame:WaitForChild("ScrollingFrame")
local VCServerExampleFrame = VCServerScrollingFrame:WaitForChild("EXAMPLE")

-- ICONS --
local serversIcon = Icon.new()
serversIcon:setName("Servers")
serversIcon:setOrder(1)
serversIcon:setImage("rbxassetid://11953906254")
serversIcon:setLabel("Servers")
serversIcon:setLeft()
serversIcon:setTextFont(Enum.Font.Merriweather)
serversIcon:setEnabled(true)

local vcServersIcon = Icon.new()
vcServersIcon:setName("VC Servers")
vcServersIcon:setOrder(3)
vcServersIcon:setImage("rbxassetid://11953906254")
vcServersIcon:setLabel("VC Servers")
vcServersIcon:setLeft()
vcServersIcon:setTextFont(Enum.Font.Merriweather)
vcServersIcon:setEnabled(false)

local ServerList = Knit.CreateController {
	Name = "ServerListController",
}

function ServerList:UpdateServerGui(servers)
	for i, v in ServerScrollingFrame:GetChildren() do
		if v:IsA("Frame") and v ~= ServerExampleFrame then
			v:Destroy()
		end
	end

	for i, v in VCServerScrollingFrame:GetChildren() do
		if v:IsA("Frame") and v ~= VCServerExampleFrame then
			v:Destroy()
		end
	end

	for jobId, server in servers do
		if server.PlayerCount <= 0 then continue end
		if server.IsPrivate then return end

		local isYourServer = game.JobId == server.JobId
		local newFrame = ServerExampleFrame:Clone()

		newFrame.Name = server.JobId
		newFrame.PlayerCount.Text = `{server.PlayerCount}/{server.MaxPlayers}`

		for _, playerId in server.PlayerIds do
			local newIconFrame = newFrame.Frame.PlayerIcons.EXAMPLE:Clone()
			newIconFrame.Image = `rbxthumb://type=AvatarHeadShot&id={playerId}&w=420&h=420`
			newIconFrame.Name = playerId
			newIconFrame.Parent = newFrame.Frame.PlayerIcons
			newIconFrame.Visible = true
		end

		if isYourServer then
			newFrame.JoinButton.Visible = false
			newFrame.YourServerLabel.Visible = true
		else
			newFrame.YourServerLabel.Visible = false
			newFrame.JoinButton.Visible = true

			newFrame.JoinButton.MouseButton1Click:Connect(function()
				TeleportService:TeleportToPlaceInstance(server.PlaceId, server.JobId)
			end)
		end

		if server.PlaceId == Settings.VC_Only_Server then
			newFrame.Parent = VCServerScrollingFrame
		else
			newFrame.Parent = ServerScrollingFrame
		end
		
		newFrame.LayoutOrder = -server.PlayerCount

		newFrame.Visible = true
	end
end

function ServerList:KnitInit()
	ServerListService = Knit.GetService("ServerListService")
	
	serversIcon.toggled:Connect(function()
		ServerListFrame.Visible = not ServerListFrame.Visible
	end)

	vcServersIcon.toggled:Connect(function()
		VCServerListFrame.Visible = not VCServerListFrame.Visible
	end)
	
	ServerListService.UpdateServers:Connect(function(servers)
		self:UpdateServerGui(servers)
	end)
	
	pcall(function()
		local servers = ServerListService:GetServers()
		
		if servers then
			self:UpdateServerGui(servers)
		end
	end)
	
	pcall(function()
		if VoiceChatService:IsVoiceEnabledForUserIdAsync(Players.LocalPlayer.UserId) then
			vcServersIcon:setEnabled(true)
		end
	end)
	
	print(script.Name .. " initialized")
end

function ServerList:KnitStart()
	print(script.Name .. " started")
end

return ServerList