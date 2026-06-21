--[[
@HttpPeter
September 25th, 2023
This handles everything involving daily log in
]]

local LogIn = {}
LogIn.__index = LogIn

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Signal = require(Knit.Util.Signal)

-- KNIT SERVICES --
local PlayerDataService

-- VARIABLES --
local SEC_IN_A_DAY = 86400
local MAX_DAYS = 5

-- TYPES --
export type LogInData = {
	CurrentDay : number,
	LastDate : number,
	DayStreak : number
}

--[[
The main constructor

@param player is the player that the Daily Log In object is being made for
@return is self
]]
function LogIn.new(player : Player, data : LogInData?)
	if not PlayerDataService then PlayerDataService = Knit.GetService("PlayerDataService") end
	
	local self = setmetatable({}, LogIn)
	
	self.Player = player
	self.LogInData = data or {}
	self.DataChanged = Signal.new()
	
	if self.LogInData then
		self.LogInData.CurrentDay = self.LogInData.CurrentDay or 1
		self.LogInData.LastDate = self.LogInData.LastDate or nil
		self.LogInData.DayStreak = self.LogInData.DayStreak or 0
		
		if self:HasDayPassed(2) then
			self:SetCurrentDay(1)
			self:SetDayStreak(0)
			self:SetLastDate(nil)
		else
			self.DataChanged:Fire(data)
		end
	end
	
	return self
end

--[[
This function returns true if a day has passed and false if it hasnt (with multiplier)

@param multiplier is an optional multiplier for how many days have passed
@return is true or false
]]
function LogIn:HasDayPassed(multiplier : number?) : boolean
	local lastDate = self.LogInData.LastDate
	local newDate = os.time() - (SEC_IN_A_DAY * (multiplier or 1))
	
	if lastDate and newDate and lastDate <= newDate then
		return true
	else
		return false
	end
end

--[[
This sets self.LogInData.CurrentDay to whatever is needed

@param newCurrent is the new CurrentDay
@return is self
]]
function LogIn:SetCurrentDay(newCurrent : number)
	if not self.LogInData then warn("Log In Data not found.") return end
	
	self.LogInData.CurrentDay = newCurrent
	
	self.DataChanged:Fire(self.LogInData)
	
	return self
end

--[[
This adds +1 to current day with a check to see if it's at 5, resetting to 1 if it is

@return is self
]]
function LogIn:AddDay()
	if not self.LogInData then warn("Log In Data not found.") return end
	
	if not self.LogInData.CurrentDay or self.LogInData.CurrentDay >= MAX_DAYS then
		self:SetCurrentDay(1)
	else
		self:SetCurrentDay(self.LogInData.CurrentDay + 1)
	end
	
	return self
end

--[[
This sets the self.LogInData.DayStreak aka the day streak

@param newStreak is the new value being set
@return is self
]]
function LogIn:SetDayStreak(newStreak : number)
	if not self.LogInData then warn("Log In Data not found.") return end
	
	self.LogInData.DayStreak = newStreak
	
	self.DataChanged:Fire(self.LogInData)
	
	return self
end

--[[
This sets self.LogInData.LastDate to whatever is needed

@param newLast is the new LastDate
@return is self
]]
function LogIn:SetLastDate(newLast : number | boolean)
	if not self.LogInData then warn("Log In Data not found.") return end

	self.LogInData.LastDate = newLast
	
	self.DataChanged:Fire(self.LogInData)

	return self
end

--[[
This returns self.LogInData.LastDate

@return is self.LogInData.LastDate
]]
function LogIn:GetLastDate()
	if not self.LogInData then warn("Log In Data not found.") return end
	
	return self.LogInData.LastDate or nil
end

--[[
This saves data and sets as much to nil as possible and clears the table out
]]
function LogIn:Destroy()
	setmetatable(self, nil)
	table.clear(self)
	table.freeze(self)
end

return LogIn
