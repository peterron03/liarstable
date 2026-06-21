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
	Description = "Is a can too small for you? Take a sip, or more, out of this!",
	Image = "rbxassetid://124011483565701",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}