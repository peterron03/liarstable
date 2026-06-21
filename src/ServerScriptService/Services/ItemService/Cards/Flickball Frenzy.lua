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
	Description = "Awarded for playing Flickball Frenzy.",
	Image = "rbxassetid://75930201728411",
	Edition = "rbxassetid://96658842981703",

	-- EXTRA DATA --
	Data = {}
}