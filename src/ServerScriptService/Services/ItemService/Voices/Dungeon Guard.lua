return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Robux",
	Price = 5000,
	GamepassId = {1020333586, 1020817352},
	Description = "Be careful with this one, he may not look like much but he'll make you remember why you're in here.",
	Image = "rbxassetid://140026499997052",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://109151301312422", Volume = 0.7},
			[2] = {SoundId = "rbxassetid://77620131982045", Volume = 0.7},
			[3] = {SoundId = "rbxassetid://137219825386919", Volume = 0.7},
			[4] = {SoundId = "rbxassetid://111387785345556", Volume = 0.7},
			[5] = {SoundId = "rbxassetid://122546586494877", Volume = 0.7}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://127047192479500", Volume = 0.7},
			[2] = {SoundId = "rbxassetid://74925962818235", Volume = 0.7},
			[3] = {SoundId = "rbxassetid://97615360812097", Volume = 0.7},
			[4] = {SoundId = "rbxassetid://140547261911277", Volume = 0.7},
			[5] = {SoundId = "rbxassetid://102530022524188", Volume = 0.7}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://137168358660419", Volume = 0.7},
			[2] = {SoundId = "rbxassetid://97435892290336", Volume = 0.7},
			[3] = {SoundId = "rbxassetid://88251665955825", Volume = 0.7},
			[4] = {SoundId = "rbxassetid://89634791166530", Volume = 0.7},
			[5] = {SoundId = "rbxassetid://80075052600248", Volume = 0.7}
		},
		
		["Liar"] = {SoundId = "rbxassetid://77253326793231", Volume = 0.8},
		
		["Hmm"] = {SoundId = "rbxassetid://73195437847289", Volume = 0.4},
	}
}