local RunService = game:GetService("RunService")

return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 900,
	GamepassId = nil,
	Description = "Add fog around the table for 60 seconds",

	-- EXTRA DATA --
	Data = {
		TimeLength = 60,
		
		BlacklistedBy = {},
		
		Load = function()
			if RunService:IsServer() then return end
			
			local Lighting = game:GetService("Lighting")
			local Atmosphere = Lighting:FindFirstChild("Atmosphere")
			
			if Atmosphere then
				Atmosphere.Density = 0.9
				Atmosphere.Offset = 1
			end
		end,
		
		Unload = function()
			if RunService:IsServer() then return end
			
			local Lighting = game:GetService("Lighting")
			local Atmosphere = Lighting:FindFirstChild("Atmosphere")

			if Atmosphere then
				Atmosphere.Density = 0.3
				Atmosphere.Offset = 0.25
			end
		end,
	}
}