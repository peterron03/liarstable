return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Eggs",
	Price = 250,
	GamepassId = nil,
	Description = "Nothing like the smell of fresh flowers in spring.",
	Image = "rbxassetid://81872179918531",
	Edition = "rbxassetid://101888748237270",

	-- EXTRA DATA --
	Data = {}
}