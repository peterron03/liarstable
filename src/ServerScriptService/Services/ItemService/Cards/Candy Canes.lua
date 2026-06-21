return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Peppermints",
	Price = 250,
	GamepassId = nil,
	Description = "Don't eat too many - you'll crash out.",
	Image = "rbxassetid://73331514960048",
	Edition = "rbxassetid://129805820847359",

	-- EXTRA DATA --
	Data = {}
}