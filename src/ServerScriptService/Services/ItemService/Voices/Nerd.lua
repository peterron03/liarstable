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
	Description = "Geeky and excited, perfect for know-it-alls.",
	Image = "rbxassetid://101881793184777",

	-- EXTRA DATA --
	Data = {
		Queen = {
			{
				SoundId = "rbxassetid://121884303953045",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://96895843821251",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://139141664525439",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://73986278026713",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://99624219459243",
				Volume = 0.3
			}
	   },
	   Hmm = {
	      SoundId = "rbxassetid://132984414442070",
	      Volume = 0.2
	   },
	   King = {
	      {
	         SoundId = "rbxassetid://124793476640083",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://77845430121886",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://85138085525464",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://99781546582715",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://76694652549082",
	         Volume = 0.3
	      }
	   },
	   Liar = {
	      SoundId = "rbxassetid://105678966766289",
	      Volume = 0.5
	   },
	   Ace = {
	      {
	         SoundId = "rbxassetid://127057493001576",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://90645395633651",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://129131675768578",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://80767394224634",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://89711492012077",
	         Volume = 0.3
	      }
	   }
	}
}