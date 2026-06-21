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
	Description = "Awarded for playing BEDTIME.",
	Image = "rbxassetid://71022065169721",
	Edition = "rbxassetid://81302989662327",

	-- EXTRA DATA --
	Data = {}
}