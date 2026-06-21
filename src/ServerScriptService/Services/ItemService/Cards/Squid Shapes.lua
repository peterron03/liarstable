return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1050692618, 1050626913},
	Description = "I'VE PLAYED THESE CARDS BEFORE!",
	Image = "http://www.roblox.com/asset/?id=88360412583060",

	-- EXTRA DATA --
	Data = {}
}