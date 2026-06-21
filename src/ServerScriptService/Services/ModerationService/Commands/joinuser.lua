return {
	Name = "join-user";
	Aliases = {};
	Description = "Joins the game of a player, given their UserId.";
	Group = "Admin";
	Args = {
		{
			Type = "playerId";
			Name = "Player";
			Description = "The player you'd like to join.";
		},
	};
}