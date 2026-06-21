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
	Description = "Ay, congratulations, it's a celebration!",
	Image = "rbxassetid://87875237202237",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://9067124098",
		Volume = 0.3
	}
}