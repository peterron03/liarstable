return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Beach Balls",
	Price = 750,
	GamepassId = nil,
	Description = "Hangin' in the sun playin' Liar's Table. It's so fun!",
	Image = "rbxassetid://90028488633111",
	Edition = "rbxassetid://102287333654369",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://81153501949744", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://127339271402890", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://126337724271645", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://86622612094971", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://102779336574486", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://117658384630575", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://140145430241676", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://87463945048975", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://115840787457760", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://78534084283295", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://130695178527063", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://139601701489671", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://105784286911600", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://129127274901115", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://96439601097946", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://99195234503110", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://72226124555140", Volume = 0.2},
	}
}