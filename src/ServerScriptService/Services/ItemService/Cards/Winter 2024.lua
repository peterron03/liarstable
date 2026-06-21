return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Likes",
	Price = 0,
	GamepassId = nil,
	Description = "Cold as ice, both the card and the player.",
	Image = "rbxassetid://111311448198498",

	-- EXTRA DATA --
	Data = {}
}