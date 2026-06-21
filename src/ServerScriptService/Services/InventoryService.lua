--[[
@TheAlmightyForehead
March 18th, 2024
This service handles inventories
]]

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- DATA --
local InventoryDataName = "InventoryData_3"

-- KNIT SERVICES --
local PlayerDataService

local Inventory = Knit.CreateService {
	Name = "InventoryService",
	
	ItemAdded = Signal.new(),
	ItemRemoved = Signal.new(),
	ItemEquipped = Signal.new(),
	ItemUnequipped = Signal.new(),
	InventoryChanged = Signal.new(),
	DataChanged = Signal.new(),
	DataLoaded = Signal.new(),
	
	PlayerData = {},
	
	Client = {
		ItemAdded = Knit.CreateSignal(),
		ItemRemoved = Knit.CreateSignal(),
		ItemEquipped = Knit.CreateSignal(),
		ItemUnequipped = Knit.CreateSignal(),
		InventoryChanged = Knit.CreateSignal(),
		DataChanged = Knit.CreateSignal(),
		DataLoaded = Knit.CreateSignal()
	}
}

function Inventory:CreateInventory(player : Player, inventoryName : string, starterItem : string?, allowMultipleEquipped : boolean?)
	if not self.PlayerData[player] then return end
	
	if allowMultipleEquipped and type(self.PlayerData[player].Equipped[inventoryName]) ~= "table" then
		local currentEquipped = self.PlayerData[player].Equipped[inventoryName]
		
		self.PlayerData[player].Equipped[inventoryName] = {}
		
		if currentEquipped then
			table.insert(self.PlayerData[player].Equipped[inventoryName], currentEquipped)
		end
	elseif not allowMultipleEquipped and type(self.PlayerData[player].Equipped[inventoryName]) == "table" then
		self.PlayerData[player].Equipped[inventoryName] = starterItem
	end
	
	if not self.PlayerData[player].Inventories[inventoryName] then
		self.PlayerData[player].Inventories[inventoryName] = {}

		if starterItem then
			table.insert(self.PlayerData[player].Inventories[inventoryName], starterItem)
			
			if type(self.PlayerData[player].Equipped[inventoryName]) == "table" then
				table.insert(self.PlayerData[player].Equipped[inventoryName], starterItem)
			else
				self.PlayerData[player].Equipped[inventoryName] = starterItem
			end

			self.ItemEquipped:Fire(player, inventoryName, starterItem)
			self.ItemAdded:Fire(player, inventoryName, starterItem)
			--self.Client.ItemEquipped:Fire(player, inventoryName, starterItem)
			--self.Client.ItemAdded:Fire(player, inventoryName, starterItem)
		end

		self.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "InventoryCreated")
		self:SelfDataChanged(player, self.PlayerData[player], "InventoryCreated")
		self.DataChanged:Fire(player, self.PlayerData[player], "InventoryCreated")
		self.Client.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "InventoryCreated")
		self.Client.DataChanged:Fire(player, self.PlayerData[player], "InventoryCreated")
	end

	return Inventory.PlayerData[player]
end

function Inventory:DestroyInventory(player : Player, inventoryName : string)
	if not self.PlayerData[player] then return end
	
	local equippedItem = self:GetEquipped(player, inventoryName)
	
	if equippedItem then
		if type(equippedItem) == "table" then
			for _, v in pairs(equippedItem) do
				self:UnequipItem(player, inventoryName, v)
			end
		else
			self:UnequipItem(player, inventoryName, equippedItem)
		end
	end
	
	self.PlayerData[player].Inventories[inventoryName] = nil
	
	self:SelfDataChanged(player, self.PlayerData[player], "InventoryDestroyed")
	self.DataChanged:Fire(player, self.PlayerData[player], "InventoryDestroyed")
	self.Client.DataChanged:Fire(player, self.PlayerData[player], "InventoryDestroyed")

	return self.PlayerData[player]
end

function Inventory:ResetInventory(player : Player, inventoryName : string, starterItem : string?, allowMultipleEquipped : boolean?)
	if not self.PlayerData[player] then return end
	
	self:DestroyInventory(player, inventoryName)
	
	return self:CreateInventory(player, inventoryName, starterItem, allowMultipleEquipped)
