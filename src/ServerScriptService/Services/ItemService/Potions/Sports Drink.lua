return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 750,
	GamepassId = nil,
	Description = "Replenish your stamina (or lose it all) with this high-energy elixir.",
	Image = "rbxassetid://90028203623572",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}