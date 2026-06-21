return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Cash",
	Price = 5000,
	GamepassId = nil,
	Description = "The legend himself, RussoPlays!",
	Image = "rbxthumb://type=Avatar&id=164279327&w=420&h=420",

	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://107820353260387", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://138054590655627", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://70701745036965", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://71154910112948", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://122386759003320", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://78302829611687", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://89731569685976", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://99507830050142", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://103359358021162", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://122021465844240", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://112799470429480", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://138127258355710", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://128390916902736", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://127837994519211", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://125605361544865", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://75986250619048", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://120948612270325", Volume = 0.2},
	}
}