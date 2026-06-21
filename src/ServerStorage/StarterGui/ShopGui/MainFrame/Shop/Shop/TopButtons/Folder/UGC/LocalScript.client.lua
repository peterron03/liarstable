script.Parent:GetAttributeChangedSignal("Selected"):Connect(function(newValue)
	if script.Parent:GetAttribute("Selected") then
		script.Parent.BackgroundColor3 = Color3.fromRGB(125, 125, 125)
	else
		script.Parent.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
	end
end)