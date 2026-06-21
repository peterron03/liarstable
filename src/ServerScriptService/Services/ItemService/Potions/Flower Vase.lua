return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 2000,
	GamepassId = nil,
	Description = "It can hold the most beautiful flowers and the most outrageous potions.",
	Image = "rbxassetid://130753774216316",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}