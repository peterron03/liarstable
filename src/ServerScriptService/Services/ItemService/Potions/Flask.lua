return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 250,
	GamepassId = nil,
	Description = "Drinking potions straight from the source.",
	Image = "rbxassetid://111860615955003",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}