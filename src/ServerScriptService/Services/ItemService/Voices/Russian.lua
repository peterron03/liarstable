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
	Description = "Forever loyal to the Motherland.",
	Image = "rbxassetid://120225624932605",

	-- EXTRA DATA --
	Data =
	{
	   Queen = {
	      {
	         SoundId = "rbxassetid://105067530056351",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://75571035976729",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://122380166680257",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://85881476260968",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://72557995466804",
	         Volume = 0.3
	      }
	   },
	   Hmm = {
	      SoundId = "rbxassetid://100444597911379",
	      Volume = 0.2
	   },
	   King = {
	      {
	         SoundId = "rbxassetid://121048028037513",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://92897402062345",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://118782989330356",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://90040096931121",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://101106527952006",
	         Volume = 0.3
	      }
	   },
	   Liar = {
	      SoundId = "rbxassetid://123864328057357",
	      Volume = 0.5
	   },
	   Ace = {
	      {
	         SoundId = "rbxassetid://123854430765882",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://117622162612812",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://87212528480535",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://117752829415981",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://115173880204499",
	         Volume = 0.3
	      }
	   }
	}	
}