return {
	Name = "unban";
	Aliases = {};
	Description = "Unbans a player from the game, given their UserId.";
	Group = "Admin";
	Args = {
		{
			Type = "playerId";
			Name = "Player";
			Description = "The UserId of the player getting unbanned.";
		},
	};
}