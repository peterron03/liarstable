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
	Description = "Simple, but efficient, a mix of 2 beautiful colors making nothing but art.",
	Image = "http://www.roblox.com/asset/?id=130360593600441",

	-- EXTRA DATA --
	Data = {}
}