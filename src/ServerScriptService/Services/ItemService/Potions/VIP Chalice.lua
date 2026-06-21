return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = 958606530,
	Description = "They say it was found on the Royal Merchant; it's value is priceless.",
	Image = "rbxassetid://114297754636326",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}