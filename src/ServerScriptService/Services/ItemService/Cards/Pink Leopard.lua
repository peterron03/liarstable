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
	Description = "Lie like nobody's watching; don't let 'em tell you what to do.",
	Image = "rbxassetid://112125240431682",

	-- EXTRA DATA --
	Data = {}
}