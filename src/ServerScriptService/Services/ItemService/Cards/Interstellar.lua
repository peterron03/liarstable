return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 2000,
	GamepassId = nil,
	Description = "Just remember - whatever can happen, will happen.",
	Image = "http://www.roblox.com/asset/?id=122108779933232",

	-- EXTRA DATA --
	Data = {}
}