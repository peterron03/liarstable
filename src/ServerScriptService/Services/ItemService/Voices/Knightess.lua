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
	Description = "Stealthy and deadly, with a voice that cuts through the silence.",
	Image = "rbxassetid://110155544104231",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://84269171276492", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://76794974501707", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://72251026856179", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://107757857535342", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://125085088055687", Volume = 0.4}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://76919591648145", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://86523476912016", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://121641928837913", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://105816045981520", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://92387269172239", Volume = 0.4}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://112254532709962", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://95189525453549", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://128145515015398", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://91401557625481", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://81260553005744", Volume = 0.4}
		},
		
		["Liar"] = {SoundId = "rbxassetid://92236512265378", Volume = 0.6},
		
		["Hmm"] = {SoundId = "rbxassetid://84970974298081", Volume = 0.3},
	}
}