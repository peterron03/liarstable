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
	Description = "Be careful, this potion could easily burn you.",
	Image = "rbxassetid://103399795590318",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}