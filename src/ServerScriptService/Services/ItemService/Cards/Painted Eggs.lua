return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Eggs",
	Price = 250,
	GamepassId = nil,
	Description = "A sweet childhood memory, painted eggs on Easter morning.",
	Image = "rbxassetid://112255421150872",
	Edition = "rbxassetid://101888748237270",

	-- EXTRA DATA --
	Data = {}
}