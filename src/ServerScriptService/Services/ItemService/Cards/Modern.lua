return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 750,
	GamepassId = nil,
	Description = "Everything is being modernized these days, so why not do it with cards, too?",
	Image = "http://www.roblox.com/asset/?id=71534107878811",

	-- EXTRA DATA --
	Data = {}
}