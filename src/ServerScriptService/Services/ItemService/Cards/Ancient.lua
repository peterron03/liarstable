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
	Description = "An old relic that reveals the truth when the time is right.",
	Image = "http://www.roblox.com/asset/?id=135472811445484",

	-- EXTRA DATA --
	Data = {}
}