return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1050014226, 1050692618},
	Description = "I'VE PLAYED THESE GAMES BEFORE!",
	Image = "rbxassetid://79215177393804",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://99660491142487",
		Volume = 0.3
	}
}