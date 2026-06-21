return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Hearts",
	Price = 5000,
	GamepassId = nil,
	Description = "Tasty and insanely satisfying, like the feeling of a warm hug.",
	Image = "rbxassetid://90507268561027",
	Edition = "rbxassetid://72714430405195",

	-- EXTRA DATA --
	Data = {}
}