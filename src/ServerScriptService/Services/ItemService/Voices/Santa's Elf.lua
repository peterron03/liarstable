return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Peppermints",
	Price = 750,
	GamepassId = nil,
	Description = "Always ready to help Santa when he needs it.",
	Image = "rbxassetid://110391862622411",
	Edition = "rbxassetid://129805820847359",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://110293731276827", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://91736755485774", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://122518319844149", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://119708225471797", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://71707980764746", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://113903945777416", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://121466650581066", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://135406897398212", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://139607148799553", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://103537427259869", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://99910858157710", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://125414835232854", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://80384598252414", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://107622522067289", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://136352967454812", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://87257754674369", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://90731400124543", Volume = 0.2},
	}
}