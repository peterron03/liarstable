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
	Description = "I lost too many times and haven't been able to recover.",
	Image = "rbxassetid://70463701365293",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://91068285689394", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://115850919664103", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://114391714414988", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://135054924235402", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://101286129064752", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://72174392665301", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://121774667787214", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://102938025724678", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://128307357195607", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://138074208202568", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://95097866847612", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://84241080427905", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://89082396343642", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://89318117770855", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://83753345031247", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://77150277520028", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://119958051751677", Volume = 0.2},
	}
}