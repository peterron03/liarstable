local SoundService = game:GetService("SoundService")

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
	Description = "",

	-- EXTRA DATA --
	Data = { 
		AnimationId = 94996855209000,
		
		Markers = {
			["SLEEP_PARTICLE_EMIT"] = function(player : Player, character : Model, ambienceSlider : number)
				local emitter = script:FindFirstChildWhichIsA("ParticleEmitter")
				local sleepSound = script:FindFirstChild("Sleep")
				
				local characterHead = character and character:FindFirstChild("Head")

				if characterHead then
					if emitter then
						local headEmitter = characterHead:FindFirstChild("SLEEP_PARTICLE_EMITTER")
						
						if not headEmitter then
							headEmitter = emitter:Clone()
							headEmitter.Enabled = true
							headEmitter.Name = "SLEEP_PARTICLE_EMITTER"
							headEmitter.Parent = characterHead	
						end
					end
					
					if sleepSound then
						local headSleep = characterHead:FindFirstChild("SLEEP_SOUND")
						
						if not headSleep then
							headSleep = sleepSound:Clone()
							headSleep.Looped = true
							headSleep.Name = "SLEEP_SOUND"
							headSleep.Volume = 0.03 * ambienceSlider
							headSleep.Parent = characterHead
							headSleep:Play()
						end
					end
				end
			end,
		}
	}
}