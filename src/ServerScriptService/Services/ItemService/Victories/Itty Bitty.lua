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
	Description = "Quick, simple, but efficient.",
	Image = "rbxassetid://97299096124478",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://7464806648",
		Volume = 0.3
	}
}