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
	Description = "Back and forth, side to side, your opponent has no idea where you're going next.",
	Image = "http://www.roblox.com/asset/?id=92918716100127",

	-- EXTRA DATA --
	Data = {}
}