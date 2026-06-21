return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Hearts",
	Price = 5000,
	GamepassId = nil,
	Description = "I must abide by Roblox's terms, so a description for an item like this is hard.",
	Image = "rbxassetid://78165661823064",
	Edition = "rbxassetid://72714430405195",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://9042063646",
		Volume = 0.3
	}
}