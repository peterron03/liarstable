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
	Description = "Keep 'em quiet everytime you win.",
	Image = "rbxassetid://126637844383134",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://18554601050",
		Volume = 0.7
	}
}