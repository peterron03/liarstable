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
	Description = "Very loud and very proud!",
	Image = "rbxassetid://78102247890203",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://607548767",
		Volume = 0.3
	}
}