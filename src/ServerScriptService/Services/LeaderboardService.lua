--[[
@TheAlmightyForehead
May 21st, 2024
Handles (almost) anything involving leaderboards
]]

-- ROBLOX SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local PlayerDataService
local CurrencyService
local ChatTagService
local InventoryService

-- MODULES --
local Utilities = ReplicatedStorage:WaitForChild("Utilities")
local Utils = require(Utilities:WaitForChild("Utils"))
local Settings = require(Utilities:WaitForChild("Settings"))

local Leaderboard = Knit.CreateService {
	Name = "LeaderboardService",

	LastSaved = {},
	LastLeaderboards = {},
	CachedCodes = {},
	LastTopPlayers = {},
	ValidTags = {
		"Wins",
		"GamesPlayed",
		"CardsPlayed"
	},

	Client = {
		LeaderboardUpdate = Knit.CreateSignal()
	}
}

function Leaderboard:GetFolder() : Folder
	if not self.MainFolder then
		self.MainFolder = script:FindFirstChild("Leaderboards") or Instance.new("Folder")
		self.MainFolder.Name = "LeaderboardService_Storage"
		self.MainFolder.Parent = workspace
	end

	return self.MainFolder
end

function Leaderboard:GetExample() : Frame
	return script:WaitForChild("MainExample"):Clone()
end

function Leaderboard:GetScrollingExample() : ScrollingFrame
	return script:WaitForChild("MainScrollingExample"):Clone()
end

function Leaderboard:GetCountryCode(player : Player) : string?
	local success, result = pcall(function()
		if player and player.UserId then
			local playerId = tostring(player.UserId)

			if playerId and not self.CachedCodes[playerId] then
				self.CachedCodes[playerId] = PlayerDataService:GetNormalData(tonumber(playerId), "CountryCode")
			end

			return self.CachedCodes[playerId]
		end
	end)

	if not success then
		warn(result)
	else
		return result
	end

	return nil
end

function Leaderboard.Client:GetCountryCode(player : Player, player2 : Player) : string?
	return self.Server:GetCountryCode(player2)
end

function Leaderboard:UpdateLeaderboard(leaderboardName : string)
	print("Attempting to update leaderboard " .. leaderboardName .. "...")

	local leaderboardPart = self.MainFolder and self.MainFolder:FindFirstChild(leaderboardName)
	local mainGui = leaderboardPart and leaderboardPart:FindFirstChildWhichIsA("SurfaceGui")
	local mainFrame = mainGui and mainGui:FindFirstChildWhichIsA("Frame")
	local mainLabel = mainFrame and mainFrame:FindFirstChildWhichIsA("TextLabel")
	local mainScrollFrame = mainGui and mainGui:FindFirstChildWhichIsA("ScrollingFrame")

	if mainScrollFrame and mainLabel then
		mainLabel.Text = leaderboardName

		local cashPage = PlayerDataService:GetOrderedData(leaderboardName, false, 50)

		if cashPage then
			local scrollExample = self:GetScrollingExample()
			local currentPage = cashPage:GetCurrentPage()
			local completePage = {}
			local newTopPlayers = {}

			if not self.LastTopPlayers[leaderboardName] then
				self.LastTopPlayers[leaderboardName] = {}
			end

			for i, v in pairs(currentPage) do
				local playerId = string.split(v.key, "_")[1]
				local value = v.value

				if tonumber(value) and tonumber(value) > 0 then
					if leaderboardName == "Distance" then
						value /= 100
					end

					local playerName = "Unknown"
					local countryEmoji = "❓"
					local textColor = Color3.fromRGB(190, 190, 190)

					if i == 1 then
						textColor = Color3.fromRGB(236, 189, 0)
					elseif i == 2 then
						textColor = Color3.fromRGB(225, 225, 225)
					elseif i == 3 then
						textColor = Color3.fromRGB(191, 116, 46)
					end

					if i <= 50 then
						newTopPlayers["#" .. i] = tonumber(playerId)
					end

					local success, err = pcall(function()
						playerName = Players:GetNameFromUserIdAsync(tonumber(playerId))

						if not self.CachedCodes[playerId] then
							self.CachedCodes[playerId] = PlayerDataService:GetNormalData(tonumber(playerId), "CountryCode")
						end

						countryEmoji = self.CachedCodes[playerId] and Utils.getCountryEmojiFromCode(self.CachedCodes[playerId])
					end)

					if not success then
						warn(err)
					end

					local newExample = self:GetExample()

					for _, v in pairs(newExample:GetChildren()) do
						if v:IsA("TextLabel") then
							v.TextColor3 = textColor
						end
					end

					newExample.Spot.Text = i
					newExample.Emoji.Text = countryEmoji or "❓"
					newExample.PlayerName.Text = playerName or "Unknown"
					newExample.Amount.Text = Utils.formatNumber(value, 1000)
					newExample.Name = i
					newExample.Parent = scrollExample

					completePage[i] = {CountryEmoji = countryEmoji or "❓", PlayerName = playerName or "Unknown", Value = Utils.formatNumber(value, 10000)}
				end
			end

			if table.find(self.ValidTags, leaderboardName) then
				local success, err = pcall(function()
					for i, v in pairs(self.LastTopPlayers[leaderboardName]) do
						if v.UserId and newTopPlayers["#" .. i] ~= v.UserId then
							local player = tonumber(v.UserId) and Players:GetPlayerByUserId(tonumber(v.UserId))

							if player then
								ChatTagService:RemoveTag(player, "#" .. i)
							end
						end
					end

					for i, v in pairs(newTopPlayers) do
						local split = string.split(i, "#")
						local index = split[2] and tonumber(split[2])
						local player = Players:GetPlayerByUserId(v)

						if index and player then
							self.LastTopPlayers[leaderboardName][index] = player

							local tags = ChatTagService:GetTags(player)
							local setTag = true

							if type(tags) == "table" then
								for _, tag in pairs(tags) do
									if type(tag) == "table" then
										if tag.Name and string.find(tag.Name, "#") then
											local tagSplit = string.split(tag.Name, "#")
											local tagIndex = tagSplit[2] and tonumber(tagSplit[2])

											if tagIndex then
												if tagIndex > index then
													ChatTagService:RemoveTag(player, tag.Name)
												else
													setTag = false
												end
											end
										end
									end
								end
							end

							if setTag then
								if not ChatTagService:DoesPlayerHaveTag(player, i) then
									ChatTagService:AddTag(player, i, Color3.fromRGB(215, 0, 0))
								end
							end
						end
					end
				end)

				if not success then
					warn(err)
				end
			end

			self.LastLeaderboards[leaderboardName] = completePage
			self.Client.LeaderboardUpdate:FireAll(leaderboardName, completePage)

			mainScrollFrame:Destroy()
			scrollExample.Parent = mainGui

			print("Successfully updated leaderboard " .. leaderboardName .. "!")
		end
	end
