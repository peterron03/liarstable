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
	Description = "It takes a team to build this fortress of a sound.",
	Image = "rbxassetid://132899850407965",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://9068838386",
		Volume = 0.3
	}
}