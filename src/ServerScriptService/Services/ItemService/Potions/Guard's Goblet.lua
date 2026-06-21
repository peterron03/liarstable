return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1020473528, 1020817352},
	Description = "Nice and shiny, perfect for holding the most powerful potions the kingdom has to offer.",
	Image = "rbxassetid://99082809165521",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}