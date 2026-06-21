local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("Knit"))
local ModerationService = Knit.GetService("ModerationService")

return function(context, players, reason)
	if reason == "" then reason = nil end
	
	for _, player in pairs(players) do		
		ModerationService:UnmutePlayer(player, reason, context.Executor)
		context:Reply("Successfully muted " .. player.Name)
	end
	
	return ""
end