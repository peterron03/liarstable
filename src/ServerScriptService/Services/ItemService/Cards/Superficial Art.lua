return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 2000,
	GamepassId = nil,
	Description = "Some artists paint, others use a computer. Regardless, it turns out beautiful.",
	Image = "rbxassetid://110024097639751",

	-- EXTRA DATA --
	Data = {}
}