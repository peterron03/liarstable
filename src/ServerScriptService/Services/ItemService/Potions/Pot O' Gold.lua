return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1092462911, 1089993462},
	Description = "You better be feelin' pretty lucky to try to take this one from me!",
	Image = "rbxassetid://137416362902138",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}