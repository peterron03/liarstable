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
	Description = "Congratulations! You have officially been deemed Liar's Table's #1 fan.",
	Image = "rbxassetid://128993160898525",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}