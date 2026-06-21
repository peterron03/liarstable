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
	Description = "You shall not lie!",
	Image = "rbxassetid://81385565618208",

	-- EXTRA DATA --
	Data =
	{
	   Queen = {
	      {
	         SoundId = "rbxassetid://85407379532639",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://80380012757923",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://112118465775494",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://123742379636409",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://81018694878045",
	         Volume = 0.3
	      }
	   },
	   Hmm = {
	      SoundId = "rbxassetid://113622395118125",
	      Volume = 0.2
	   },
	   King = {
	      {
	         SoundId = "rbxassetid://132742756580473",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://97428129257243",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://105473945514649",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://110607088031723",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://132058404758769",
	         Volume = 0.3
	      }
	   },
	   Liar = {
	      SoundId = "rbxassetid://134438513849970",
	      Volume = 0.5
	   },
	   Ace = {
	      {
	         SoundId = "rbxassetid://81326928599067",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://102401219329137",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://74241860261741",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://95433753853500",
	         Volume = 0.3
	      },
	      {
	         SoundId = "rbxassetid://101274938743478",
	         Volume = 0.3
	      }
	   }
	}
}