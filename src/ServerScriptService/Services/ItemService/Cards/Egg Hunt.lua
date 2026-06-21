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
	Description = "Awarded for playing Egg Hunt Obby.",
	Image = "rbxassetid://106664667068490",
	--Edition = "rbxassetid://0000000000",

	-- EXTRA DATA --
	Data = {}
}