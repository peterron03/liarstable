-------------------------
--// Type Defintions //--
-------------------------

type Array<Type> = {[number] : Type}
type Dictionary<Type> = {[string] : Type}

export type SupportedType = Vector3 | Vector3int16 | Vector2 | Vector2int16 | number
export type Spring = {
	Impulse : (self : Spring, Amount : number) -> (),

	Position  : SupportedType,
	Velocity  : number,
	Dampen    : number,
	Dampening : number,
	Speed     : number
}

export type Annotation = {
	New : (InitialValue : SupportedType?, Speed : number?, Dampening : number) -> Spring
}

-----------------------
--// Initalization //--
-----------------------

local Spring = {}

-------------------
--// Variables //--
-------------------

local EulersNumber = 2.71828

-------------------
--// Functions //--
-------------------

-- Euler's Number is equal to the "limit of 1 plus infininity all to the infinite power"
-- This is approximately 2.71828, and has a large number of use cases (such as this, or as the natural log base)

local function GetPositionDerivative(Speed, Dampening, Position0, Coordinate1, Coordinate2, Tick0)
	-- This returns position and instantaneous velocity
	-- The first derivative of position is ALWAYS velocity

	local Time = tick() - Tick0

	if (Dampening >= 1) then
		local EulersFastTime = math.pow(EulersNumber, (Speed * Time))

		return ((Coordinate1 + Coordinate2 * Speed * Time) / EulersFastTime + Position0), -- POSITION
			((Coordinate2 * Speed * (1 - Time) - Coordinate1) / EulersFastTime) -- VELOCITY
	else
		local High = math.sqrt(1 - Dampening * Dampening)

		local HighSpeedTime = Speed * High * Time
		local DampenedSpeedTime = math.pow(EulersNumber, Speed * Dampening * Time)
		local SineHighSpeedTime, CosineHighSpeedTime = math.sin(HighSpeedTime), math.cos(HighSpeedTime)

		return ((Coordinate1 * CosineHighSpeedTime + Coordinate2 * SineHighSpeedTime) / DampenedSpeedTime + Position0),  -- POSITION
			(Speed * ((High * Coordinate2 - Dampening * Coordinate1) * CosineHighSpeedTime - (High * Coordinate1 + Dampening * Coordinate1) * SineHighSpeedTime) / DampenedSpeedTime) -- VELOCITY
	end
end

---------------------
--// Constructor //--
---------------------

function Spring.new(InitialValue, Speed, Dampening)
	local self = {}

	local Speed = Speed or 15
	local Dampening = Dampening or 0.5
	local Position0 = InitialValue or 0

	local Coordinate1, Coordinate2 = 0 * Position0, 0 * Position0
	local Tick0 = tick()

	function self:Impulse(Amount : number)
		local Position, Velocity = GetPositionDerivative(Speed, Dampening, Position0, Coordinate1, Coordinate2, Tick0)

		Tick0, Coordinate1 = tick(), Position

		if (Dampening >= 1) then
			Coordinate2 = Coordinate1 + (Velocity + Amount) / Speed
		else
			local High = math.sqrt(1 - Dampening * Dampening)

			Coordinate2 = Dampening / High * Coordinate1 + (Velocity + Amount) / (Speed * High)
		end
	end

	local Metatable = {}

	function Metatable.__index(_, Index : string) : ... number?
		Index = string.lower(Index)

		if (Index == "position") then
			return GetPositionDerivative(Speed, Dampening, Position0, Coordinate1, Coordinate2, Tick0)

		elseif (Index == "velocity") then
			local _, Velocity = GetPositionDerivative(Speed, Dampening, Position0, Coordinate1, Coordinate2, Tick0)

			return Velocity

		elseif (Index == "dampen") or (Index == "dampening") then
			return Dampening

		elseif (Index == "speed") then
			return Speed
		end
	end

	function Metatable.__newindex(_, Index : string, Value : any?) : ... any?
		Index = string.lower(Index)

		if (Index == "dampen") or (Index == "dampening") then
			Dampening = Value

		elseif (Index == "speed") then
			Speed = Value

		elseif (Index == "target") then
			local Position, Velocity = GetPositionDerivative(Speed, Dampening, Position0, Coordinate1, Coordinate2, Tick0)

			Tick0, Position0 = tick(), Value
			Coordinate1 = Position - Position0

			if (Dampening >= 1) then
				Coordinate2 = Coordinate1 + Velocity / Speed
			else
				local High = math.sqrt(1 - Dampening * Dampening)

				Coordinate2 = Dampening / High * Coordinate1 + Velocity / (Speed * High)
			end
		end
	end

	return setmetatable(self, Metatable)
end

----------------------
--// Finalization //--
----------------------

return Spring