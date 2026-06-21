return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Hearts",
	Price = 2000,
	GamepassId = nil,
	Description = "It might look like a flower, but it sure doesn't taste like it.",
	Image = "rbxassetid://102016807884909",
	Edition = "rbxassetid://72714430405195",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}