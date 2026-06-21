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
	Description = "Sharp as a new blade, stings like an aggressive wasp.",
	Image = "http://www.roblox.com/asset/?id=97335462448923",

	-- EXTRA DATA --
	Data = {}
}