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
	Description = "Nothin' like some local off-brand restaurant ketchup.",
	Image = "rbxassetid://76548288847001",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}