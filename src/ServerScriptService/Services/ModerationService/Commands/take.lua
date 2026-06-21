return {
	Name = "take";
	Aliases = {};
	Description = "Removes an item from a player's inventory, given the name and type.";
	Group = "Admin";
	Args = {
		{
			Type = "players";
			Name = "Player";
			Description = "The player(s) losing the item.";
		},

		{
			Type = "itemtypes";
			Name = "ItemType";
			Description = "The item's type.";
		},

		{
			Type = "string";
			Name = "ItemName";
			Description = "The name of the item.";
		}
	};
}