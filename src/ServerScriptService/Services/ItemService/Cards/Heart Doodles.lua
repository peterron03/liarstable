return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Hearts",
	Price = 750,
	GamepassId = nil,
	Description = "I love to doodle, don't you?",
	Image = "rbxassetid://106577022512278",
	Edition = "rbxassetid://72714430405195",

	-- EXTRA DATA --
	Data = {}
}