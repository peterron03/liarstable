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
	Description = "Wild and crazy, perfect for a late-night cards.",
	Image = "http://www.roblox.com/asset/?id=120289806542636",

	-- EXTRA DATA --
	Data = {}
}