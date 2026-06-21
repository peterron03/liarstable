return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = {1461476052, 1461507873},
	Description = "Unfortunately, drinking this potion will not make you float like there's no gravity.",
	Image = "rbxassetid://94912337899543",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}