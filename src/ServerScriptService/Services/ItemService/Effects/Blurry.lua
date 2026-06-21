local RunService = game:GetService("RunService")

return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 450,
	GamepassId = nil,
	Description = "Slightly blur everyone's screen for 90 seconds",

	-- EXTRA DATA --
	Data = {
		TimeLength = 90,
		
		BlacklistedBy = {},
		
		Load = function()
			if RunService:IsServer() then return end
			
			local Lighting = game:GetService("Lighting")
			local BlurEffect = Lighting:FindFirstChild("EFFECT_BLUR")
			
			if not BlurEffect then
				BlurEffect = Instance.new("BlurEffect")
				BlurEffect.Name = "EFFECT_BLUR"
				BlurEffect.Size = 10
				BlurEffect.Parent = Lighting
			end
			
			BlurEffect.Enabled = true
		end,
		
		Unload = function()
			if RunService:IsServer() then return end
			
			local Lighting = game:GetService("Lighting")
			local BlurEffect = Lighting:FindFirstChild("EFFECT_BLUR")
			
			if BlurEffect then
				BlurEffect.Enabled = false
			end
		end,
	}
}