return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Peppermints",
	Price = 5000,
	GamepassId = nil,
	Description = "Merry Christmas to all, and to all a goodnight!",
	Image = "rbxassetid://117878923749580",
	Edition = "rbxassetid://129805820847359",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://70745665844144", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://119257066721236", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://117100648091015", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://101001126352439", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://121567258409809", Volume = 0.4}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://105973048525881", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://84602071693676", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://118136543573716", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://138583494723492", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://123386253462147", Volume = 0.4}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://114630015493076", Volume = 0.4},
			[2] = {SoundId = "rbxassetid://75399738954092", Volume = 0.4},
			[3] = {SoundId = "rbxassetid://78174805876188", Volume = 0.4},
			[4] = {SoundId = "rbxassetid://139835558008693", Volume = 0.4},
			[5] = {SoundId = "rbxassetid://105620172394869", Volume = 0.4}
		},
		
		["Liar"] = {SoundId = "rbxassetid://101693338515055", Volume = 0.6},
		
		["Hmm"] = {SoundId = "rbxassetid://110212556382950", Volume = 0.2},
	}
}