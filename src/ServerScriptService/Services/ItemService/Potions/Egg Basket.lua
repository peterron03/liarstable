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
	Description = "Gotta find 'em all!",
	Image = "rbxassetid://97256767047513",
	Edition = "rbxassetid://101888748237270",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}