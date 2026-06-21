local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("Knit"))
local ModerationService = Knit.GetService("ModerationService")

return function(context, userId)
	ModerationService:UnbanPlayer(userId, context.Executor)
	return "Successfully unbanned user " .. userId
end