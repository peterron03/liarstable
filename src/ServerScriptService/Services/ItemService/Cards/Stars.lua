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
	Description = "Shine bright like the night sky everytime you play these cards.",
	Image = "http://www.roblox.com/asset/?id=127556452836853",

	-- EXTRA DATA --
	Data = {}
}