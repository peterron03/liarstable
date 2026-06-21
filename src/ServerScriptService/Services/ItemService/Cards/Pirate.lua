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
	Description = "Arrrre you ready to play some cards?",
	Image = "http://www.roblox.com/asset/?id=84708696825606",

	-- EXTRA DATA --
	Data = {}
}