end

function Inventory:IsItemEquipped(player : Player, inventoryName : string, itemName : string) : boolean
	if type(self.PlayerData[player].Equipped[inventoryName]) == "table" then
		return table.find(self.Player[player].Equipped[inventoryName], itemName) and true
	else
		return self.PlayerData[player].Equipped[inventoryName] == itemName
	end
end

function Inventory:GetData(player : Player)
	return self.PlayerData[player] or nil
end

function Inventory:GetInventory(player : Player, inventoryName : string)
	return (self.PlayerData[player] and self.PlayerData[player].Inventories[inventoryName]) or nil
end

function Inventory:FindItem(player : Player, inventoryName : string, itemName : string) : number?
	if self.PlayerData[player].Inventories[inventoryName] then
		return table.find(self.PlayerData[player].Inventories[inventoryName], itemName)
	else
		return nil
	end
end

function Inventory:AddItem(player : Player, inventoryName : string, itemName : string)
	if not self.PlayerData[player] then return end
	
	if not self.PlayerData[player].Inventories[inventoryName] then
		self.PlayerData[player].Inventories[inventoryName] = {}
	end

	table.insert(self.PlayerData[player].Inventories[inventoryName], itemName)

	self.ItemAdded:Fire(player, inventoryName, itemName)
	self.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "ItemAdded")
	self:SelfDataChanged(player, self.PlayerData[player], "ItemAdded")
	self.DataChanged:Fire(player, self.PlayerData[player], "ItemAdded")
	--self.Client.ItemAdded:Fire(player, inventoryName, itemName)
	self.Client.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "ItemAdded")
	self.Client.DataChanged:Fire(player, self.PlayerData[player], "ItemAdded")

	return self.PlayerData[player]
end

function Inventory:RemoveItem(player : Player, inventoryName : string, itemName : string)
	if not self.PlayerData[player] then return end
	
	if self.PlayerData[player].Inventories[inventoryName] then
		local findItem = table.find(self.PlayerData[player].Inventories[inventoryName], itemName)

		if findItem then
			table.remove(self.PlayerData[player].Inventories[inventoryName], findItem)

			self.ItemRemoved:Fire(player, inventoryName, itemName)
			self.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "ItemRemoved")
			self:SelfDataChanged(player, self.PlayerData[player], "ItemRemoved")
			self.DataChanged:Fire(player, self.PlayerData[player], "ItemRemoved")
			--self.Client.ItemRemoved:Fire(player, inventoryName, itemName)
			self.Client.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "ItemRemoved")
			self.Client.DataChanged:Fire(player, self.PlayerData[player], "ItemRemoved")
		end
	end

	return self.PlayerData[player]
end

function Inventory:GetEquipped(player : Player, inventoryName : string) : string
	return (self.PlayerData[player] and self.PlayerData[player].Equipped[inventoryName]) or nil
end

function Inventory:SetEquipped(player : Player, inventoryName : string, equipped : any)
	if not self.PlayerData[player] then return end
	
	self.PlayerData[player].Equipped[inventoryName] = equipped
	
	return self.PlayerData[player]
end

function Inventory:EquipItem(player : Player, inventoryName : string, itemName : string)
	if not self.PlayerData[player] then return end
	
	if not self:FindItem(player, inventoryName, itemName) then
		self:AddItem(player, inventoryName, itemName)
	end
	
	if type(self.PlayerData[player].Equipped[inventoryName]) == "table" then
		table.insert(self.PlayerData[player].Equipped[inventoryName], itemName)
	else
		self.PlayerData[player].Equipped[inventoryName] = itemName
	end

	self.ItemEquipped:Fire(player, inventoryName, itemName)
	self.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "ItemEquipped")
	self:SelfDataChanged(player, self.PlayerData[player], "ItemEquipped")
	self.DataChanged:Fire(player, self.PlayerData[player], "ItemEquipped")
	--self.Client.ItemEquipped:Fire(player, inventoryName, itemName)
	self.Client.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "ItemEquipped")
	self.Client.DataChanged:Fire(player, self.PlayerData[player], "ItemEquipped")

	return self.PlayerData[player]
