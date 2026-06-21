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
	Description = "Float like a butterfly, play cards like a bee!",
	Image = "http://www.roblox.com/asset/?id=76361506784118",

	-- EXTRA DATA --
	Data = {}
}