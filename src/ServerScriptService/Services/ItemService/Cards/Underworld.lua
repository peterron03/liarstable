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
	Description = "Lurking beneath the shadows, a mysterious opponent awaits your turn.",
	Image = "http://www.roblox.com/asset/?id=123522860893943",

	-- EXTRA DATA --
	Data = {}
}