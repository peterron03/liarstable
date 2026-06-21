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
	Description = "Get a little extra kick when you play this card.",
	Image = "http://www.roblox.com/asset/?id=99087917794253",

	-- EXTRA DATA --
	Data = {}
}