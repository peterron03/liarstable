return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "You're feeling very, very sleepy... tick, tock, tick, tock.",
	Image = "rbxassetid://114668085558320",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}