return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "Cold as ice, both the card and the player.",
	Image = "http://www.roblox.com/asset/?id=127074614825302",

	-- EXTRA DATA --
	Data = {}
}