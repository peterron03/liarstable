--[[
@TheAlmightyForehead
May 3rd, 2025
This handles the emotes players can use
]]

-- ROBLOX SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local ShopService

-- UTILITIES --
local Utilities = ReplicatedStorage:WaitForChild("Utilities")
local Utils = require(Utilities:WaitForChild("Utils"))
local Emotes = require(script.Emotes)

-- UI --
local ExampleGui = script:WaitForChild("ExampleGui")

-- TWEEN INFO --
local emoteTweenInfo = TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

local Emote = Knit.CreateService {
	Name = "EmoteService",
	
	GamepassId = 0000000000,
	
	Client = {
		EmotePlayed = Knit.CreateSignal()
	}
}

function Emote:Play(part : BasePart, emoteName : string)
	local emoteId = Emotes[emoteName]
	
	if emoteId and part then
		local newBillboard = ExampleGui:Clone()
		
		newBillboard.Size = UDim2.new(0.01, 0, 0.01, 0)
		newBillboard.StudsOffset = Vector3.new(0, 0, 0)
		newBillboard.ImageLabel.Image = emoteId
		newBillboard.Parent = part
		
		local newTween = TweenService:Create(newBillboard, emoteTweenInfo, {Size = UDim2.new(1.5, 0, 1.5, 0), StudsOffset = Vector3.new(0, 3, 0)})
		
		newTween:Play()
		
		task.delay(3, function()
			newBillboard:Destroy()
		end)
	end
end

function Emote:PlayFromPlayer(player : Player, emoteName : string)
	local character = player.Character
	local head = character and character:FindFirstChild("Head")

	if head then
		local newPart = Instance.new("Part")

		newPart.Size = Vector3.new(1, 1, 1)
		newPart.Transparency = 1
		newPart.Anchored = true
		newPart.CanCollide = false
		newPart.Position = head.Position
		newPart.Parent = workspace

		self:Play(newPart, emoteName)
		
		self.Client.EmotePlayed:Fire(player, emoteName, Emotes[emoteName])

		task.delay(5, function()
			newPart:Destroy()
		end)
	end
end

function Emote.Client:PlayFromPlayer(player : Player, emoteName : string)
	if not ShopService:UserOwnsGamePass(player, self.GamepassId) then return end
	return self.Server:PlayFromPlayer(player, emoteName)
end

function Emote:GetEmoteNames()
	local emoteList = {}
	
	for emoteName, _ in Emotes do
		table.insert(emoteList, emoteName)
	end
	
	return emoteList
end

function Emote.Client:GetEmoteNames()
	return self.Server:GetEmoteNames()
end

function Emote:KnitInit()
	ShopService = Knit.GetService("ShopService")
	
	print(script.Name .. " initialized")
end

function Emote:KnitStart()
	print(script.Name .. " started")
end

return Emote