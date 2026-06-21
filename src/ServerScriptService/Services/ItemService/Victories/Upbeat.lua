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
	Description = "Congratulations, you win a new... victory sound?",
	Image = "rbxassetid://124054586776664",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://1837494327",
		Volume = 0.3
	}
}