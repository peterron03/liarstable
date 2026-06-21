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
	Description = "Rough and ready for adventure on the high seas.",
	Image = "rbxassetid://97474909087544",

	-- EXTRA DATA --
	Data =
	{
	   Queen = {
	      {
	         SoundId = "rbxassetid://114321449527847",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://138989163935541",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://132607178942308",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://123922403336935",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://133280658139437",
	         Volume = 0.3
	      }
	   },
	   Hmm = {
	      SoundId = "rbxassetid://134162803834232",
	      Volume = 0.2
	   },
	   King = {
	      {
	         SoundId = "rbxassetid://127275211154852",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://108454557375731",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://106132800573115",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://106336167654664",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://93510229621302",
	         Volume = 0.3
	      }
	   },
	   Liar = {
	      SoundId = "rbxassetid://75593457988575",
	      Volume = 0.5
	   },
	   Ace = {
			[1] = {
				SoundId = "rbxassetid://108207345335190",
				Volume = 0.3
			},
		  
			[2] = {
				SoundId = "rbxassetid://139818173991478",
				Volume = 0.3
			},
			
			[3] = {
				SoundId = "rbxassetid://103412569736583",
				Volume = 0.3
			},
			
			[4] = {
				SoundId = "rbxassetid://87630854947524",
				Volume = 0.3
			},
			
			[5] = {
				SoundId = "rbxassetid://131696644094603",
				Volume = 0.3
			}
	   }
	}
}