return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 250,
	GamepassId = nil,
	Description = "Fizzy and sweet, with a little kick to keep you going.",
	Image = "rbxassetid://101606900947929",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}