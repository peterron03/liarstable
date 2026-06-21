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
	Description = "Refuel after a long day of training.",
	Image = "rbxassetid://114585339469158",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}