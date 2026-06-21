return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Beach Balls",
	Price = 2000,
	GamepassId = nil,
	Description = "Hawaiian Victory Victory Sound",
	Image = "rbxassetid://79148041548645",
	Edition = "rbxassetid://102287333654369",

	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://1838898500",
		Volume = 0.3
	}
}