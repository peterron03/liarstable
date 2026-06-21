--[[
@TheAlmightyForehead
May 7th, 2024
This handles (mostly) everything involving items
]]

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

local Item = Knit.CreateService {
	Name = "ItemService",
	Client = {}
}

-- TYPES --
export type item = {
	Name : string,
	Type : string,
	Model : any,
	ForSale : boolean,
	CurrencyType : string,
	Price : number,
	GamepassId : number,
	Data : {stat : string}
}

function Item:GetItemsFolder() : Folder
	if not self.ItemsFolder then
		self.ItemsFolder = Instance.new("Folder")
		self.ItemsFolder.Name = script.Name .. "_STORAGE"
		self.ItemsFolder.Parent = ReplicatedStorage

		for _, v in pairs(script:GetChildren()) do
			v.Parent = self.ItemsFolder
		end
		
		return self.ItemsFolder
	else
		return self.ItemsFolder
	end
end

function Item:GetItemTypes() : {itemType : string?}?
	local itemTypes = {}
	
	for _, itemTypeFolder in pairs(self:GetItemsFolder():GetChildren()) do
		if itemTypeFolder:IsA("Folder") then
			table.insert(itemTypes, itemTypeFolder.Name)
		end
	end
	
	return itemTypes
end

function Item:FindItem(itemType : string, itemName : string, itemTypeFolder : Folder?) : item?
	local itemTypeFolder = itemTypeFolder or self:GetItemsFolder():FindFirstChild(itemType)
	local itemModule = itemTypeFolder and itemTypeFolder:FindFirstChild(itemName)
	local item = itemModule and itemModule:IsA("ModuleScript") and require(itemModule)

	return item or nil
end

function Item:IsItemForSale(itemType : string, itemName : string) : boolean
	local item = self:FindItem(itemType, itemName)

	if item then
		return item.ForSale
	else
		return false
	end
end

function Item:GetItemData(itemType : string, itemName : string) : {stat : string}?
	local item = self:FindItem(itemType, itemName)

	if item then
		return item.Data
	else
		return nil
	end
end

function Item:GetAllItems(itemType : string, checkForSale : boolean?, isTableOverArray : boolean?) : {itemForSale : item?}?
	local itemTypeFolder = self:GetItemsFolder():FindFirstChild(itemType)

	if itemTypeFolder then
		local itemsForSale = {}

		for _, itemModule in pairs(itemTypeFolder:GetChildren()) do
			if itemModule:IsA("ModuleScript") then
				local item = require(itemModule)

				if item and (not checkForSale or item.ForSale) then
					if not isTableOverArray then
						table.insert(itemsForSale, item)
					else
						itemsForSale[item.Name] = item
					end
				end
			end
		end

		return itemsForSale
	else
		return nil
	end
end

function Item:GetNextAffordableItem(itemType : string, price : number, currency : string?) : item?
	local nextItem = nil
	local allItems = self:GetAllItems(itemType, true)

	if allItems then
		for _, item in pairs(allItems) do
			if (not currency or item.CurrencyType == currency) and (item.Price < price) and (not nextItem or nextItem.Price < item.Price) then
				nextItem = item
			end
		end
	end
	
	return nextItem or nil
end

function Item:GetArrayOfItems(itemType : string, items : {itemName : string}) : {item : item?}?
	local itemTypeFolder = self:GetItemsFolder():FindFirstChild(itemType)
	local arrayOfItems = {}
	
	if itemTypeFolder then
		local itemsFound = {}
		
		for _, v in pairs(items) do
			local alreadyFound = table.find(itemsFound, v)
			
			if alreadyFound then
				table.insert(arrayOfItems, alreadyFound)
			else
				local findItem = self:FindItem(itemType, v, itemTypeFolder)
				
				if findItem then
					table.insert(arrayOfItems, findItem)
					itemsFound[v] = findItem
				end
			end
		end
	end
	
	return arrayOfItems
end

function Item.Client:GetItemsFolder(player : Player) : Folder?
	return self.Server:GetItemsFolder()
end

function Item.Client:GetItemTypes(player : Player) : {itemType : string?}?
	return self.Server:GetItemTypes()
end

function Item.Client:FindItem(player : Player, itemType : string, itemName : string) : item?
	return self.Server:FindItem(itemType, itemName)
end

function Item.Client:GetItemData(player : Player, itemType : string, itemName : string) : {stat : string}
	return self.Server:GetItemData(itemType, itemName)
end

function Item.Client:IsItemForSale(player : Player, itemType : string, itemName : string) : boolean
	return self.Server:IsItemForSale(itemType, itemName)
end

function Item.Client:GetAllItems(player : Player, itemType : string, checkForSale : boolean?, isTableOverArray : boolean?) : {itemForSale : item}
	return self.Server:GetAllItems(itemType, checkForSale, isTableOverArray)
end

function Item.Client:GetNextAffordableItem(player : Player, itemType : string, price : number, currency : string?) : item?
	return self.Server:GetNextAffordableItem(itemType, price, currency)
end

function Item.Client:GetArrayOfItems(player : Player, itemType : string, items : {itemName : string}) : {item : item?}?
	return self.Server:GetArrayOfItems(itemType, items)
end

function Item:KnitInit()
	print(script.Name .. " initialized")
end

function Item:KnitStart()
	print(script.Name .. " started")
end

return Item