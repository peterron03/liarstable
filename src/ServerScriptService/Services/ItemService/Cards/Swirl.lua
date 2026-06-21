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
	Description = "This card may give you a whole whirlpool of emotions.",
	Image = "http://www.roblox.com/asset/?id=120942658609461",

	-- EXTRA DATA --
	Data = {}
}