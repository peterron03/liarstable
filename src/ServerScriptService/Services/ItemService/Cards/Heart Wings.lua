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
	Description = "Fly high into the sky, like Cupid.",
	Image = "rbxassetid://79042452220224",
	Edition = "rbxassetid://72714430405195",

	-- EXTRA DATA --
	Data = {}
}