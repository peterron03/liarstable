return {
	Name = "remove";
	Aliases = {};
	Description = "Removes currency from a player, given the currency name.";
	Group = "Admin";
	Args = {
		{
			Type = "players";
			Name = "Player";
			Description = "The player(s) losing the currency.";
		},

		{
			Type = "string";
			Name = "Currency";
			Description = "The currency's name.";
		},

		{
			Type = "number";
			Name = "Amount";
			Description = "The amount of currency being removed.";
		}
	};
}