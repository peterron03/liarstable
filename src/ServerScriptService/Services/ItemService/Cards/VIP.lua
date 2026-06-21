return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = 958606530,
	Description = "You. Yes, you. You're a very important person.",
	Image = "http://www.roblox.com/asset/?id=136213903042826",

	-- EXTRA DATA --
	Data = {}
}