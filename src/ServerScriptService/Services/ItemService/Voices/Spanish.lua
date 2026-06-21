return {

	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 250,
	GamepassId = nil,
	Description = "A merciless mercenary, quick as a cat on all fours.",
	Image = "rbxassetid://140068546560517",
	
	-- EXTRA DATA --
	Data =
	{
	   Queen = {
	      {
	         SoundId = "rbxassetid://104895345558167",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://99791256577731",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://92194290482054",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://88536908666019",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://87662839258449",
	         Volume = 0.3
	      }
	   },
	   Hmm = {
	      SoundId = "rbxassetid://127363178730146",
	      Volume = 0.2
	   },
	   King = {
	      {
	         SoundId = "rbxassetid://89221513221363",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://87917229072732",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://137970804993309",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://73824752702048",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://140711711576686",
	         Volume = 0.3
	      }
	   },
	   Liar = {
	      SoundId = "rbxassetid://105644849034113",
	      Volume = 0.5
	   },
	   Ace = {
	      {
	         SoundId = "rbxassetid://105075399474886",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://88300997149148",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://104142033249259",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://97245295358879",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://111750493687541",
	         Volume = 0.3
		  }
	   }
	}
}