return {
	Name = "set";
	Aliases = {};
	Description = "Sets a player's currency, given the currency name.";
	Group = "Admin";
	Args = {
		{
			Type = "players";
			Name = "Player";
			Description = "The player(s) getting their currency set.";
		},

		{
			Type = "string";
			Name = "Currency";
			Description = "The currency's name.";
		},

		{
			Type = "number";
			Name = "Amount";
			Description = "The amount of currency to be set.";
		}
	};
}