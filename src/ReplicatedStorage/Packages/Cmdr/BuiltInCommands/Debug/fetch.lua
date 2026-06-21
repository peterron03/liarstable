return {
	Name = "fetch";
	Aliases = {};
	Description = "Fetch a value from the Internet";
	Group = "Debug";
	Args = {
		{
			Type = "url";
			Name = "URL";
			Description = "The URL to fetch.";
		}
	};
}