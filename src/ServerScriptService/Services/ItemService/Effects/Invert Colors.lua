local RunService = game:GetService("RunService")

return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 800,
	GamepassId = nil,
	Description = "Make everything have inverted colors for 60 seconds",

	-- EXTRA DATA --
	Data = {
		TimeLength = 60,
		
		BlacklistedBy = {"Darkness", "Black & White"},
		
		Load = function()
			if RunService:IsServer() then return end
			
			local Lighting = game:GetService("Lighting")
			local Correction = Lighting:FindFirstChild("ColorCorrection")

			if Correction then
				Correction.Saturation = -2
			end
		end,

		Unload = function()
			if RunService:IsServer() then return end
			
			local Lighting = game:GetService("Lighting")
			local Correction = Lighting:FindFirstChild("ColorCorrection")

			if Correction then
				Correction.Saturation = 0
			end
		end,
	}
}