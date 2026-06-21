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
	Description = "Please, go easy on me... I can't handle losing.",
	Image = "rbxassetid://100767464603265",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://97799600446605", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://101166763816292", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://117445770435230", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://137115893989003", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://106676517470518", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://131838417866141", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://87775969086538", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://106715735544124", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://81291285666008", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://122649571687913", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://81361505417615", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://118273585919806", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://137453162245561", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://82204745161388", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://110912195150414", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://103194129007995", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://116494454203561", Volume = 0.2},
	}
}