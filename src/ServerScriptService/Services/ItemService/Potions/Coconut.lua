return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "Don't be fooled by the topical look, this coconut was made in a lab.",
	Image = "rbxassetid://126087034665385",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}