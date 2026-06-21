--[[
@TheAlmightyForehead
May 29th, 2024
This handles moderation and commands
]]

-- ROBLOX SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")
local TeleportService = game:GetService("TeleportService")
local TextChatService = game:GetService("TextChatService")
local HttpService = game:GetService("HttpService")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local PlayerDataService
local CurrencyService
local InventoryService
local ItemService

-- UTILITIES --
local Utilities = ReplicatedStorage:WaitForChild("Utilities")
local Utils = require(Utilities:WaitForChild("Utils"))

local Moderation = Knit.CreateService {
	Name = "ModerationService",
	
	Bans = {},
	MutedPlayers = {},
	PositionChecks = {},
	CommandsPrefix = "/",
	
	SheetKey = "SHEET_KEY",
	
	SheetEntries = {
		Suspect = 3201783,
		Profile = 1377374546,
		Administrator = 869901435,
		Action = 353004710,
		Reason = 644096928,
		Timestamp = 1940925337
	},
	
	CommandsWhitelist = {
		Restricted = {
			[3350014406] = {"cheats"}, -- YungCrepetics
			[2526535450] = {"kick", "ban", "mute", "unmute", "unban", "clear", "history", "math", "uptime", "hover", "joinuser", "join-user", "help"}, -- LsxerScythe
			[108304522] = {"kick", "ban", "mute", "unmute", "unban", "clear", "history", "math", "uptime", "hover", "joinuser", "join-user", "help"}, -- diefawn
			[139853483] = {"kick", "ban", "mute", "unmute", "unban", "clear", "history", "math", "uptime", "hover", "joinuser", "join-user", "help"} -- emiliawcn
		},
		
		54040770, -- TheAlmightyForehead
		109182311, -- Huntsman35
		111429858 -- canenero3d
	},
	
	Commands = {},
	
	Client = {
		PlayerMuted = Knit.CreateSignal()
	}
}

function Moderation:LogAction(suspect : {Name : string, Id : number | string}, doneBy : {Name : string, Id : number}, action : string?, reason : string?)
	task.spawn(function()
		local success, err = pcall(function()
			if type(suspect) ~= "table" then warn("Suspect is not a table") return end
			if type(doneBy) ~= "table" then warn("Done by is not a table") return end
			
			--[[local s, PictureUrl = pcall(function()
				if not suspect.Id then return nil end
				return HttpService:JSONDecode(HttpService:GetAsync("https://thumbnails.roproxy.com/v1/users/avatar-headshot?userIds=" .. suspect.Id .. "&size=150x150&format=Png"))
			end)

			if s and PictureUrl then
				PictureUrl = PictureUrl.data[1].imageUrl
			else
				PictureUrl = "https://cdn.discordapp.com/emojis/1309436822937669672.png?size=160&quality=lossless"
			end]]
			
			local fullName = ""
			
			if suspect.Name and suspect.Id then
				fullName = suspect.Name .. " (" .. suspect.Id .. ")"
			elseif suspect.Name then
				fullName = suspect.Name
			elseif suspect.Id then
				fullName = suspect.Id
			else
				warn("Unable to get suspect's full name")
				return
			end
			
			local doneByFullName = ""

			if doneBy.Name and doneBy.Id then
				doneByFullName = doneBy.Name .. " (" .. doneBy.Id .. ")"
			elseif doneBy.Name then
				doneByFullName = doneBy.Name
			elseif doneBy.Id then
				doneByFullName = doneBy.Id
			else
				warn("Unable to get Done By's full name")
				return
			end
			
			local UrlProfile = suspect.Id and "https://www.roblox.com/users/" .. suspect.Id .. "/profile"

			--[[local data = {
				["embeds"] = {
					{
						["title"] = fullName,
						
						["description"] = "-------- ***ADMIN LOG*** --------\n"..
							"__**SUSPECT:**__ " .. fullName .. "\n"..
							"__**ADMIN:**__ " .. doneByFullName .. "\n"..
							"__**ACTION:**__ " .. ((type(action) == "string" and string.upper(string.sub(action, 1, 1))..string.sub(action, 2, -1)) or "N/A") .. "\n"..
							"__**REASON:**__ " .. (reason or "N/A") .. "\n"..
							"--------------------------",
						
						["url"] = UrlProfile or nil,
						
						["footer"] = {
							["icon_url"] = "https://cdn.discordapp.com/emojis/1309436822937669672.png?size=160&quality=lossless"
						},
						
						["timestamp"] = DateTime.now():ToIsoDate()
					}
				},
				
				["username"] = fullName,
				
				["avatar_url"] = PictureUrl,
			}]]
			
			local url  = "https://docs.google.com/forms/d/e/" .. self.SheetKey .. "/formResponse?usp=pp_url"
				.."&entry." .. self.SheetEntries.Suspect .. "=".. fullName
				.."&entry." .. self.SheetEntries.Profile .. "=" .. (UrlProfile or "UNKNOWN")
				.."&entry." .. self.SheetEntries.Administrator .. "=" .. doneByFullName
				.."&entry." .. self.SheetEntries.Action .. "=".. ((type(action) == "string" and string.upper(string.sub(action, 1, 1))..string.sub(action, 2, -1)) or "-")
				.."&entry." .. self.SheetEntries.Reason .. "=" .. (reason or "-")
				.."&entry." .. self.SheetEntries.Timestamp .. "=" .. DateTime.now():ToIsoDate()

			HttpService:PostAsync(url, "")
		end)

		if not success then
			warn(err)
		end
	end)
