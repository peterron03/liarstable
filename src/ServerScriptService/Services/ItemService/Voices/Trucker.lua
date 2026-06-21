return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Beach Balls",
	Price = 5000,
	GamepassId = nil,
	Description = "Long drives, gotta wind down some how. Why not with a game of cards?",
	Image = "rbxassetid://98383144716571",
	Edition = "rbxassetid://102287333654369",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://93711548046890", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://104350236083876", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://110553889856339", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://99568486013411", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://89142831159743", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://76627397160794", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://78703995997347", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://81772226613667", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://74665086008936", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://122358658661061", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://102003570443474", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://122942486464772", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://118081026338507", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://96125031258300", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://91842070043759", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://133739607764006", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://108066454498399", Volume = 0.2},
	}
}