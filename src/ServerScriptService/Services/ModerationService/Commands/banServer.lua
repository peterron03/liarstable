local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("Knit"))
local ModerationService = Knit.GetService("ModerationService")

return function(context, userIds, reason)
	if reason == "" then reason = nil end
	
	for _, userId in pairs(userIds) do		
		MessagingService:PublishAsync("Banned", {BanUser = userId, SentBy = context.Executor.Name, Reason = reason})
		ModerationService:BanPlayer(userId, context.Executor.Name, reason, true)
		context:Reply("Successfully banned user " .. userId)
	end
	
	return ""
end