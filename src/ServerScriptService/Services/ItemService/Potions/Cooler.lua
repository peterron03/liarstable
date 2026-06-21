return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Beach Balls",
	Price = 5000,
	GamepassId = nil,
	Description = script.Name .. script.Parent.Name,
	Image = "rbxassetid://124498044976579",
	Edition = "rbxassetid://102287333654369",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}