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
	Description = "Summer Holidays Victory Sound",
	Image = "rbxassetid://137589857538569",
	Edition = "rbxassetid://102287333654369",

	-- EXTRA DATA --
	Data = {
		SoundId = "rbxassetid://1844692516",
		Volume = 0.3
	}
}