local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("Knit"))
local InventoryService = Knit.GetService("InventoryService")
local ItemService = Knit.GetService("ItemService")

return function(context, players, itemType, itemName)
	for _, player in pairs(players) do
		if InventoryService:GetInventory(player, itemType) then
			if not table.find(ItemService:GetItemTypes(), itemType) or ItemService:FindItem(itemType, itemName) then
				if InventoryService:FindItem(player, itemType, itemName) then
					local success = InventoryService:EquipItem(player, itemType, itemName)
					
					if success then
						context:Reply("Successfully equipped " .. itemName .. " for " .. player.Name .. "'s " .. itemType .. " Inventory!")
					else
						context:Reply("Possible error while trying to change " .. player.Name .. "'s " .. itemType .. " Inventory.")
					end
				else
					context:Reply(player.Name .. " doesn't own item.")
				end
			else
				local possibleChoice = string.upper(string.sub(itemName, 1, 1)) .. string.lower(string.sub(itemName, 2, #itemName))

				if not ItemService:FindItem(itemType, possibleChoice) then
					possibleChoice = nil
				end

				return "Unable to find '" .. itemName .. "'. " .. ((possibleChoice and "Did you mean '" .. possibleChoice .. "'?") or ("Keep in mind, all item names are case sensitive."))
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