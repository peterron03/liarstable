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
	Description = "Awarded for playing Anvil Drop.",
	Image = "rbxassetid://101010708014313",
	Edition = "rbxassetid://129685609907201",

	-- EXTRA DATA --
	Data = {}
}