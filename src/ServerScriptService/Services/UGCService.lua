--[[
@TheAlmightyForehead
August 11th, 2025
This handles stuff involving UGC in the shop, etc
]]

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local PlayerDataService
local CurrencyService
local InventoryService

-- UTILITIES --
local Utilities = ReplicatedStorage:WaitForChild("Utilities")
local Utils = require(Utilities:WaitForChild("Utils"))
local ProductIds = require(Utilities:WaitForChild("ProductIds"))

local UGC = Knit.CreateService {
	Name = "UGCService",
	Client = {}
}

function UGC:AwardPrizes(player : Player, specific : string?)
	if not InventoryService:FindItem(player, "Cards", "Liar's King") and specific ~= "Currency" then
		InventoryService:AddItem(player, "Cards", "Liar's King")
	end
	
	if not InventoryService:FindItem(player, "Victories", "Evil Laugh") and specific ~= "Currency" then
		InventoryService:AddItem(player, "Victories", "Evil Laugh")
	end
	
	if not PlayerDataService:GetValue(player, "UGC_Prizes_1") then
		PlayerDataService:SetValue(player, "UGC_Prizes_1", true)
		
		if specific ~= "Inventory" then
			CurrencyService:Add(player, "Cash", 250)
		end
	end
end

function UGC:HandleOnJoin(player : Player, loadType : string)
	local success, err = pcall(function()
		if MarketplaceService:PlayerOwnsAsset(player, 105568933118675) or MarketplaceService:PlayerOwnsAsset(player, 126471417363502) then
			self:AwardPrizes(player, loadType)
		end
	end)
	
	if not success then warn(err) end
end

function UGC:CurrencyDataLoaded(player : Player)
	self:HandleOnJoin(player, "Currency")
end

function UGC:InventoryDataLoaded(player : Player)
	self:HandleOnJoin(player, "Inventory")
end

function UGC:KnitInit()
	CurrencyService = Knit.GetService("CurrencyService")
	InventoryService = Knit.GetService("InventoryService")
	PlayerDataService = Knit.GetService("PlayerDataService")
	
	MarketplaceService.PromptPurchaseFinished:Connect(function(player : Player, assetId : number, isPurchased : boolean)
		if not isPurchased then return end
		
		if assetId == 126471417363502 or assetId == 105568933118675 then
			self:AwardPrizes(player)
		end
	end)
	
	print(script.Name .. " initialized")
end

function UGC:KnitStart()
	print(script.Name .. " started")
end

return UGC