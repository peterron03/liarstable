local AccessoryService = {}

function AccessoryService.GetMeshVolume(Accessory)
	local Handle = Accessory and Accessory:FindFirstChild("Handle")
	
	if not Handle then return nil end
	
	local OriginalSize

	if not Handle:FindFirstChildWhichIsA("WrapLayer") then
		OriginalSize = Handle.OriginalSize.Value
	else
		OriginalSize = Handle.Size
	end

	if not OriginalSize then return end

	local X = OriginalSize.X
	local Y = OriginalSize.Y
	local Z = OriginalSize.Z

	return X*Y*Z
end

function AccessoryService.CheckPlayer(Character, MaxVolume: number)
	if Character then
		for _, v in pairs(Character:GetChildren()) do
			if v:IsA("Accessory") then
				local MeshVolume = AccessoryService.GetMeshVolume(v)

				if MeshVolume and MeshVolume > MaxVolume then
					v:Destroy()
				end
			end
		end
	end
end

return AccessoryService