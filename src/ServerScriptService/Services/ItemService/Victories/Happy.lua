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
	Description = "Top of the mornin' to you laddies!",
	Image = "rbxassetid://104390009067066",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://1899337607",
		Volume = 0.3
	}
}