return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Beach Balls",
	Price = 250,
	GamepassId = nil,
	Description = "Satisfaction Victory Sound",
	Image = "rbxassetid://73151427956359",
	Edition = "rbxassetid://102287333654369",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://5153735602",
		Volume = 0.3
	}
}