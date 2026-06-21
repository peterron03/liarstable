local ButtonsFrame = script.Parent:WaitForChild("Frame")
local TweenService = game:GetService("TweenService")
local Utilities = game:GetService("ReplicatedStorage"):WaitForChild("Utilities")
local Utils = require(Utilities:WaitForChild("Utils"))

for _, button in pairs(ButtonsFrame:GetDescendants()) do
	if button:IsA("TextButton") then
		local originalbuttonSize = button.Size
		local newbuttonSize = UDim2.new(originalbuttonSize.X.Scale, originalbuttonSize.X.Offset, originalbuttonSize.Y.Scale * 1.05, originalbuttonSize.Y.Offset)
		local clickbuttonSize = UDim2.new(originalbuttonSize.X.Scale, originalbuttonSize.X.Offset, originalbuttonSize.Y.Scale * 0.8, originalbuttonSize.Y.Offset)

		button.MouseEnter:Connect(function()
			local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

			local hoverTween = TweenService:Create(button, tweenInfo, {Size = newbuttonSize})
			hoverTween:Play()
			
			if Utils.getLastInput() == "controller" then return end
			
			button.TextColor3 = Color3.new(1, 0.890196, 0.556863)
		end)
		
		button.MouseLeave:Connect(function()
			local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

			local unhoverTween = TweenService:Create(button, tweenInfo, {Size = originalbuttonSize})
			
			unhoverTween:Play()
			
			if button.Name == "PLAY" then
				button.TextColor3 = Color3.new(0.964706, 0.368627, 0.376471)
			elseif button.Name == "EVENT" then
				button.TextColor3 = Color3.fromRGB(238, 255, 48)
			else
				button.TextColor3 = Color3.new(1, 1, 1)
			end
		end)
		
		button.MouseButton1Click:Connect(function()
			local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			local unhoverTween = TweenService:Create(button, tweenInfo, {Size = originalbuttonSize})
			
			unhoverTween:Play()
			
			if button.Name == "PLAY" then
				button.TextColor3 = Color3.new(0.964706, 0.368627, 0.376471)
			elseif button.Name == "EVENT" then
				button.TextColor3 = Color3.fromRGB(238, 255, 48)
			else
				button.TextColor3 = Color3.new(1, 1, 1)
			end
		end)
	end
end