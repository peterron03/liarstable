return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Eggs",
	Price = 750,
	GamepassId = nil,
	Description = "Squishy like marshmallows. Not sure if you should eat the card, though.",
	Image = "rbxassetid://137514205250764",
	Edition = "rbxassetid://101888748237270",

	-- EXTRA DATA --
	Data = {}
}