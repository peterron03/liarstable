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
	Description = "Cartoon Victory Sound",
	Image = "rbxassetid://104307278027152",
	Edition = "rbxassetid://102287333654369",

	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://1844221634",
		Volume = 0.3
	}
}