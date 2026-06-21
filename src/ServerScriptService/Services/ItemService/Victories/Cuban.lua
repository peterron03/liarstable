return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 750,
	GamepassId = nil,
	Description = "Listen to the sound of the drums as you march to victory!",
	Image = "rbxassetid://116110427060886",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://1841252719",
		Volume = 0.3
	}
}