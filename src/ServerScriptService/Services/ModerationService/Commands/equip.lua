return {
	Name = "equip";
	Aliases = {};
	Description = "Equips an item in a player's inventory, given the name and type.";
	Group = "Admin";
	Args = {
		{
			Type = "players";
			Name = "Player";
			Description = "The player(s) equipping the item.";
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
	};
}