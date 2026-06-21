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
	Description = "Broken cards won't stop the grind.",
	Image = "http://www.roblox.com/asset/?id=99372727211372",

	-- EXTRA DATA --
	Data = {}
}