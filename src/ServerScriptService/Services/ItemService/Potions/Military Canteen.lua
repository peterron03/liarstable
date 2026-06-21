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
	Description = "Good for quick and easy hydration after a long day of training.",
	Image = "rbxassetid://124149176460682",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}