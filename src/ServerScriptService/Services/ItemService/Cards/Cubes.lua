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
	Description = "Technically they're squared because they're on a 2D card.",
	Image = "http://www.roblox.com/asset/?id=121405524265366",

	-- EXTRA DATA --
	Data = {}
}