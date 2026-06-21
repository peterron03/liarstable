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
	Description = "Bloom with elegance, showing off your prettiest flowers to the world.",
	Image = "http://www.roblox.com/asset/?id=91119988462016",

	-- EXTRA DATA --
	Data = {}
}