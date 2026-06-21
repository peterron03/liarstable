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
	Description = "Rewarded to the top 50 players on the Peppermints leaderboard at the end of the 2024 Christmas event.",
	Image = "rbxassetid://104698804856925",
	Edition = "rbxassetid://140328238653080",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}