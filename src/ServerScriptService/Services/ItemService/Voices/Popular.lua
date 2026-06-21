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
	Description = "Don't talk to me, you're just a peasant compared to me.",
	Image = "rbxassetid://137498105206024",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://79490355568992", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://104733514512620", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://90824082852284", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://70403249525508", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://124153985486457", Volume = 0.4}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://122113959996944", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://117738380905426", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://117304026326453", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://136644349562172", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://113386796377319", Volume = 0.4}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://125778119623997", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://126816043966913", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://71964828245960", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://112548090117853", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://104708252420551", Volume = 0.4}
		},
		
		["Liar"] = {SoundId = "rbxassetid://136849641379333", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://106205823963498", Volume = 0.3},
	}
}