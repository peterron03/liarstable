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
	Description = "Beans, beans, they're good for your heart. The more you eat them, the more you... fall asleep?",
	Image = "rbxassetid://136323242563554",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}