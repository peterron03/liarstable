return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 250,
	GamepassId = nil,
	Description = "Bring the land Down Under to life.",
	Image = "rbxassetid://118055010873123",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://72973385571120", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://115891440482136", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://96406524531105", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://80467283249279", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://100994441826691", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://97272020280452", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://107988538804000", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://101204537459803", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://82874269393984", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://80971235473277", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://88113033066394", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://119386589514736", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://78016793708074", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://129682786937800", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://84547767268837", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://135415636092904", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://131398084989259", Volume = 0.2},
	}
}