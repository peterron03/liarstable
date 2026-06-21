return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1142318303, 1142109851},
	Description = "You can't line dance without a pair of these on.",
	Image = "rbxassetid://140144389356951",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}