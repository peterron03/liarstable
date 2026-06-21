return {
	-- OBJECT INFO --
	Name = script.Name,
	Type = script.Parent.Name,
	Model = script:FindFirstChildWhichIsA("Model") or script:FindFirstChildWhichIsA("BasePart"),

	-- SHOP INFO --
	ForSale = false,
	CurrencyType = "Cash",
	Price = 0,
	GamepassId = nil,
	Description = "A mysterious bottle with mysterious intention.",
	Image = "rbxassetid://126862807104118",

	-- EXTRA DATA --
	Data = {
		AnimationId = 00000000,
	}
}