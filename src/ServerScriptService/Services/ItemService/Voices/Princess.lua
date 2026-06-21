return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 2000,
	GamepassId = nil,
	Description = "Never has to work a day in her life, unless she has a step-mother.",
	Image = "rbxassetid://101799540997447",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://132861860702160", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://74464731613711", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://75286014711372", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://117535681389931", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://100968642487335", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://92913976630933", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://100411649150493", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://93969906834019", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://138097160673498", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://79905094210066", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://92329797512017", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://87007427643156", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://123493032272203", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://88764116861913", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://93932380730153", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://138562207252000", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://139019614975376", Volume = 0.3},
	}
}