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
	Description = "Time's ticking... and soon, you'll be drinking.",
	Image = "rbxassetid://107535840180105",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}