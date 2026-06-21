return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 750,
	GamepassId = nil,
	Description = "Gosh, I'm the goofiest goober!",
	Image = "rbxassetid://110418333183377",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://105526055744241", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://83392981678837", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://71224179795936", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://118300346981370", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://74239607020221", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://133556913841526", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://72914436698835", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://99686603722881", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://72924102695369", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://131766866218606", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://92196875683777", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://81878278177391", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://97191027329441", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://70926304490537", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://104389839073322", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://71682028285924", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://124911790613183", Volume = 0.2},
	}
}