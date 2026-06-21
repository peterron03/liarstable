return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Hearts",
	Price = 2000,
	GamepassId = nil,
	Description = "How could you do this to me?",
	Image = "rbxassetid://93351018514785",
	Edition = "rbxassetid://72714430405195",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://9040277157",
		Volume = 0.3
	}
}