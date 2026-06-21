return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "Nothing like a morning hike through the mountains.",
	Image = "http://www.roblox.com/asset/?id=95208759051425",

	-- EXTRA DATA --
	Data = {}
}