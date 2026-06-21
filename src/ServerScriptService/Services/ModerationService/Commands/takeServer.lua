local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("Knit"))
local InventoryService = Knit.GetService("InventoryService")
local ItemService = Knit.GetService("ItemService")

return function(context, players, itemType, itemName)
	for _, player in pairs(players) do
		if InventoryService:GetInventory(player, itemType) then
			if InventoryService:FindItem(player, itemType, itemName) then
				local success = InventoryService:RemoveItem(player, itemType, itemName)

				if success then
					if InventoryService:GetEquipped(player, itemType) == itemName then
						InventoryService:UnequipItem(player, itemType, itemName)
					end

					context:Reply("Successfully removed " .. itemName .. " from " .. player.Name .. "'s " .. itemType .. " Inventory!")
				else
					context:Reply("Possible error while trying to change " .. player.Name .. "'s " .. itemType .. " Inventory.")
				end
			else
				context:Reply(player.Name .. " does not own item.")
			end
		else
			local possibleChoice = string.upper(string.sub(itemType, 1, 1)) .. string.lower(string.sub(itemType, 2, #itemType))

			if not InventoryService:GetInventory(player, possibleChoice) then
				possibleChoice = nil
			end

			if not possibleChoice then
				possibleChoice = string.upper(string.sub(itemType, 1, 1)) .. string.lower(string.sub(itemType, 2, #itemType)) .. "s"

				if not InventoryService:GetInventory(player, possibleChoice) then
					possibleChoice = nil
				end
			end

			return "Unable to find '" .. itemType .. "'. " .. ((possibleChoice and "Did you mean '" .. possibleChoice .. "'?") or ("Keep in mind, all item types are case sensitive."))
		end
	end
	
	return ""
end