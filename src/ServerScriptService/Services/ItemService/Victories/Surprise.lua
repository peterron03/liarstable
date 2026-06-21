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
	Description = "An unexpected winner.",
	Image = "rbxassetid://84476706563012",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://2205327519",
		Volume = 0.3
	}
}