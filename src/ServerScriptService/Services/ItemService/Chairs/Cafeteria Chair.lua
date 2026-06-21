return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = nil,
	Price = 0,
	GamepassId = nil,
	Description = "",

	-- EXTRA DATA --
	Data = {}
}