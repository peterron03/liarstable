return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Eggs",
	Price = 250,
	GamepassId = nil,
	Description = "It's time for spring!",
	Image = "rbxassetid://134361229761147",
	Edition = "rbxassetid://101888748237270",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://9038789620",
		Volume = 0.3
	}
}