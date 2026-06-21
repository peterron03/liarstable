--[[
@TheAlmightyForehead
June 7th, 2024
This handles (mostly) anything involving pets on the server
]]

-- ROBLOX SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local CurrencyService
local InventoryService
local ShopService
local ItemService

-- MODULES --
local Utilities = ReplicatedStorage:WaitForChild("Utilities")
local Utils = require(Utilities:WaitForChild("Utils"))

local Pet = Knit.CreateService {
	Name = "PetService",
	
	MaximumPetsAllowed = 3,
	PlayerFolders = {},
	
	Client = {
		SystemMessage = Knit.CreateSignal(),
		EggHatched = Knit.CreateSignal()
	}
}

export type Item = {
	Name : string,
	Type : string,
	Model : any,
	ForSale : boolean,
	CurrencyType : string,
	Price : number,
	GamepassId : number,
	Rarity : string,
	Data : any?
}

function Pet:GetFolder() : Folder
	if not self.PetsFolder then
		self.PetsFolder = Instance.new("Folder")
		self.PetsFolder.Name = "PLAYER_PETS"
		self.PetsFolder.Parent = workspace
	end
	
	return self.PetsFolder
end

function Pet:GetPlayerFolder(player : Player) : Folder
	local PetsFolder = self:GetFolder()
	
	if not self.PlayerFolders[player] then
		self.PlayerFolders[player] = Instance.new("Folder")
		self.PlayerFolders[player].Name = player.UserId
		self.PlayerFolders[player].Parent = PetsFolder
	end
	
	return self.PlayerFolders[player]
end

function Pet:DestroyPlayerFolder(player : Player) : boolean
	local PetsFolder = self:GetFolder()
	
	if self.PlayerFolders[player] then
		self.PlayerFolders[player]:Destroy()
		self.PlayerFolders[player] = nil
		return true
	else
		return false
	end
end

