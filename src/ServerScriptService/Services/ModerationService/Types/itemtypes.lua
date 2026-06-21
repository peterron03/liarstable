local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local ItemService = Knit.GetService("ItemService")

return function(registry)
	registry:RegisterType("itemtypes", registry.Cmdr.Util.MakeEnumType("ItemTypes", ItemService:GetItemTypes()))
end