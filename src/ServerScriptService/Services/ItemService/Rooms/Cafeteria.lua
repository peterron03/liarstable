return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = 1392975725,
	Description = "Playin' cards in the cafeteria with some friends!",
	Image = "rbxassetid://127363725413927",

	-- EXTRA DATA --
	Data = {
		OnLoad = function(room : Model, ambienceVolume : number)
			print("Loading " .. script.Name)
			
			local SoundService = game:GetService("SoundService")
			local Lighting = game:GetService("Lighting")
			local currentTime = Lighting.ClockTime
			local currentAmbient = Lighting.Ambient
			local currentTime = DateTime.now().UnixTimestampMillis

			Lighting.ClockTime = 5
			Lighting.Ambient = Color3.fromRGB(95, 95, 95)
			
			for _, v in pairs(script.Sounds:GetChildren()) do
				if v:IsA("Sound") then
					local findSound = SoundService:FindFirstChild(script.Name .. "_" .. script.Parent.Name .. "_" .. v.Name)
					
					if not findSound then
						findSound = v:Clone()
						findSound.Name = script.Name .. "_" .. script.Parent.Name .. "_" .. v.Name .. "_" .. currentTime
						findSound.Parent = SoundService
					end
					
					findSound.Volume *= ambienceVolume
					findSound:Play()
				end
			end
			
			task.spawn(function()
				repeat task.wait() until not room or not room.Parent
				
				print("Unloading " .. script.Name)

				Lighting.ClockTime = currentTime
				Lighting.Ambient = currentAmbient

				for _, v in pairs(script.Sounds:GetChildren()) do
					if v:IsA("Sound") then
						local findSound = SoundService:FindFirstChild(script.Name .. "_" .. script.Parent.Name .. "_" .. v.Name .. "_" .. currentTime)

						if findSound then
							findSound:Stop()
						end
					end
				end
			end)
		end,
	}
}