return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 250,
	GamepassId = nil,
	Description = "The sound of many, many dungeons.",
	Image = "rbxassetid://76523810555588",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://9064875317",
		Volume = 0.3
	}
}