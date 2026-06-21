return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = 986457693,
	Description = "A cozy night around the fire; some call it perfection.",
	Image = "rbxassetid://105864608093228",

	-- EXTRA DATA --
	Data = {
		OnLoad = function(room : Model, ambienceVolume : number)
			print("Loading " .. script.Name)
			
			local Lighting = game:GetService("Lighting")
			local currentBrightness = Lighting.ColorCorrection.Brightness

			Lighting.ColorCorrection.Brightness = -0.05
			
			local newMusic = script.Music:Clone()

			newMusic.Parent = room
			
			task.spawn(function()
				while room and room.Parent do
					for _, v in pairs(newMusic:GetChildren()) do
						if v:IsA("Sound") then
							if v.TimeLength ~= 0 then
								v.Volume = script.Music:FindFirstChild(v.Name).Volume * ambienceVolume
								v:Play()
								task.wait(v.TimeLength)
								v:Stop()
							end
						end
					end
					
					task.wait()
					
					if not room or not room.Parent then
						break
					end
				end
				
				print("Unloading " .. script.Name)
				
				Lighting.ColorCorrection.Brightness = currentBrightness
			end)
		end,
	}
}