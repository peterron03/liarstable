--[[
@TheAlmightyForehead
June 8th, 2024
This handles (mostly) everything to do with Pets on the client
]]

-- SERVICES --
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- KNIT --
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))

-- PLAYER --
local Player = Players.LocalPlayer

-- OBJECTS --
local PetsFolder = workspace:WaitForChild("PLAYER_PETS")
local PetsStorage = Instance.new("Folder", ReplicatedStorage)

local Pet = Knit.CreateController {
	Name = "PetController",
	Spacing = 3,
	PetSize = 3,
	MaxClimbHeight = 8
}

function Pet:TogglePets(player : Player, enable : boolean?)
	local playerFolder = PetsFolder:FindFirstChild(tostring(player.UserId)) or PetsStorage:FindFirstChild(tostring(player.UserId))

	if playerFolder then
		playerFolder.Parent = (enable and PetsFolder) or (PetsStorage)
	end
end

function Pet:ToggleAllPets(enable : boolean, exceptFor : Player?)
	if enable then
		for _, playerFolder in pairs(PetsStorage:GetChildren()) do
			if not exceptFor or playerFolder.Name ~= tostring(exceptFor.UserId) then
				playerFolder.Parent = PetsFolder
			end
		end
	else
		for _, playerFolder in pairs(PetsFolder:GetChildren()) do
			if not exceptFor or playerFolder.Name ~= tostring(exceptFor.UserId) then
				playerFolder.Parent = PetsStorage
			end
		end
	end
end

function Pet:KnitInit()
	local RayParams = RaycastParams.new()
	local RayDirection = Vector3.new(0, -500, 0)

	local function GetRowWidth(currentRow, petSize)
		if petSize then
			local spacingBetweenPets = self.Spacing - petSize.X
			local rowWidth = 0
			
			if #currentRow == 1 then
				return 0
			end
			
			for i, v in pairs(currentRow) do
				if i ~= #currentRow then
					rowWidth += petSize.X + spacingBetweenPets
				else
					rowWidth += petSize.X
				end
			end
			
			return rowWidth
		end
	end
	
	RunService.Heartbeat:Connect(function()
		if PetsFolder then
			for _, playerFolder in pairs(PetsFolder:GetChildren()) do
				if playerFolder:IsA("Folder") then
					local player = Players:GetPlayerByUserId(tonumber(playerFolder.Name))
					local character = player and player.Character
					local hrt = character and character:FindFirstChild("HumanoidRootPart")
					local hrtCFrame = hrt and hrt.CFrame
					local humanoid = hrtCFrame and character:FindFirstChildWhichIsA("Humanoid")
					
					if humanoid then
						local Pets = {}
						local Rows = {}
						
						for _, v in pairs(playerFolder:GetChildren()) do
							table.insert(Pets, v)
						end
						
						RayParams.FilterDescendantsInstances = {PetsFolder, character}
						RayParams.RespectCanCollide = true
						
						local maxRowCapacity = math.ceil(math.sqrt(#Pets))
						local amountOfRows = math.ceil(#Pets / maxRowCapacity)

						for i = 1, amountOfRows do
							table.insert(Rows, {})
						end

						for i, v in pairs(Pets) do
							local currentRow = Rows[math.ceil(i / maxRowCapacity)]
							table.insert(currentRow, v)
						end
						
						for i, currentPet in pairs(Pets) do
							local primaryPart = currentPet.PrimaryPart
							local petCFrame = primaryPart and primaryPart.CFrame
							local petSize = primaryPart and primaryPart.Size
							
							if petCFrame and petSize then
								local rowIndex = math.ceil(i / maxRowCapacity)
								local currentRow = Rows[rowIndex]
								local rowWidth = GetRowWidth(currentRow, petSize)
								local xOffset = #currentRow == 1 and 0 or rowWidth / 2 - petSize.X / 2
								local rayResult = workspace:Blockcast(petCFrame + Vector3.new(0, self.MaxClimbHeight, 0), petSize, RayDirection, RayParams)
								local tblFind = table.find(currentRow, currentPet)
								
								if tonumber(tblFind) then
									local X = (tblFind - 1) * self.Spacing
									local Z = rowIndex * self.Spacing
									local Y = ((rayResult and rayResult.Position.Y + petSize.Y / 2) or (0))
									local targetCFrame = CFrame.new(hrtCFrame.X, 0, hrtCFrame.Z) * hrtCFrame.Rotation * CFrame.Angles(0, math.rad(-90), 0) * CFrame.new(Z, Y, X - xOffset)
									
									primaryPart.Anchored = false
									
									if (hrt.Position - primaryPart.Position).Magnitude >= 30 or hrt.Position.Y - primaryPart.Position.Y > 15 then
										primaryPart.CFrame = hrt.CFrame
									elseif Y ~= 0 then
										primaryPart.CFrame = petCFrame:Lerp(targetCFrame, 0.1)
									end
								else
									primaryPart.Anchored = true
								end
							end
						end
					end
				end
			end
		end
	end)
	
	print(script.Name .. " initialized")
end

function Pet:KnitStart()
	print(script.Name .. " started")
end

return Pet