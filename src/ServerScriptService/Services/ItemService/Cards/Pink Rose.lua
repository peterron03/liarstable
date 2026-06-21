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
	Description = "Roses are pink, violets are purple- wait, I don't think that's how it goes...",
	Image = "rbxassetid://80158642054914",

	-- EXTRA DATA --
	Data = {}
}