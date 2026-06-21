local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Utils = require(ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utils"))
local Knit = require(Packages:WaitForChild("Knit"))
local CurrencyService = Knit.GetService("CurrencyService")

return function(context, players, currency, amount, createCurrency)
	for _, player in pairs(players) do
		if createCurrency and not CurrencyService:DoesCurrencyExist(player, currency) then
			CurrencyService:CreateCurrency(player, currency)
		end
		
		if CurrencyService:DoesCurrencyExist(player, currency) then
			local success = CurrencyService:Add(player, currency, amount)

			if success then
				context:Reply("Successfully added " .. Utils.formatNumber(amount, 1000) .. " to " .. player.Name .. "'s " .. currency .. "!")
			else
				context:Reply("Possible error while trying to change " .. player.Name .. "'s " .. currency .. ".")
			end
		else
			local possibleChoice = string.upper(string.sub(currency, 1, 1)) .. string.lower(string.sub(currency, 2, #currency))

			if not CurrencyService:DoesCurrencyExist(player, possibleChoice) then
				possibleChoice = nil
			end

			return "Unable to find '" .. currency .. "'. " .. ((possibleChoice and "Did you mean '" .. possibleChoice .. "'?") or ("Keep in mind, all stats are case sensitive."))
		end
	end
	
	return ""
end