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
	Description = "Winner, winner, chicken dinner!",
	Image = "rbxassetid://91534563436640",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://9041812129",
		Volume = 0.3
	}
}