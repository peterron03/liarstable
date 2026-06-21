return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 750,
	GamepassId = nil,
	Description = "A small hint of nostalgia hits you everytime you see 'em.",
	Image = "rbxassetid://102673398739727",

	-- EXTRA DATA --
	Data = {}
}