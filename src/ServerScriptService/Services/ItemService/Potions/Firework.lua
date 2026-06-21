return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1289866102, 1293485134},
	Description = "WARNING: Drinking it might cause it to explode in your face.",
	Image = "rbxassetid://91864869819065",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}