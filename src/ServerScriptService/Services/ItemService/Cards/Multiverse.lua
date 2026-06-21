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
	Description = "So many possiblities, so many chances to win... and lose.",
	Image = "http://www.roblox.com/asset/?id=116891940883940",

	-- EXTRA DATA --
	Data = {}
}