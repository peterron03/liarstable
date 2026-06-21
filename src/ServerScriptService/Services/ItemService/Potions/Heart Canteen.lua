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
	Description = "They say it's filled to the brim with nothing but pure love.",
	Image = "rbxassetid://72335127221566",
	Edition = "rbxassetid://72714430405195",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}