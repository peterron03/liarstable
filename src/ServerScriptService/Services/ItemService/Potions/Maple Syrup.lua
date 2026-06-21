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
	Description = "This isn't from just any maple tree, this one's magical.",
	Image = "rbxassetid://121792306904821",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}