return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1392903795, 1392975725},
	Description = "Ringgggggg, onto the next class!",
	Image = "rbxassetid://123766932843404",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://6728208287",
		Volume = 0.3
	}
}