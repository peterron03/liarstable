return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "1'm 21m9ly h3r3 70 9l4y 20m3 c4rd2, d0n'7 w0rry, hum4n.",
	Image = "rbxassetid://110669411064421",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://112322525039832", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://100972279909067", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://140662055655226", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://126697259312815", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://77929574529614", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://94410395730246", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://132230315705682", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://136957826209891", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://96433283695327", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://85318296393121", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://125965687355557", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://82363955741162", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://119739197679099", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://78138299236895", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://74757408643606", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://79891495487066", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://137673993420736", Volume = 0.2},
	}
}