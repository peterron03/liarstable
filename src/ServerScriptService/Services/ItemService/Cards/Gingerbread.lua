return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Peppermints",
	Price = 750,
	GamepassId = nil,
	Description = "Do you know him? DO YOU!?!",
	Image = "rbxassetid://73913065998110",
	Edition = "rbxassetid://129805820847359",

	-- EXTRA DATA --
	Data = {}
}