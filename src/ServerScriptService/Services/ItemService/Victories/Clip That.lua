return {
	-- OBJECT INFO --
	Name = script.Name,
	DisplayName = "Clip That!",
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "Ohh, Medal, clip that!",
	Image = "rbxassetid://77123040996683",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://128562972215222",
		Volume = 0.4
	}
}