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
	Description = "A little nerdy, but also charming.",
	Image = "rbxassetid://74986066412357",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://137490445727672", Volume = 0.7},
			[2] = {SoundId = "rbxassetid://107833319137975", Volume = 0.7},
			[3] = {SoundId = "rbxassetid://96420603229898", Volume = 0.7},
			[4] = {SoundId = "rbxassetid://129001266838222", Volume = 0.7},
			[5] = {SoundId = "rbxassetid://94023869993703", Volume = 0.7}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://127248237613818", Volume = 0.7},
			[2] = {SoundId = "rbxassetid://101606645693199", Volume = 0.7},
			[3] = {SoundId = "rbxassetid://135803996109232", Volume = 0.7},
			[4] = {SoundId = "rbxassetid://95041630512498", Volume = 0.7},
			[5] = {SoundId = "rbxassetid://115286074574134", Volume = 0.7}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://87946750583963", Volume = 0.7},
			[2] = {SoundId = "rbxassetid://139752032494347", Volume = 0.7},
			[3] = {SoundId = "rbxassetid://72739707155005", Volume = 0.7},
			[4] = {SoundId = "rbxassetid://81319978898160", Volume = 0.7},
			[5] = {SoundId = "rbxassetid://129569535793865", Volume = 0.7}
		},
		
		["Liar"] = {SoundId = "rbxassetid://113200576294225", Volume = 0.7},
		
		["Hmm"] = {SoundId = "rbxassetid://78448526025985", Volume = 2},
	}
}