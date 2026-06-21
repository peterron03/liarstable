return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Peppermints",
	Price = 250,
	GamepassId = nil,
	Description = "Ice cold and refreshing, but it's not even a liquid.",
	Image = "rbxassetid://89534677332974",
	Edition = "rbxassetid://129805820847359",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}