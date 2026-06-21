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
	Description = "Humanity has been playing Liar's Table since the dawn of mankind.",
	Image = "rbxassetid://116478162268883",

	-- EXTRA DATA --
	Data = {}
}