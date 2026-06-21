return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Cash",
	Price = 0,
	GamepassId = nil,
	Description = "Your average Joe... well, actually Charles.",
	Image = "rbxassetid://86873955706196",
	
	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://80312166463920", Volume = 0.5},
			[2] = {SoundId = "rbxassetid://136503429175533", Volume = 0.5},
			[3] = {SoundId = "rbxassetid://121268513457368", Volume = 0.5},
			[4] = {SoundId = "rbxassetid://76415106096064", Volume = 0.5},
			[5] = {SoundId = "rbxassetid://120120127785777", Volume = 0.5}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://113097469912062", Volume = 0.5},
			[2] = {SoundId = "rbxassetid://109689291338912", Volume = 0.5},
			[3] = {SoundId = "rbxassetid://97178064365590", Volume = 0.5},
			[4] = {SoundId = "rbxassetid://118020582763271", Volume = 0.5},
			[5] = {SoundId = "rbxassetid://85899504900781", Volume = 0.5}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://87465859251231", Volume = 0.5},
			[2] = {SoundId = "rbxassetid://91412317643187", Volume = 0.5},
			[3] = {SoundId = "rbxassetid://83581394262129", Volume = 0.5},
			[4] = {SoundId = "rbxassetid://137223140288117", Volume = 0.5},
			[5] = {SoundId = "rbxassetid://90161078884819", Volume = 0.5}
		},
		
		["Liar"] = {SoundId = "rbxassetid://125269623696725", Volume = 0.6},
		
		["Hmm"] = {SoundId = "rbxassetid://88492872205651", Volume = 0.3},
	}
}