end

function Leaderboard:IsPlayerTop50(player : Player, leaderboardName : string) : boolean?
	local startTime = 0

	local pageName = leaderboardName .. "Page"

	repeat task.wait(1)
		startTime += 1	
	until self[pageName] or startTime > 15

	if self[pageName] then
		for _, v in pairs(self[pageName]) do
			local playerId = string.split(v.key, "_")[1]
			local val = v.value
			local toNumVal = val and tonumber(val)
			local toNum = playerId and tonumber(playerId)

			if toNum and toNumVal and toNumVal > 0 and player.UserId == toNum then
				return true
			end
		end
	end

	return false
end

function Leaderboard:GetLeaderboards(player : Player) : {Pages}
	return self.LastLeaderboards
end

function Leaderboard.Client:GetLeaderboards(player : Player) : {Pages}
	return self.Server:GetLeaderboards()
end

function Leaderboard:OnPlayerRemoved(player : Player)
	self.LastSaved[player] = nil
	self.CachedCodes[tostring(player.UserId)] = nil
end

function Leaderboard:OnPlayerAdded(player : Player)
	if type(self.LastTopPlayers) == "table" then
		local highestTag = nil

		for _, v in pairs(self.LastTopPlayers) do
			if type(v) == "table" then
				for i, v in pairs(v) do
					local userId = tonumber(v)

					if userId and userId == player.UserId then
						if not highestTag or highestTag > i then
							highestTag = i
						end
					end
				end
			end
		end

		if highestTag and not ChatTagService:DoesPlayerHaveTag(player, "#" .. highestTag) then
			ChatTagService:AddTag(player, "#" .. highestTag, Color3.fromRGB(215, 0, 0))
		end
	end
end

function Leaderboard:OnDataLoaded(player : Player, data : any)
	local countryCode = nil

	local success, err = pcall(function()
		countryCode = Utils.getCountryCode(player)
	end)

	if success and countryCode and type(countryCode) == "string" then
		PlayerDataService:UpdateNormalData(player, "CountryCode", countryCode)
		self.CachedCodes[tostring(player.UserId)] = countryCode
	else
		warn(err)
	end

	self.LastSaved[player] = os.time() - 60
end

function Leaderboard:KnitInit()
	PlayerDataService = Knit.GetService("PlayerDataService")
	CurrencyService = Knit.GetService("CurrencyService")
	ChatTagService = Knit.GetService("ChatTagService")
	InventoryService = Knit.GetService("InventoryService")

	CurrencyService.DataChanged:Connect(function(player, data)
		if type(data) == "table" and (self.LastSaved[player] and os.time() - self.LastSaved[player] >= 60) then
			if self.LastSaved[player] then
				self.LastSaved[player] = os.time()

				for currencyName, currencyAmount in pairs(data) do
					if self:GetFolder():FindFirstChild(currencyName) and player and player.Parent then
						PlayerDataService:UpdateOrderedData(player, currencyName, currencyAmount)
						task.wait(3)
					end
				end
			end
		end
	end)

	task.spawn(function()
		local cashPage = PlayerDataService:GetOrderedData("Beach Balls", false, 50)

		if cashPage then
			local success, err = pcall(function()
				local scrollExample = self:GetScrollingExample()
				self.EventPage = cashPage:GetCurrentPage()
			end)

			task.wait(15)
		end

		local firstTime = true

		while task.wait(5) do
			local folderChildren = self:GetFolder():GetChildren()

			if #folderChildren > 0 then
				for _, v in pairs(folderChildren) do
					self:UpdateLeaderboard(v.Name)

					if firstTime then
						task.wait(60/#folderChildren)
					else
						task.wait(120/#folderChildren)
					end
				end

				firstTime = false
			end
		end
	end)

	print(script.Name .. " initialized")
end

function Leaderboard:KnitStart()
	print(script.Name .. " started")
end

return Leaderboard