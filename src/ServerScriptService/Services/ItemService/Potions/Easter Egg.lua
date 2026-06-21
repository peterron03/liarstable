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
	Description = "Egglicious potions, straight from the source.",
	Image = "rbxassetid://84899012086013",
	Edition = "rbxassetid://101888748237270",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}