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
	Description = "Paint the room with these colorful cards.",
	Image = "http://www.roblox.com/asset/?id=107508339246137",

	-- EXTRA DATA --
	Data = {}
}