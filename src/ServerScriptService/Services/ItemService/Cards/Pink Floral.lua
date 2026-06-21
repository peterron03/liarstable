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
	Description = "Yeah, yeah, I stole the name of another card and just added a color in front.",
	Image = "rbxassetid://78002170202784",

	-- EXTRA DATA --
	Data = {}
}