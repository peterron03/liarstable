local RunService = game:GetService("RunService")

return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 1500,
	GamepassId = nil,
	Description = "Speed up the game, shortening time limits for 120 seconds",

	-- EXTRA DATA --
	Data = {
		TimeLength = 120,
		
		BlacklistedBy = {},
		
		Load = function()
			return
		end,
		
		Unload = function()
			return
		end,
	}
}