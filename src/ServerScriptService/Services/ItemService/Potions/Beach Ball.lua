return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Beach Balls",
	Price = 2000,
	GamepassId = nil,
	Description = script.Name .. script.Parent.Name,
	Image = "rbxassetid://103107793902139",
	Edition = "rbxassetid://102287333654369",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}