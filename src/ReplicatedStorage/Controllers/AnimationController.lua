--[[
@TheAlmightyForehead
May 4th, 2024
This controller handles most, if not all, of the animation work
]]

-- SERVICES --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))

local Anim = Knit.CreateController {
	Name = "AnimationController",
	Animations = {},
	Callbacks = {},
	PlayingAnimations = {},
	Connections = {},
	CachedIds = {},
}

function Anim:Load(animationId : number, animationName : string, humanoid : Humanoid?, playOnLoaded : boolean?, speed : number?, attempt : number?, callback : any?, ...) : AnimationTrack?
	local player = Players.LocalPlayer
	local callbackArgs = callback and {...}

	self.CachedIds[animationName] = animationId
	
	if not humanoid then
		repeat task.wait() until not player or not player.Character or player.Character.Parent == workspace
	end

	local success, err = pcall(function()
		local newAnim = Instance.new("Animation")

		newAnim.AnimationId = "rbxassetid://" .. animationId
		
		local animator = humanoid and humanoid:FindFirstChild("Animator")

		if not humanoid then
			humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
			animator = humanoid and humanoid:FindFirstChild("Animator")
			
			local clientAnimator = humanoid and (humanoid:FindFirstChild("ClientAnimator") or Instance.new("Animator"))

			if clientAnimator then
				clientAnimator.Name = "ClientAnimator"
				clientAnimator.Parent = humanoid
			end

			if animator then
				animator:Destroy()
			end

			animator = clientAnimator
		end

		if animator then
			local newAnimTrack = animator:LoadAnimation(newAnim)

			if newAnimTrack then
				newAnimTrack.Name = animationName
				
				if self.Animations[animationName] then
					self.Animations[animationName]:Destroy()
				end
				
				self.Animations[animationName] = newAnimTrack
				
				if callback then
					self.Callbacks[animationName] = {Function = callback, Args = callbackArgs}
				end

				if playOnLoaded then
					self:Play(animationName, nil, speed)
				end
			end
		elseif not attempt or attempt < 5 then
			task.wait(1)

			if not attempt then
				attempt = 1
			else
				attempt += 1
			end

			return self:Load(animationId, animationName, humanoid, playOnLoaded, speed, attempt)
		else
			return nil
		end
	end)

	if success then
		return self.Animations[animationName]
	else
		warn(err)
		return nil
	end
end

function Anim:Play(animationName : string, animationId : number?, speed : number?, humanoid : Humanoid?, ...) : AnimationTrack?
	if not self.Animations[animationName] then
		if not animationId and self.CachedIds[animationName] then
			animationId = self.CachedIds[animationName]
		end
		
		if animationId then
			return self:Load(animationId, animationName, humanoid, true)
		end

		return nil
	end

	if self.Callbacks[animationName] then
		return self.Callbacks[animationName].Function(self.Animations[animationName], unpack(self.Callbacks[animationName].Args or {}), ...)
	else
		self.Animations[animationName]:Play()
		self.Animations[animationName]:AdjustSpeed(speed or 1)
	end

	return self.Animations[animationName]
end

function Anim:Stop(animationName : string) : AnimationTrack?
	if not self.Animations[animationName] then return end

	self.Animations[animationName]:Stop()

	return self.Animations[animationName]
end

function Anim:Pause(animationName : string) : AnimationTrack?
	if not self.Animations[animationName] then return end

	self.Animations[animationName]:AdjustSpeed(0)

	return self.Animations[animationName]
end

function Anim:SetSpeed(animationName : string, speed : number, animationId : number?, humanoid : Humanoid?) : AnimationTrack?
	if not self.Animations[animationName] then
		if animationId then
			self:Load(animationId, animationName, humanoid)
		end

		return nil
	end

	self.Animations[animationName]:AdjustSpeed(speed or 1)

	return self.Animations[animationName]
end

function Anim:GetLength(animationName : string, animationId : number?, humanoid : Humanoid?) : number?
	if not self.Animations[animationName] and animationId then
		self:Load(animationId, animationName, humanoid)
	end

	if self.Animations[animationName] then
		return self.Animations[animationName].Length
	else
		return nil
	end
end

function Anim:GetTrack(animationName : string) : AnimationTrack?
	return self.Animations[animationName] or nil
end

function Anim:IsPlaying(animationName : string) : boolean?
	if self.Animations[animationName] then
		return self.Animations[animationName].IsPlaying
	end

	return nil
end

function Anim:Destroy(animationName : string)
	if not self.Animations[animationName] then return end
	
	self:Stop(animationName)
	
	self.Animations[animationName]:Destroy()
	self.Animations[animationName] = nil
	self.Callbacks[animationName] = nil
end

function Anim:KnitInit()
	print(script.Name .. " initialized")
end

function Anim:KnitStart()
	print(script.Name .. " started")
end

return Anim