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
	Description = "A tiny potion of pure innocence... or is it?",
	Image = "rbxassetid://86393552284874",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}