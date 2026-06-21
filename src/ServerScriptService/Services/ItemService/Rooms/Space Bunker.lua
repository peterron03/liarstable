return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = 1461476052,
	Description = "Even in space, everyone gets bored. The solution? A game of cards!",
	Image = "rbxassetid://113690824441137",

	-- EXTRA DATA --
	Data = {
		OnLoad = function(room : Model, ambienceVolume : number)
			print("Loading " .. script.Name)
			
			local SoundService = game:GetService("SoundService")
			local currentTime = DateTime.now().UnixTimestampMillis
			
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