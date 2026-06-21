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
	Description = "You only want what you don't have, so why not have nothing? Then you want it all.",
	Image = "http://www.roblox.com/asset/?id=118438953523487",

	-- EXTRA DATA --
	Data = {}
}