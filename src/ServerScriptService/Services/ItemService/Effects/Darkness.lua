local RunService = game:GetService("RunService")

return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 200,
	GamepassId = nil,
	Description = "Make the room slightly darker for 60 seconds",

	-- EXTRA DATA --
	Data = {
		TimeLength = 60,
		
		BlacklistedBy = {"Black & White", "Invert Colors"},
		
		Load = function()
			if RunService:IsServer() then return end
			
			local Lighting = game:GetService("Lighting")
			local ColorCorrection = Lighting:FindFirstChild("EFFECT_CORRECTION")

			if not ColorCorrection then
				ColorCorrection = Instance.new("ColorCorrectionEffect")
				ColorCorrection.Name = "EFFECT_CORRECTION"
				ColorCorrection.Brightness = 0
				ColorCorrection.Contrast = 0.2
				ColorCorrection.Saturation = 0.1
				ColorCorrection.TintColor = Color3.fromRGB(70, 70, 70)
				ColorCorrection.Parent = Lighting
			end

			ColorCorrection.Enabled = true
		end,
		
		Unload = function()
			if RunService:IsServer() then return end
			
			local Lighting = game:GetService("Lighting")
			local Correction = Lighting:FindFirstChild("EFFECT_CORRECTION")

			if Correction then
				Correction.Enabled = false
			end
		end,
	}
}