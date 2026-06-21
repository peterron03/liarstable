return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 750,
	GamepassId = nil,
	Description = "gg ez, better luck next time.",
	Image = "rbxassetid://71506116706849",
	
	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://7464917496",
		Volume = 0.3
	}
}