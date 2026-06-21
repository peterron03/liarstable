return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1142041975, 1142318303},
	Description = "YEEEEEEEEEEEEEEEHAWWW!",
	Image = "rbxassetid://93540405371664",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://117811460675345",
		Volume = 0.3
	}
}