end

function Moderation:IsPlayerWhitelisted(player : Player, forCommand : string?) : boolean -- TODO: add forCommand
	if table.find(self.CommandsWhitelist, player.UserId) then
		return true
	else
		for id, commands in pairs(self.CommandsWhitelist.Restricted) do
			if (id == player.UserId) and (not forCommand or table.find(commands, forCommand)) then
				return true
			end
		end
	end
	
	return false
end

function Moderation:KickPlayer(player : Player, userKicking : string, msg : string?, isBan : boolean?) : (boolean, string?)
	local success, err = pcall(function()
		local kickOrBan = (isBan and "banned") or ("kicked")
		
		player:Kick("You have been " .. kickOrBan .. " by " .. userKicking .. ((msg and (" for '" .. msg .. "'")) or ""))
		
		self:LogAction({Name = player.Name, Id = player.UserId}, {Name = userKicking or "System"}, kickOrBan, msg)
	end)
	
	return success, err
end

function Moderation:UpdateMutedPlayers()
	for _, child in TextChatService:GetDescendants() do
		if child:IsA("TextSource") then
			if table.find(self.MutedPlayers, child.UserId) then
				child.CanSend = false
			else
				child.CanSend = true
			end
		end
	end
end

function Moderation:MutePlayer(player : Player, reason : string?, fromPlayer : Player?) : (boolean, string?)
	local success, err = pcall(function()
		if not table.find(self.MutedPlayers, player.UserId) then
			table.insert(self.MutedPlayers, player.UserId)
		end
		
		self.Client.PlayerMuted:Fire(player, true, reason)
		
		self:UpdateMutedPlayers()
		
		self:LogAction({Name = player.Name, Id = player.UserId}, {Name = ((fromPlayer and fromPlayer.Name) or ("System")), Id = fromPlayer and fromPlayer.UserId}, "Muted", reason)
	end)
	
	return success, err
end

function Moderation:UnmutePlayer(player : Player, reason : string?, fromPlayer : Player?) : (boolean, string?)
	local success, err = pcall(function()
		local findPlayer = table.find(self.MutedPlayers, player.UserId)
		
		if findPlayer then
			table.remove(self.MutedPlayers, findPlayer)
			
			self.Client.PlayerMuted:Fire(player, false)
		end
		
		self:UpdateMutedPlayers()
		
		self:LogAction({Name = player.Name, Id = player.UserId}, {Name = ((fromPlayer and fromPlayer.Name) or ("System")), Id = fromPlayer and fromPlayer.UserId}, "Unmuted", reason)
	end)
	
	return success, err
end

function Moderation:BanPlayer(userId : number, userBanning : string, msg : string?, bypassLogAction : boolean?) : (boolean, string?)
	local success, err = pcall(function()
		PlayerDataService:UpdateNormalDataWithUserId(userId, "BanData", true)
		
		local playerExists = Players:GetPlayerByUserId(userId)
		
		if playerExists then
			self:KickPlayer(playerExists, userBanning, msg, true)
		elseif bypassLogAction ~= false then
			local userName = Players:GetNameFromUserIdAsync(userId)
			
			self:LogAction({Name = userName, Id = userId}, {Name = userBanning or "System"}, "banned", msg)
		end
	end)
	
	return success, err
