return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1292129646, 1293485134},
	Description = "Sorry to disappoint, but they don't explode when played.",
	Image = "rbxassetid://86249151113632",

	-- EXTRA DATA --
	Data = {}
}