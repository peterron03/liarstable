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
	Description = "Does anyone know what's going on here? I sure don't.",
	Image = "http://www.roblox.com/asset/?id=79081835762105",

	-- EXTRA DATA --
	Data = {}
}