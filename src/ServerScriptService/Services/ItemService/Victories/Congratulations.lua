return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Beach Balls",
	Price = 750,
	GamepassId = nil,
	Description = "Congratulations Victory Sound",
	Image = "rbxassetid://111536175722088",
	Edition = "rbxassetid://102287333654369",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://140994215",
		Volume = 0.3
	}
}