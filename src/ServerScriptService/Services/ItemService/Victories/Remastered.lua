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
	Description = "An old sound, made good as new.",
	Image = "rbxassetid://77585340774667",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://6286482559",
		Volume = 0.3
	}
}