local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local EmoteService = Knit.GetService("EmoteService")

return function(registry)
	registry:RegisterType("emotes", registry.Cmdr.Util.MakeEnumType("Emotes", EmoteService:GetEmoteNames()))
end