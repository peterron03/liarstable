return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Eggs",
	Price = 2000,
	GamepassId = nil,
	Description = "QUAAAAAAAAAACK! It's Easter time!",
	Image = "rbxassetid://92198653738937",
	Edition = "rbxassetid://101888748237270",

	-- EXTRA DATA --
	Data = {}
}