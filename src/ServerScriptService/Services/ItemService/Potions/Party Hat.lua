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
	Description = "We almost lost the game forever. That was a close one.",
	Image = "rbxassetid://119210189269396",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}