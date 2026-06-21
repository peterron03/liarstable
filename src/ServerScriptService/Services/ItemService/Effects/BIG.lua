local RunService = game:GetService("RunService")

return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 1000,
	GamepassId = nil,
	Description = "Make everyone's cards bigger for 90 seconds",

	-- EXTRA DATA --
	Data = {
		TimeLength = 90,
		
		BlacklistedBy = {},
		
		Load = function(participants)
			if RunService:IsServer() then return end
			
			for _, v in pairs(participants) do
				local player = v.Player
				local char = player.Character
				local cards = char and char:FindFirstChild("Cards")
				
				if cards then
					for _, card in pairs(cards:GetChildren()) do
						card.Size = Vector3.new(1.125, 0.005, 1.882)
					end
				end
			end
		end,
		
		Unload = function(participants)
			if RunService:IsServer() then return end
			
			for _, v in pairs(participants) do
				local player = v.Player
				local char = player.Character
				local cards = char and char:FindFirstChild("Cards")

				if cards then
					for _, card in pairs(cards:GetChildren()) do
						card.Size = Vector3.new(0.75, 0.003, 1.255)
					end
				end
			end
		end,
	}
}