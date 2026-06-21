local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Utils = require(ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utils"))
local Knit = require(Packages:WaitForChild("Knit"))
local CurrencyService = Knit.GetService("CurrencyService")

return function(context, players, currency, amount)
	for _, player in pairs(players) do
		if CurrencyService:DoesCurrencyExist(player, currency) then
			local success = CurrencyService:SetAmount(player, currency, amount)

			if success then
				context:Reply("Successfully set " .. player.Name .. "'s " .. currency .. " to " .. Utils.formatNumber(amount, 1000) .. "!")
			else
				context:Reply("Possible error while trying to set " .. player.Name .. "'s " .. currency .. ".")
			end
		else
			local possibleChoice = string.upper(string.sub(string.lower(currency), 1, 1))

			if not CurrencyService:DoesCurrencyExist(player, possibleChoice) then
				possibleChoice = nil
			end

			return "Unable to find '" .. currency .. "'. " .. ((possibleChoice and "Did you mean '" .. possibleChoice .. "'?") or ("Keep in mind, all stats are case sensitive."))
		end
	end
	
	return ""
end