local Players = game:GetService("Players")
local templateButton = script.Parent:WaitForChild("Template")
local selectedPlayer = script.Parent.Parent:WaitForChild("SelectedPlayer")
local textBox = script.Parent.Parent:WaitForChild("SearchBar"):WaitForChild("TextBox")
local selectingPlayer = false

local function UpdateSearch(text : string)
	for _, v in pairs(script.Parent:GetChildren()) do
		if v:IsA("GuiButton") and v ~= templateButton then
			local find = string.find(string.lower(v.PlayerName.Text), string.lower(text)) or string.find(string.lower(v.DisplayName.Value), string.lower(text))
			v.Visible = (find and true) or (false)
		end
	end
end

local function PlayerAdded(player : Player)
	if player == Players.LocalPlayer then return end
	
	local button = script.Parent:FindFirstChild(player.UserId)
	
	if not button then
		button = templateButton:Clone()
		
		button.Name = player.UserId
		button.Parent = script.Parent
		
		button.DisplayName.Value = player.DisplayName
		button.PlayerName.Text = player.Name
		
		xpcall(function()
			local thumb, isLoaded = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			
			if thumb and isLoaded then
				button.ImageLabel.Image = thumb
			end
		end, warn)
		
		button.MouseButton1Click:Connect(function()
			if not selectingPlayer then
				selectingPlayer = true
				
				local success, err = pcall(function()
					selectedPlayer.PlayerId.Value = tonumber(button.Name)
					selectedPlayer.PlayerName.Text = button.PlayerName.Text
					selectedPlayer.ImageLabel.Image = button.ImageLabel.Image
				end)
				
				if not success then warn(err) end
				
				selectingPlayer = false
			end
		end)
		
		UpdateSearch(textBox.Text)
	end
end

local function PlayerRemoved(player : Player)
	local button = script.Parent:FindFirstChild(player.UserId)
	
	if button then
		button:Destroy()
	end	
end

Players.PlayerRemoving:Connect(PlayerRemoved)
Players.PlayerAdded:Connect(PlayerAdded)

textBox.Changed:Connect(function()
	UpdateSearch(textBox.Text)
end)

for _, v in pairs(Players:GetPlayers()) do
	PlayerAdded(v)
end