function Pet:GetPetFromRarities(rarities : {rarity : number}, pets : {petName : string}?) : Item?
	local outOf = 0
	
	for index, weight in pairs(rarities) do
		outOf += rarities[index]
	end
	
	local randomNum = Random.new():NextNumber(0, outOf)
	local counter = 0
	local chosenRarity
	
	for rarity, weight in pairs(rarities) do
		counter += weight
		
		if randomNum <= counter then
			chosenRarity = rarity
			break
		end
	end
	
	local listOfPetsWithRarity = {}
	
	if pets then
		for _, v in pairs(pets) do
			local vPet = ItemService:FindItem("Pets", v)
			
			if vPet and vPet.Rarity == chosenRarity then
				table.insert(listOfPetsWithRarity, vPet)
			end
		end
	else
		for _, v in pairs(ItemService:GetAllItems("Pets")) do
			if v.Rarity == chosenRarity then
				table.insert(listOfPetsWithRarity, v)
			end
		end
	end
	
	if #listOfPetsWithRarity > 0 then
		return listOfPetsWithRarity[math.random(1, #listOfPetsWithRarity)]
	end
	
	return nil
end

function Pet:LoadEggs()
	local eggs = ItemService:GetAllItems("Eggs")
	
	if eggs then
		for _, v in pairs(eggs) do
			print(v.Name .. " Egg loaded")
		end
	end
end

function Pet:Equip(player : Player, petName : string)
	local playerFolder = self:GetPlayerFolder(player)
	local petItem = ItemService:FindItem("Pets", petName)
	local character = player.Character
	local hrt = character and character:FindFirstChild("HumanoidRootPart")
	local hrtCF = hrt and hrt.CFrame
	
	if playerFolder and type(petItem) == "table" and petItem.Model then
		local maxPetsAllowed = self.MaximumPetsAllowed
		
		if #playerFolder:GetChildren() < maxPetsAllowed then
			local newPet = petItem.Model:Clone()
			newPet.Name = petName
			newPet.PrimaryPart.CFrame = hrtCF or workspace.SpawnLocation.CFrame
			newPet.Parent = playerFolder
		else
			warn("Maximum pets already equipped.")
		end
	end
end

function Pet:Unequip(player : Player, petName : string)
	local playerFolder = self:GetPlayerFolder(player)
	local petObject = playerFolder and playerFolder:FindFirstChild(petName)
	
	if playerFolder and petObject then
		petObject:Destroy()
	else
		warn("Unable to find '" .. petName .. "' pet.")
	end
end

function Pet:ClearAll(player : Player)
	local playerFolder = self:GetPlayerFolder(player)
	
	if playerFolder then
		for _, v in pairs(playerFolder:GetChildren()) do
			v:Destroy()
		end
	end
end

function Pet:GetPetsWithName(player : Player, petName : string) : ({petName : string?}, {petName : string?})
	local equippedPets = InventoryService:GetEquipped(player, "Pets")
	local ownedPets = InventoryService:GetInventory(player, "Pets")
	local equippedPetsWithName = {}
	local ownedPetsWithName = {}

	for _, v in pairs(equippedPets) do
		if v == petName then
			table.insert(equippedPetsWithName, v)
		end
	end

	for _, v in pairs(ownedPets) do
		if v == petName then
			table.insert(ownedPetsWithName, v)
		end
	end
	
	return ownedPetsWithName, equippedPetsWithName
end

function Pet:GetRarityChancesForPlayer(player : Player, egg : Item) : {chance : number?}?
	local success, result = pcall(function()
		if player and type(egg) == "table" and type(egg.Data) == "table" and egg.Data.Chances then
			local eggChances = {}

			for index, rarity in pairs(egg.Data.Chances) do
				eggChances[index] = rarity
				-- do stuff with rarities for luck if needed
			end
			
			return eggChances
		else
			return nil
		end
	end)
	
	if success then
		return result
	else
		warn(result)
		return nil
	end
end

function Pet:AttemptHatch(player : Player, eggName : string, fireEvent : boolean?, forceHatch : boolean?) : (boolean?, string? | Item?)
	local success, result = pcall(function()
		local egg : Item = ItemService:FindItem("Eggs", eggName)
		local ownedPets = InventoryService:GetInventory(player, "Pets")
		
		if egg then
			if (forceHatch) or (ownedPets and #ownedPets < 100) then
				local eggChances = self:GetRarityChancesForPlayer(player, egg)

				if eggChances then
					local pet = self:GetPetFromRarities(eggChances, egg.Data.Pets)
					
					if pet then
						if not forceHatch and egg.CurrencyType == "Robux" then
							if egg.GamepassId then
								MarketplaceService:PromptProductPurchase(player, egg.GamepassId)
								return {true}
							else
								return {false, "Product Id not found."}
							end
						elseif forceHatch or CurrencyService:CanPlayerAfford(player, egg.CurrencyType, egg.Price) then
							if not forceHatch then
								CurrencyService:Subtract(player, egg.CurrencyType, egg.Price)
							end
							
							InventoryService:AddItem(player, "Pets", pet.Name)
							CurrencyService:Add(player, "EggsHatched", 1)
							
							self.Client.SystemMessage:FireAll(player.Name, pet, egg)
							
							if fireEvent then
								self.Client.EggHatched:Fire(player, pet, egg)
							end
							
							return {true, pet}
						else
							return {false, "Insufficient funds."}
						end
					else
						return {false, "Unable to find pet."}
					end
				else
					return {false, "Egg chances not found."}
				end
			else
				return {false, "Maximum pets owned."}
			end
		else
			return {false, "Egg not found."}
		end
	end)
	
	if success then
		if type(result) == "table" then
			return table.unpack(result)
		end
	else
		warn(result)
	end
	
	return false, "Error while handling egg hatch."
end

function Pet:AttemptSell(player : Player, petName : string, attemptType : string?) : (boolean?, string?)
	local ownedPetsWithName, equippedPetsWithName = self:GetPetsWithName(player, petName)
	local priceOfPet = tonumber(self:GetPriceOfPet(petName))
	
	if #ownedPetsWithName > 0 and priceOfPet then
		InventoryService:RemoveItem(player, "Pets", petName)
		
		if #equippedPetsWithName >= #ownedPetsWithName or attemptType == "Unequip" then
			InventoryService:UnequipItem(player, "Pets", petName)
		end
		
		CurrencyService:Add(player, "Gems", priceOfPet)
		CurrencyService:Add(player, "TotalGems", priceOfPet)
		
		return true
	else
		return false, "Pet is not owned."
	end
end

function Pet:AttemptEquip(player : Player, petName : string, attemptType : string?) : (boolean?, string?)
	local equippedPets = InventoryService:GetEquipped(player, "Pets")
	local ownedPetsWithName, equippedPetsWithName = self:GetPetsWithName(player, petName)
	
	if #ownedPetsWithName > 0 then
		if #equippedPetsWithName < #ownedPetsWithName and attemptType ~= "Unequip" then
			local maxPetsAllowed = self.MaximumPetsAllowed
			
			if #equippedPets < maxPetsAllowed then
				InventoryService:EquipItem(player, "Pets", petName)
				return true
			else
				return false, "Maximum pets already equipped."
			end
		else
			InventoryService:UnequipItem(player, "Pets", petName)
			return true
		end
	else
		return false, "Pet is not owned."
	end
end

function Pet:GetPriceOfPet(petName : string) : number?
	local petItem = ItemService:FindItem("Pets", petName)
	
	if petItem then
		return petItem.Price
	else
		return nil
	end
end

function Pet.Client:AttemptHatch(player : Player, eggName : string) : (boolean?, string? | Item?)
	local success, result = self.Server:AttemptHatch(player, eggName)
	return success, result
end

function Pet.Client:AttemptSell(player : Player, petName : string, attemptType : string?) : (boolean?, string?)
	local success, result = self.Server:AttemptSell(player, petName, attemptType)
	return success, result
end

function Pet.Client:AttemptEquip(player : Player, petName : string, attemptType : string?) : (boolean?, string?)
	local success, result = self.Server:AttemptEquip(player, petName, attemptType)
	return success, result
end

function Pet.Client:GetPriceOfPet(player : Player, petName : string) : number?
	return self.Server:GetPriceOfPet(petName)
end

function Pet:OnPlayerRemoved(player : Player)
	self:DestroyPlayerFolder(player)
	
	task.delay(10, function()
		self:DestroyPlayerFolder(player)
	end)
end

function Pet:CurrencyDataLoaded(player : Player, data : any)
	CurrencyService:CreateCurrency(player, "EggsHatched")
end

function Pet:InventoryDataLoaded(player : Player, data : any)
	InventoryService:CreateInventory(player, "Pets", nil, true)
end

function Pet:KnitInit()
	CurrencyService = Knit.GetService("CurrencyService")
	InventoryService = Knit.GetService("InventoryService")
	ShopService = Knit.GetService("ShopService")
	ItemService = Knit.GetService("ItemService")
	
	InventoryService.ItemEquipped:Connect(function(player, itemType, itemName)
		if itemType == "Pets" then
			self:Equip(player, itemName)
		end
	end)
	
	InventoryService.ItemUnequipped:Connect(function(player, itemType, itemName)
		if itemType == "Pets" then
			self:Unequip(player, itemName)
		end
	end)
	
	self:GetFolder()
	self:LoadEggs()

	print(script.Name .. " initialized")
end

function Pet:KnitStart()
	print(script.Name .. " started")
end

return Pet