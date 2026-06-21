return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Beach Balls",
	Price = 750,
	GamepassId = nil,
	Description = "Quack Quack Victory Sound",
	Image = "rbxassetid://90047011533530",
	Edition = "rbxassetid://102287333654369",

	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://1845384542",
		Volume = 0.3
	}
}