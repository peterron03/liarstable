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
	Description = "Brings back good memories.",
	Image = "rbxassetid://119044050337139",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://12222253",
		Volume = 0.3
	}
}