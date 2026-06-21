return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Eggs",
	Price = 2000,
	GamepassId = nil,
	Description = "Let's have a party!",
	Image = "rbxassetid://102093584196357",
	Edition = "rbxassetid://101888748237270",

	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://102461175254500",
		Volume = 0.3
	}
}