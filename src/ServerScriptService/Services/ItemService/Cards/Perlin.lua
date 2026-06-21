return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 250,
	GamepassId = nil,
	Description = "These cards were made by and for only the most elite mathematicians.",
	Image = "http://www.roblox.com/asset/?id=78969718219835",

	-- EXTRA DATA --
	Data = {}
}