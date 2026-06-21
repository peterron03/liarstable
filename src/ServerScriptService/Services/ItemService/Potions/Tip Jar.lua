return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "Earned from playing Developer Donations.",
	Image = "rbxassetid://91049096479844",
	Edition = "rbxassetid://121444240676277",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}