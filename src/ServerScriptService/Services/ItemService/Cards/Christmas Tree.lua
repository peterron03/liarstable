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
	Description = "Light up the room and draw everyone's attention with ease.",
	Image = "rbxassetid://95263097184981",
	Edition = "rbxassetid://129805820847359",

	-- EXTRA DATA --
	Data = {}
}