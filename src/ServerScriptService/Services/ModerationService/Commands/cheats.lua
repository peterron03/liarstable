local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CheatsVal

if RunService:IsClient() then
	CheatsVal = Instance.new("BoolValue")
	CheatsVal.Name = "CheatsEnabled"
	CheatsVal.Value = false
	CheatsVal.Parent = ReplicatedStorage
end

return {
	Name = "cheats";
	Aliases = {};
	Description = "Enables cheats for the game, allowing you to view everyone's cards and what's played.";
	Group = "Admin";
	Args = {
		{
			Type = "boolean";
			Name = "Enabled";
			Description = "Whether the cheats are to be enabled or disabled."
		},
	};

	ClientRun = function(context, enabled)
		if not CheatsVal then return "Unknown error" end
		
		CheatsVal.Value = (enabled and true) or (false)
		
		return (enabled and "Enabled cheats.") or ("Disabled cheats.")
	end
}