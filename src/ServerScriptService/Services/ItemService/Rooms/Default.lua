return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = nil,
	Price = 0,
	GamepassId = nil,
	Description = "Just your typical room for playin' cards.",
	Image = "rbxassetid://82967372401168",

	-- EXTRA DATA --
	Data = {
		OnLoad = function(room : Model, ambienceVolume : number)
			print("Loading " .. script.Name)
			
			local SoundService = game:GetService("SoundService")
			local Lighting = game:GetService("Lighting")
			local currentBrightness = Lighting.ColorCorrection.Brightness
			
			Lighting.ColorCorrection.Brightness = 0
			
			for _, v in pairs(script.Sounds:GetChildren()) do
				if v:IsA("Sound") then
					local findSound = SoundService:FindFirstChild(script.Name .. "_" .. script.Parent.Name .. "_" .. v.Name)
					
					if not findSound then
						findSound = v:Clone()
						findSound.Name = script.Name .. "_" .. script.Parent.Name .. "_" .. v.Name
						findSound.Parent = SoundService
					end
					
					findSound.Volume *= ambienceVolume
					findSound:Play()
				end
			end
			
			task.spawn(function()
				repeat task.wait() until not room or not room.Parent
				
				print("Unloading " .. script.Name)

				Lighting.ColorCorrection.Brightness = currentBrightness

				for _, v in pairs(script.Sounds:GetChildren()) do
					if v:IsA("Sound") then
						local findSound = SoundService:FindFirstChild(script.Name .. "_" .. script.Parent.Name .. "_" .. v.Name)

						if findSound then
							findSound:Stop()
						end
					end
				end
			end)
		end,
	}
}