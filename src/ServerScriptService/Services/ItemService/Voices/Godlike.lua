return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = true,
	CurrencyType = "Cash",
	Price = 750,
	GamepassId = nil,
	Description = "Demand attention with a voice of divine power.",
	Image = "rbxassetid://120664818656745",
	
	-- EXTRA DATA --
	Data = {
		Queen = {
			{
				SoundId = "rbxassetid://116362336337140",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://75853473079967",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://79746782166675",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://85421088786322",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://111537520531393",
				Volume = 0.3
			}
		},
		Hmm = {
			SoundId = "rbxassetid://99816903269852",
			Volume = 0.2
		},
		King = {
			{
				SoundId = "rbxassetid://73636528618209",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://113629247033991",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://120942664463037",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://99883968381578",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://125080301523919",
				Volume = 0.3
			}
		},
		Liar = {
			SoundId = "rbxassetid://137138584257862",
			Volume = 0.5
		},
		Ace = {
			{
				SoundId = "rbxassetid://106092846780104",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://91171911974543",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://105208045555162",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://128554290424832",
				Volume = 0.3
			},
			{
				SoundId = "rbxassetid://99964494450044",
				Volume = 0.3
			}
		}
	}
}

