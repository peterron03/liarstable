return {
	Name = "game-version",
	Args = {},
	Description = "Shows the current place version of the game",
	Group = "Debug",

	Run = function()
		return ("Place Version %s"):format(game.PlaceVersion)
	end,
}
