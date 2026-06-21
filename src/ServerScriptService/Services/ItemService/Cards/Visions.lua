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
	Description = "I see into your future... it's quite victorious.",
	Image = "http://www.roblox.com/asset/?id=129473847288616",

	-- EXTRA DATA --
	Data = {}
}