return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Peppermints",
	Price = 2000,
	GamepassId = nil,
	Description = "No one should be alone on Christmas, not even you.",
	Image = "rbxassetid://102629832138041",
	Edition = "rbxassetid://129805820847359",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://97447333673601", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://88713216373653", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://137470196274871", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://77921567767729", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://140319117256773", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://140725022715808", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://110076442211726", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://93746188984613", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://74745722537576", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://139406738692537", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://89856493685274", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://140360486652215", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://110644565349982", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://121918619066142", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://93973486319616", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://115060429612414", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://102116976664893", Volume = 0.2},
	}
}