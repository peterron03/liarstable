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
	Description = "Oi bruv, would you like to sit down for a cuppa tea?",
	Image = "rbxassetid://108759505238892",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}