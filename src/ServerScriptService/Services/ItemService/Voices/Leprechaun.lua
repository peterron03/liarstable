return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1089031433, 1089993462},
	Description = "Tough as they come, you'll need luck to get out of this one.",
	Image = "rbxassetid://102968858045615",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://77494796651475", Volume = 0.2},
			[2] = {SoundId = "rbxassetid://92459956643968", Volume = 0.2},
			[3] = {SoundId = "rbxassetid://112007374835488", Volume = 0.2},
			[4] = {SoundId = "rbxassetid://132694464528441", Volume = 0.2},
			[5] = {SoundId = "rbxassetid://119545887375435", Volume = 0.2}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://84061161614124", Volume = 0.2},
			[2] = {SoundId = "rbxassetid://122010366320064", Volume = 0.2},
			[3] = {SoundId = "rbxassetid://111395927007622", Volume = 0.2},
			[4] = {SoundId = "rbxassetid://117248006106324", Volume = 0.2},
			[5] = {SoundId = "rbxassetid://78083152065891", Volume = 0.2}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://116204562312257", Volume = 0.2},
			[2] = {SoundId = "rbxassetid://83961803223529", Volume = 0.2},
			[3] = {SoundId = "rbxassetid://113409790986013", Volume = 0.2},
			[4] = {SoundId = "rbxassetid://72853452259467", Volume = 0.2},
			[5] = {SoundId = "rbxassetid://140028182200323", Volume = 0.2}
		},
		
		["Liar"] = {SoundId = "rbxassetid://80256165790164", Volume = 0.4},
		
		["Hmm"] = {SoundId = "rbxassetid://137769512665301", Volume = 0.1},
	}
}