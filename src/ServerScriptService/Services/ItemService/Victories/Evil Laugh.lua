return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "mwahahahheheahhehahahaha",
	Image = "rbxassetid://137078079001125",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://126928771109856",
		Volume = 0.3
	}
}