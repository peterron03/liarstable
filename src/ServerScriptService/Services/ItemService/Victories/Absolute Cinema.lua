return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "An absolute masterpiece, some would say.",
	Image = "rbxassetid://123136207214075",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://1848140559",
		Volume = 0.3
	}
}