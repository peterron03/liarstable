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
	Description = "Straight from Japan, these branches showcase peace of mind in the toughest situations.",
	Image = "rbxassetid://137485858588999",

	-- EXTRA DATA --
	Data = {}
}