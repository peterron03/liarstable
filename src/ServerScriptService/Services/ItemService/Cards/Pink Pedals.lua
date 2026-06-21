return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Hearts",
	Price = 2000,
	GamepassId = nil,
	Description = "Toss 'em everywhere you go, show the world your pretty pink pedals.",
	Image = "rbxassetid://78188640566380",
	Edition = "rbxassetid://72714430405195",

	-- EXTRA DATA --
	Data = {}
}