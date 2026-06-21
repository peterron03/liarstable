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
	Description = "Ready to rule the world, or at least this table.",
	Image = "rbxassetid://78700535875132",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://127235600405025", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://109169476527622", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://89293714530586", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://95806084964161", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://134252527063702", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://100511751668817", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://94582566736337", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://104809089633919", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://123713976408820", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://112409271796291", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://104835315091033", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://102476386498268", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://81662517646298", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://82601672215740", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://82074585457937", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://76778655367803", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://86945739936086", Volume = 0.2},
	}
}