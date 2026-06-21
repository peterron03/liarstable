return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 750,
	GamepassId = nil,
	Description = "You and your cards can both look pretty.",
	Image = "http://www.roblox.com/asset/?id=140565304350953",

	-- EXTRA DATA --
	Data = {}
}