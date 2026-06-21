return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "Awarded for playing Tennis Serve Simulator.",
	Image = "rbxassetid://132384535294357",
	Edition = "rbxassetid://74062231811107",

	-- EXTRA DATA --
	Data = {}
}