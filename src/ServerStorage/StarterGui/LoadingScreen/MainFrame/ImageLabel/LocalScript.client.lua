local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
local tween = TweenService:Create(script.Parent, tweenInfo, {Rotation = -360})

tween:Play()