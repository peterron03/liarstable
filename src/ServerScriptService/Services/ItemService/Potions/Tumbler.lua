return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 2000,
	GamepassId = nil,
	Description = "On the go or at home, perfect for any potion at any time.",
	Image = "rbxassetid://72266207319461",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}