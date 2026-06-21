return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 2000,
	GamepassId = nil,
	Description = "A refreshing, all-purpose potion for physical activity.",
	Image = "rbxassetid://135830346565183",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}