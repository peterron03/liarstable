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
	Description = "The cups are universal and the potions are out of this world.",
	Image = "rbxassetid://137910840675456",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}