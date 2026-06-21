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
	Description = "Pick a card, any card! Actually, just this one.",
	Image = "http://www.roblox.com/asset/?id=78315604623048",

	-- EXTRA DATA --
	Data = {}
}