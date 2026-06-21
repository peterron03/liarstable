return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1392298046, 1392975725},
	Description = "Kinda gross, but you can drink out of a locker now, I guess.",
	Image = "rbxassetid://132061095231338",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}