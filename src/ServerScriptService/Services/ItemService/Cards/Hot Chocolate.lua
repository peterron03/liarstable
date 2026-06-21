return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {987631826, 986457693},
	Description = "Hot and fresh, ready to be served.",
	Image = "rbxassetid://114638475541343",

	-- EXTRA DATA --
	Data = {}
}