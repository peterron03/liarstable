return {
	Name = "add";
	Aliases = {};
	Description = "Adds currency to a player, given the currency name.";
	Group = "Admin";
	Args = {
		{
			Type = "players";
			Name = "Player";
			Description = "The player(s) getting the currency.";
		},

		{
			Type = "string";
			Name = "Currency";
			Description = "The currency's name.";
		},

		{
			Type = "number";
			Name = "Amount";
			Description = "The amount of currency being added.";
		},
		
		{
			Type = "boolean";
			Name = "CreateCurrency";
			Description = "If currency should be created if it doesn't already exist",
			Default = false
		}
	};
}