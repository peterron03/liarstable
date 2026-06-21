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
	Description = "Don't try this at home. I repeat, do NOT drink from a fire extinguisher.",
	Image = "rbxassetid://119341444428707",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}