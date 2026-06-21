return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1461476052, 1461897651},
	Description = "Years of experience traversing through the galaxy.",
	Image = "rbxassetid://131879144766601",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://120542928064759", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://76638769367493", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://132611865764473", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://130415616064883", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://128557922283360", Volume = 0.4}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://137139374089797", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://115984130772406", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://124790546375696", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://125718179485478", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://91566156375518", Volume = 0.4}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://124623781701657", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://136789519402690", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://125706292749718", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://84845960482142", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://119118232018400", Volume = 0.4}
		},
		
		["Liar"] = {SoundId = "rbxassetid://109705266926603", Volume = 0.55},
		
		["Hmm"] = {SoundId = "rbxassetid://79291674512566", Volume = 0.2},
	}
}