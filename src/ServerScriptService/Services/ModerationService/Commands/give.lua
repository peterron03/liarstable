return {
	Name = "give";
	Aliases = {};
	Description = "Adds an item to a player's inventory, given the name and type.";
	Group = "Admin";
	Args = {
		{
			Type = "players";
			Name = "Player";
			Description = "The player(s) getting the item.";
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
		},
		
		{
			Type = "boolean";
			Name = "CreateInventory";
			Description = "If inventory should be created if it doesn't already exist",
			Default = false
		}
	};
}