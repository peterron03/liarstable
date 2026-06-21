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
	Description = "Master the art of card throwing and card playing.",
	Image = "http://www.roblox.com/asset/?id=114498284750534",

	-- EXTRA DATA --
	Data = {}
}