local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Utils = require(ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utils"))
local Knit = require(Packages:WaitForChild("Knit"))
local EmoteService = Knit.GetService("EmoteService")

return function(context, player, emoteName)
	EmoteService:PlayFromPlayer(player, emoteName)
	return "Played emote '" .. emoteName .. "' for " .. player.Name
end