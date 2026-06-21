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
	Description = "Awarded to those that have completed World 1 in Tennis Serve Simulator.",
	Image = "rbxassetid://111103451428536",
	Edition = "rbxassetid://74062231811107",

	-- EXTRA DATA --
	Data = {}
}