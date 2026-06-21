return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "They say it's colored with the same dye that's used in Russo's hair.",
	Image = "rbxassetid://86453116319328",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}