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
	Description = "Light up the night sky with this card.",
	Image = "rbxassetid://92831307174751",

	-- EXTRA DATA --
	Data = {}
}