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
	Description = "Hidden in the shadows, feared by everyone.",
	Image = "rbxassetid://91718701355377",
	Edition = "rbxassetid://102287333654369",
	
	-- EXTRA DATA --
	Data = {
		["Ace"] = {
			[1] = {SoundId = "rbxassetid://110146827012140", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://93152686754643", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://99960542943770", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://107521525964856", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://95779829789918", Volume = 0.3}
		},
		
		["Queen"] = {
			[1] = {SoundId = "rbxassetid://88057618303150", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://76009206661729", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://74476390089727", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://116757864190779", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://81099287158230", Volume = 0.3}
		},
		
		["King"] = {
			[1] = {SoundId = "rbxassetid://135362873895262", Volume = 0.3},
			[2] = {SoundId = "rbxassetid://110712535146954", Volume = 0.3},
			[3] = {SoundId = "rbxassetid://87077385807562", Volume = 0.3},
			[4] = {SoundId = "rbxassetid://95497476133463", Volume = 0.3},
			[5] = {SoundId = "rbxassetid://75081688709334", Volume = 0.3}
		},
		
		["Liar"] = {SoundId = "rbxassetid://122829228416247", Volume = 0.5},
		
		["Hmm"] = {SoundId = "rbxassetid://87327399328315", Volume = 0.2},
	}
}