return {
	Name = "unmute";
	Aliases = {};
	Description = "Mutes a player for the server they're in.";
	Group = "Admin";
	Args = {
		{
			Type = "players";
			Name = "Player";
			Description = "The player(s) getting muted.";
		},
	};
}