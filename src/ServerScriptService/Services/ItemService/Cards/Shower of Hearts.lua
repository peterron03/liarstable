return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Hearts",
	Price = 750,
	GamepassId = nil,
	Description = "Covered in everything good, specifically hearts.",
	Image = "rbxassetid://91319422550429",
	Edition = "rbxassetid://72714430405195",

	-- EXTRA DATA --
	Data = {}
}