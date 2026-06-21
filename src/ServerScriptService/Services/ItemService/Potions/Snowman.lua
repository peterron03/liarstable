return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Peppermints",
	Price = 2000,
	GamepassId = nil,
	Description = "They say the melted snow leaves a mysterious potion behind.",
	Image = "rbxassetid://114361881759152",
	Edition = "rbxassetid://129805820847359",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}