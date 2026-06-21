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
	Description = "It's literally a warning sign, and you're drinking out of it?",
	Image = "rbxassetid://117944298217087",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}