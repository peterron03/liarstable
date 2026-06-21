local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Utils = require(ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utils"))
local Knit = require(Packages:WaitForChild("Knit"))
local GameplayService = Knit.GetService("GameplayService")

return function(context)
	local pTable, participant = GameplayService:FindTableWithPlayer(context.Executor)
	
	if pTable then
		GameplayService:EndGame(pTable)
	end
	
	return "Successfully attempted to end the game."
end