end

function Moderation:UnbanPlayer(userId : number, playerUnbanning : Player) : (boolean, string?)
	local success, err = pcall(function()
		PlayerDataService:UpdateNormalDataWithUserId(userId, "BanData", false)
		
		local userName = Players:GetNameFromUserIdAsync(userId)
		
		self:LogAction({Name = userName, Id = userId}, {Name = ((playerUnbanning and playerUnbanning.Name) or ("System"))}, "Unbanned")
	end)
	
	return success, err
end

function Moderation.Client:IsPlayerWhitelisted(player : Player, forCommand : string?) : boolean
	return self.Server:IsPlayerWhitelisted(player, forCommand)
end

function Moderation:OnPlayerAdded(player : Player)
	if table.find(self.Bans, player.UserId) or PlayerDataService:GetNormalData(player.UserId, "BanData") then
		player:Kick("You are currently banned from this game.")
	end
	
	self.PositionChecks[player] = {LastPos = nil, LastChange = 0, FailsWithinLimit = 0, Active = true}
end

function Moderation:OnPlayerRemoved(player : Player)
	if type(self.PositionChecks[player]) == "table" then
		self.PositionChecks[player].Active = false
	end
	
	task.delay(5, function()
		self.PositionChecks[player] = nil
	end)
end

function Moderation:KnitInit()
	PlayerDataService = Knit.GetService("PlayerDataService")
	CurrencyService = Knit.GetService("CurrencyService")
	InventoryService = Knit.GetService("InventoryService")
	ItemService = Knit.GetService("ItemService")
	
	--[[task.spawn(function()
		while task.wait(1) do
			for player, check in pairs(self.PositionChecks) do
				if not check or not check.Active then continue end
				
				local character = player.Character
				
				if character and character.Parent == workspace then
					local hrt = character:FindFirstChild("HumanoidRootPart")
					local currentChange = os.time()
					
					if hrt then
						local currentPos = hrt.Position
						
						if currentChange - check.LastChange >= 10 then
							check.FailsWithinLimit = 0
							check.LastChange = 0
						end
						
						if check.LastPos and check.LastPos ~= currentPos then
							check.FailsWithinLimit += 1
							
							if currentChange - check.LastChange >= 10 then
								check.LastChange = currentChange
							end
						end
						
						check.LastPos = hrt.Position
					else
						check.LastPos = nil
						check.LastChange = 0
						check.FailsWithinLimit = 0
					end
					
					if check.FailsWithinLimit >= 5 and player and player.Parent and character and character.Parent then
						self:KickPlayer(player, "Anti-Exploit", "Improper position; if you believe this to be an error, please report it")
						check.LastPos = nil
						check.LastChange = 0
						check.FailsWithinLimit = 0	
					end
				else
					check.LastPos = nil
					check.LastChange = 0
					check.FailsWithinLimit = 0
				end
			end
		end
	end)]]
	
	print(script.Name .. " initialized")
end

function Moderation:KnitStart()
	local Cmdr = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Cmdr"))

	Cmdr:RegisterDefaultCommands()
	Cmdr:RegisterCommandsIn(script.Commands)
	Cmdr:RegisterTypesIn(script.Types)
	Cmdr:RegisterHooksIn(script.Hooks)

	MessagingService:SubscribeAsync("Banned", function(message)
		if type(message.Data) ~= "table" then return end

		local findUser = tonumber(message.Data.BanUser)
		local sentByUser = message.Data.SentBy
		local reason = message.Data.Reason

		if findUser then		
			local doesPlayerExist = Players:GetPlayerByUserId(findUser)

			if doesPlayerExist then
				self:BanPlayer(doesPlayerExist.UserId, sentByUser, reason, false)
			end
		end
	end)
	
	TextChatService.DescendantAdded:Connect(function(child)
		if child:IsA("TextSource") then
			if table.find(self.MutedPlayers, child.UserId) then
				child.CanSend = false
			end
		end
	end)
	
	print(script.Name .. " started")
end

return Moderation