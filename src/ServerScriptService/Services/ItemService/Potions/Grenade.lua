return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 750,
	GamepassId = nil,
	Description = "Get down... or drink up!",
	Image = "rbxassetid://88170001692888",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}