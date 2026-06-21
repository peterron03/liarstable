return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Beach Balls",
	Price = 5000,
	GamepassId = nil,
	Description = "Villain Arc Victory Sound",
	Image = "rbxassetid://83933396232369",
	Edition = "rbxassetid://102287333654369",

	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://1835323400",
		Volume = 0.3
	}
}