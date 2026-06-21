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
	Description = "It's like ketchup, but worse. Yeah, I'm a mustard hater.",
	Image = "rbxassetid://132261540254944",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}