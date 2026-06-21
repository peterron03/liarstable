return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Eggs",
	Price = 5000,
	GamepassId = nil,
	Description = "The face of Easter; the bunny!",
	Image = "rbxassetid://135706502202042",
	Edition = "rbxassetid://101888748237270",

	-- EXTRA DATA --
	Data = {}
}