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
	Description = "Haunting and ethereal, echoing from beyond.",
	Image = "rbxassetid://75224780805979",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://133935685280739", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://134854027676767", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://118093089144724", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://130928609605748", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://137539304968170", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://100160748340827", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://91932564922081", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://74943692956593", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://116002035250436", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://97959309407296", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://131622071422251", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://78690555732427", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://78678226097521", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://137038081462129", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://139238145243052", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://103993458658613", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://124224180831070", Volume = 0.2},
	}
}