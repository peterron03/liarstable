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
	Description = "Don't drink too much - you'll get a brain freeze!",
	Image = "rbxassetid://127282558313264",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}