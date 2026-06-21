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
	Description = "Up, up, and away into victory!",
	Image = "rbxassetid://96624991448788",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://990817803",
		Volume = 0.3
	}
}