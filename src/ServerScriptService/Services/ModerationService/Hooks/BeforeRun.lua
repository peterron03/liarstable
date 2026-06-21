local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("Knit"))
local ModerationService = Knit.GetService("ModerationService")

return function(registry)
	registry:RegisterHook("BeforeRun", function(context)
		if RunService:IsClient() then
			if not ModerationService:IsPlayerWhitelisted(context.Name) then
				return "You are not whitelisted."
			end
		elseif RunService:IsServer() then
			if not ModerationService:IsPlayerWhitelisted(context.Executor, context.Name) then
				return "You are not whitelisted."
			end
		else
			return "Unknown error; try again"
		end
	end)
end