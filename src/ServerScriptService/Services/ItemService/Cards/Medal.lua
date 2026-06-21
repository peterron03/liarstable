return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "Medal, clip this victory I'm about to get!",
	Image = "rbxassetid://132892238435587",
	Edition = "rbxassetid://128924771992355",

	-- EXTRA DATA --
	Data = {}
}