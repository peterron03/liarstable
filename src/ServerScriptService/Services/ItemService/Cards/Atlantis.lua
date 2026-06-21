return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 2000,
	GamepassId = nil,
	Description = "Become the king of the sea, taking over Atlantis.",
	Image = "http://www.roblox.com/asset/?id=129179472883545",

	-- EXTRA DATA --
	Data = {}
}