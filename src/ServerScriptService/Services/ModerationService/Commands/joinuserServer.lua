local TeleportService = game:GetService("TeleportService")
local AssetService = game:GetService("AssetService")

return function(context, userId)
	if type(userId) == "number" then
		local current, err, placeId, instanceId
		
		local success, result = pcall(function()
			current, err, placeId, instanceId = TeleportService:GetPlayerPlaceInstanceAsync(userId)
		end)
		
		if current then
			return "Player is already in your server"
		end
		
		if not success or err or not placeId or not instanceId then
			return "Unable to locate player; possibly not in a game"
		end
		
		local teleportOptions = Instance.new("TeleportOptions")
		
		teleportOptions.ServerInstanceId = instanceId
		
		context:Reply("Server found! Attempting to join...", Color3.fromRGB(255, 255, 8))
		
		local success, result = pcall(function()
			TeleportService:TeleportAsync(placeId, {context.Executor}, teleportOptions)
		end)
		
		if not success then
			return "Teleport failed, try again"
		end
		
		return "..."
	else
		return "Invalid user ID"
	end
end