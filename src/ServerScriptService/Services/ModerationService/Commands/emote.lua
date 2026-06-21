return {
	Name = "emote";
	Aliases = {};
	Description = "Plays an emote for the specified player.";
	Group = "Admin";
	Args = {
		{
			Type = "player";
			Name = "Player";
			Description = "The player to play the emote on.";
		},
		
		{
			Type = "emotes";
			Name = "Emote";
			Description = "The name of the emote being played.";
		},
	};
}