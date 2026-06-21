return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Eggs",
	Price = 750,
	GamepassId = nil,
	Description = "Bouncin' around the room!",
	Image = "rbxassetid://93928689773805",
	Edition = "rbxassetid://101888748237270",

	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://6075441854",
		Volume = 0.3
	}
}