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
	Description = "You can hunt all you want, but you need somethin' to put the eggs in!",
	Image = "rbxassetid://89656811487333",
	Edition = "rbxassetid://101888748237270",

	-- EXTRA DATA --
	Data = {}
}