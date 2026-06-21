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
	Description = "This was gonna be named 'Polka Dots', but I don't like how it's spelled.",
	Image = "http://www.roblox.com/asset/?id=122657162544424",

	-- EXTRA DATA --
	Data = {}
}