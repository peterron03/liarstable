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
	Description = "Order up! Your potion is ready.",
	Image = "rbxassetid://121123401976402",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}