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
	Description = "Worn by Blackbeard himself, the finest boots you could ask for.",
	Image = "rbxassetid://103735476034483",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}