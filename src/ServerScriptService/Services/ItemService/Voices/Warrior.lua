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
	Description = "Ready to face the competition head-on, no hesitation.",
	Image = "rbxassetid://110641841515337",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://138248914702306", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://118186672448932", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://109111632163334", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://131889268579529", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://83649830935832", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://133241371517643", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://128819306211044", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://82494811947891", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://108583790111669", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://119375237238244", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://118795418570110", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://111470062343165", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://80516629138756", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://81228006423286", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://107490972978510", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://86241730379750", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://95578376925592", Volume = 0.2},
	}
}