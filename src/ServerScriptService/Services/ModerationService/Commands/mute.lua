return {
	Name = "mute";
	Aliases = {};
	Description = "Mutes a player for the server they're in.";
	Group = "Admin";
	Args = {
		{
			Type = "players";
			Name = "Player";
			Description = "The player(s) getting muted.";
		},
		
		{
			Type = "string";
			Name = "Reason";
			Description = "The reason for the mute.";
			Default = ""
		}
	};
}