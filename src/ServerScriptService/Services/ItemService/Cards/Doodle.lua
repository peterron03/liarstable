return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1133252356, 1132822716},
	Description = "haha card.",
	Image = "rbxassetid://130752993741521",

	-- EXTRA DATA --
	Data = {}
}