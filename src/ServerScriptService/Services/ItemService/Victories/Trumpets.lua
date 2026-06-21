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
	Description = "Sound the trumpets, victory is ours!",
	Image = "rbxassetid://87770409201437",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://9056855787",
		Volume = 0.3
	}
}