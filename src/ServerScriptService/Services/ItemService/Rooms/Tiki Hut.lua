return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Beach Balls",
	Price = 5000,
	GamepassId = nil,
	Description = "The game of Liar's Table goes back centuries, played by native Hawaiian tribes. Just kidding, that's completely made up.",
	Image = "rbxassetid://102643042500037",
	Edition = "rbxassetid://102287333654369",

	-- EXTRA DATA --
	Data = {
		OnLoad = function(room : Model, ambienceVolume : number)
			print("Loading " .. script.Name)

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
			end)
		end,
	}
}