return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Beach Balls",
	Price = 2000,
	GamepassId = nil,
	Description = "Suhhh, dude. How about a game of Liar's Table, man?",
	Image = "rbxassetid://96926891586896",
	Edition = "rbxassetid://102287333654369",
	
	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://119033239300015", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://88215604013277", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://90078373581863", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://84373705179444", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://139110415302856", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://92767500654021", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://118990400459675", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://130308057091762", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://99740524149981", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://73192951423401", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://90002997054103", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://126201305818154", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://130896702714481", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://89850061455522", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://99940659178529", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://101864308624426", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://97606761144661", Volume = 0.2},
	}
}