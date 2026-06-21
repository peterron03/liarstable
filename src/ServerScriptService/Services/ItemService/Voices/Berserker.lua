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
	Description = "You think you got guts?",
	Image = "rbxassetid://79397748474996",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://82182084164745", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://137221631580342", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://99835247862802", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://114558996183149", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://105731459044996", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://123071605541615", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://98083011290501", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://133932600488005", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://102730649255214", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://87821725099653", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://140293903697004", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://104888683849641", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://76387247599710", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://111735476156293", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://110851600822381", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://110574845567359", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://88571780541080", Volume = 0.2},
	}
}