return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {986915274, 986457693},
	Description = "Nothing better than a cup of hot cocoa next to a fireplace in the winter.",
	Image = "rbxassetid://109585339664881",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}