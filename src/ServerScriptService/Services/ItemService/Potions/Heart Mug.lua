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
	Description = "Earned from getting top 50 in the Valentine's Event.",
	Image = "rbxassetid://78657833323376",
	Edition = "rbxassetid://116209092556578",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}