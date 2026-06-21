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
	Description = "Everyone's had an experience with one of these at a school lunch. Unless you're not American, then I don't know.",
	Image = "rbxassetid://90319359936811",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}