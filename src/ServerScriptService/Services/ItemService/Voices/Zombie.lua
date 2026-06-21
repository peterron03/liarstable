return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "Maybe they just wanna talk... about eating your brains.",
	Image = "rbxassetid://94888326243559",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://132511340608354", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://107174774145745", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://88641667654420", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://137900279907481", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://121027239077635", Volume = 0.3}
		},

		["Queen"] = {
			[1] = {SoundId = "rbxassetid://111109156670764", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://92842811422741", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://128860624473078", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://72270808515563", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://117474087651439", Volume = 0.3}
		},

		["King"] = {
			[1] = {SoundId = "rbxassetid://102116973489441", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://72735805479447", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://99111577607166", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://106066135928214", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://134745459596464", Volume = 0.3}
		},

		["Liar"] = {SoundId = "rbxassetid://121441587955473", Volume = 0.5},

		["Hmm"] = {SoundId = "rbxassetid://107510336170763", Volume = 0.2},
	}
}