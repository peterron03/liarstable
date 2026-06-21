return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Peppermints",
	Price = 5000,
	GamepassId = nil,
	Description = "Hey! You're not supposed to drink the stuff inside the globe.",
	Image = "rbxassetid://76188473723561",
	Edition = "rbxassetid://129805820847359",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}