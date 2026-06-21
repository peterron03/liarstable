return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Peppermints",
	Price = 2000,
	GamepassId = nil,
	Description = "There's a surprising amount of snowmen coming to life in media.",
	Image = "rbxassetid://83087640421646",
	Edition = "rbxassetid://129805820847359",

	-- EXTRA DATA --
	Data = {}
}