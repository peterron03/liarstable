return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1133128351, 1132822716},
	Description = "YEOWCH!",
	Image = "rbxassetid://122649900434122",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://18526435865",
		Volume = 0.3
	}
}