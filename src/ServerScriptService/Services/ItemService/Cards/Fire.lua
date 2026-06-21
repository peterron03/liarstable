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
	Description = "Hot as fire, both the card and the player.",
	Image = "http://www.roblox.com/asset/?id=126923098023380",

	-- EXTRA DATA --
	Data = {}
}