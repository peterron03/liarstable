return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "Brew some late-night potions for a good ole time at the tavern.",
	Image = "rbxassetid://86983534045186",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}