end

function Inventory:UnequipItem(player : Player, inventoryName : string, itemName : string)
	if not self.PlayerData[player] then return end
	
	if type(self.PlayerData[player].Equipped[inventoryName]) == "table" then
		local index = table.find(self.PlayerData[player].Equipped[inventoryName], itemName)
		
		if index and tonumber(index) then
			table.remove(self.PlayerData[player].Equipped[inventoryName], index)
			
			self.ItemUnequipped:Fire(player, inventoryName, itemName)
			self.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "ItemUnequipped")
			self:SelfDataChanged(player, self.PlayerData[player], "ItemUnequipped")
			self.DataChanged:Fire(player, self.PlayerData[player], "ItemUnequipped")
			--self.Client.ItemUnequipped:Fire(player, inventoryName, itemName)
			self.Client.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "ItemUnequipped")
			self.Client.DataChanged:Fire(player, self.PlayerData[player], "ItemUnequipped")
		end
	elseif self.PlayerData[player].Equipped[inventoryName] == itemName then
		self.PlayerData[player].Equipped[inventoryName] = nil

		self.ItemUnequipped:Fire(player, inventoryName, itemName)
		self.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "ItemUnequipped")
		self:SelfDataChanged(player, self.PlayerData[player], "ItemUnequipped")
		self.DataChanged:Fire(player, self.PlayerData[player], "ItemUnequipped")
		--self.Client.ItemUnequipped:Fire(player, inventoryName, itemName)
		self.Client.InventoryChanged:Fire(player, inventoryName, self.PlayerData[player].Inventories[inventoryName], self.PlayerData[player].Equipped[inventoryName], "ItemUnequipped")
		self.Client.DataChanged:Fire(player, self.PlayerData[player], "ItemUnequipped")
	end

	return self.PlayerData[player]
end

function Inventory.Client:GetData(player : Player)
	return self.Server:GetData(player)
end

function Inventory.Client:IsItemEquipped(player : Player, inventoryName : string, itemName : string) : boolean
	return self.Server:IsItemEquipped(player, inventoryName, itemName)
end

function Inventory.Client:GetInventory(player : Player, inventoryName : string)
	return self.Server:GetInventory(player, inventoryName)
end

function Inventory.Client:FindItem(player : Player, inventoryName : string, itemName : string) : number
	return self.Server:FindItem(player, inventoryName, itemName)
end

function Inventory.Client:GetEquipped(player : Player, inventoryName : string) : string
	return self.Server:GetEquipped(player, inventoryName)
end

function Inventory:OnPlayerRemoved(player : Player)
	self.PlayerData[player] = nil
end

function Inventory:OnDataLoaded(player : Player, data : any)
	self.PlayerData[player] = data.Data[InventoryDataName] or {Inventories = {}, Equipped = {}}

	for invName, inv in pairs(self.PlayerData[player].Inventories) do
		self.InventoryChanged:Fire(player, invName, inv, self.PlayerData[player].Equipped[invName], "DataLoaded")
		self.Client.InventoryChanged:Fire(player, invName, inv, self.PlayerData[player].Equipped[invName], "DataLoaded")
	end

	for invName, equippedItem in pairs(self.PlayerData[player].Equipped) do
		if type(equippedItem) == "table" then
			for _, tableItem in pairs(equippedItem) do
				self.ItemEquipped:Fire(player, invName, tableItem)
				--self.Client.ItemEquipped:Fire(player, invName, tableItem)
			end
		else
			self.ItemEquipped:Fire(player, invName, equippedItem)
			--self.Client.ItemEquipped:Fire(player, invName, equippedItem)
		end
	end

	self.DataLoaded:Fire(player, self.PlayerData[player])
	self.Client.DataLoaded:Fire(player, self.PlayerData[player])
end

function Inventory:SelfDataChanged(player : Player, data : any)
	PlayerDataService:SetValue(player, InventoryDataName, data)
end

function Inventory:KnitInit()
	PlayerDataService = Knit.GetService("PlayerDataService")
	
	print(script.Name .. " initialized")
end

function Inventory:KnitStart()
	print(script.Name .. " started")
end

return Inventory