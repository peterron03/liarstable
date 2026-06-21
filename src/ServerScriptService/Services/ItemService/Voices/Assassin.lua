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
			[1] = {SoundId = "rbxassetid://110376802415718", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://113255327322250", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://95818089934706", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://119865197370055", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://125512921012014", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://84358631617918", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://91595084322754", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://71958353872965", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://121210214205000", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://115136144914243", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://114967048080101", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://134656897074987", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://83383795388326", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://93309867218085", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://130547353567326", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://84289527680707", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://120245440760417", Volume = 0.2},
	}
}