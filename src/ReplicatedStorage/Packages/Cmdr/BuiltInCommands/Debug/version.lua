local version = "v1.12.0"

return {
	Name = "cmdr-version",
	Args = {},
	Description = "Shows the current version of Cmdr",
	Group = "Debug",

	Run = function()
		return ("Cmdr Version %s"):format(version)
	end,
}
