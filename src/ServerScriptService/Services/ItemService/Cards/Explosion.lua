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
	Description = "Make a big explosion with these boomin' cards.",
	Image = "http://www.roblox.com/asset/?id=133748370008142",

	-- EXTRA DATA --
	Data = {}
}