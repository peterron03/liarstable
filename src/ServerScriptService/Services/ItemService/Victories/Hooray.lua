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
	Description = "Yayyyyyy!",
	Image = "rbxassetid://85156993428497",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://75247400023234",
		Volume = 0.3
	}
}