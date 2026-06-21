return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Cash",
	Price = 0,
	GamepassId = nil,
	Description = "You're not cool enough for a special sound yet, sorry.",
	Image = "rbxassetid://71571426096520",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "",
		Volume = 0
	}
}