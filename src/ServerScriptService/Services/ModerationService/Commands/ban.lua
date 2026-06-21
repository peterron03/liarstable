return {
	Name = "ban";
	Aliases = {};
	Description = "Permanently bans a player from the game.";
	Group = "Admin";
	Args = {
		{
			Type = "playerIds";
			Name = "Player";
			Description = "The player(s) getting banned.";
		},
		
		{
			Type = "string";
			Name = "Reason";
			Description = "The reason for the ban.";
			Default = ""
		}
	};
}