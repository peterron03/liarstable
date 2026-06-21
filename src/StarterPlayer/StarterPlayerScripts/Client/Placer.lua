local module = {}

--Snap vector to cardinal unit length vector such as (1, 0, 0)
local function VecSnap(norm : Vector3)
	if math.abs(norm.X) > math.max(math.abs(norm.Y), math.abs(norm.Z)) then
		return Vector3.xAxis * math.sign(norm.X)
	elseif math.abs(norm.Y) > math.abs(norm.Z) then
		return Vector3.yAxis * math.sign(norm.Y)
	else
		return Vector3.zAxis * math.sign(norm.Z)
	end
end

function module.GridPlacer()
	local placer = {}
	
	--Grid size
	placer.GridSize = 0.1
	
	--Cylinder snap options
	placer.CylinderSnapOptions = {}
	placer.UseCylinderAngleSnap = true
	
	--Rotation options
	local fineRotation = CFrame.new()
	local snapGridTransform = CFrame.new()
	
	--Arbitrary lookup for an "up" direction on a given surface normal
	local normalToUpArbitrary = {
		[Vector3.xAxis] = Vector3.yAxis,
		[-Vector3.xAxis] = Vector3.yAxis,
		[Vector3.zAxis] = Vector3.yAxis,
		[-Vector3.zAxis] = Vector3.yAxis,
		[Vector3.yAxis] = Vector3.zAxis,
		[-Vector3.yAxis] = Vector3.zAxis
	}

	--Rotate the above mapping 90 degrees right handed for each element
	--This is the preferred way to rotate by 90 degrees because it is exact (other rotations are not exact)
	function placer.RotateUpMapping()
		for input, up in pairs(normalToUpArbitrary) do
			normalToUpArbitrary[input] = input:Cross(up)
		end
	end
	
	--Set an additional rotation component for placement
	--Note that this is in surface space as defined in SnapSurfaceCFrame (-Z axis is normal)
	function placer.SetFineRotation(rot : CFrame)
		fineRotation = rot
	end
	
	-- gets the rotation
	function placer.GetFineRotation()
		return fineRotation
	end
	
	--Set the rotation of the entire system including the snap grid
	--Note this does NOT need touched for placement on sloped surfaces
	--This rotates the SNAP GRID relative to the surface. Most likely you do NOT want to change this
	function placer.SetGridTransform(rot : CFrame)
		snapGridTransform = rot
	end
	
	--Set evenly spaced radial angles for snapping to cylinders
	function placer.SetEvenRadialSnapping(numberOfSnaps : number)
		for i = 1, numberOfSnaps do
			local angle = 2 * math.pi * (i - 1) / numberOfSnaps
			table.insert(placer.CylinderSnapOptions, Vector3.new(0, math.cos(angle), math.sin(angle)))
		end
	end
	
	--Default 8 snap angles
	placer.SetEvenRadialSnapping(8)
	
	--Return a CFrame that sits on the surface of the raycast result instance surface and is snapped to this Placer's grid
	function placer.SnapSurfaceCFrame(result : RaycastResult)
		if result == nil then
			error("RaycastResult input must not be nil")
		end
		
		--Result and target components
		local target = result.Instance
		local position = target.Position
		local normal = result.Normal
		local aimpoint = result.Position
		
		--Normal in target part's space
		local partLocalNormal = target.CFrame:VectorToObjectSpace(normal)
		
		--Optional radial angle snap for cylinders
		if placer.UseCylinderAngleSnap and target:IsA("Part") and target.Shape == Enum.PartType.Cylinder then
			--If this is the end of the cylinder the normal will be +/- X
			if math.abs(VecSnap(partLocalNormal).X) ~= 1 then
				
				--Otherwise it will be some (0, a, b)
				local bestNormal = nil
				local bestDot = -1
				
				--Find local snappable direction that is closest to result Normal
				--This can be simpler if snap angles are mirrored but who cares
				for _, snapNormal in ipairs(placer.CylinderSnapOptions) do
					local dot = snapNormal:Dot(partLocalNormal)
					
					if bestNormal == nil or dot > bestDot then
						bestDot = dot
						bestNormal = snapNormal
					end
				end
				
				--Use the most likely normal as if it were the result normal
				partLocalNormal = bestNormal

				--Need to correct aimpoint to be as if we had aimed at that exact point on the cylinder whose normal we just chose
				local targetLocalPosition = target.CFrame:PointToObjectSpace(aimpoint)
				local yzMask = (Vector3.one - Vector3.xAxis)
				local newLocalAimpoint = targetLocalPosition.X * Vector3.xAxis + yzMask * partLocalNormal
				
				--Corrected aimpoint
				aimpoint = target.CFrame:PointToWorldSpace(newLocalAimpoint)
			end
		end
		
		--An arbitrary direction perpendicular to the local normal to establish a space on the part surface with
		local up = normalToUpArbitrary[VecSnap(partLocalNormal)]
		
		--Surface CFrame in part local space. Sits on the parts surface and has its Z axis along the local normal and Y axis in the "up" direction
		local localSurfaceCFrame = CFrame.lookAt(Vector3.zero, partLocalNormal, up)
		
		--That same surface cframe in world space. Note the position vector of this space is not transformed (Important!!)
		--So it still sits on the same point on the part surface
		local surfaceCFrame = (target.CFrame - position):ToWorldSpace(localSurfaceCFrame) + position

		--Convert aimpoint to surface space
		local surfaceLocalPosition = surfaceCFrame:PointToObjectSpace(aimpoint)
		
		--Convert to grid space (usually not used / no effect)
		local gridLocalPosition = snapGridTransform * surfaceLocalPosition
		
		--We want to ignore any snapping in the normal direction
		--Component of local position that is normal to the surface
		--The local normal is always -Z in surface space
		local normalComponent = gridLocalPosition * Vector3.zAxis

		if placer.GridSize ~= 0 then
			gridLocalPosition -= normalComponent

			--Element wise operation
			local function Elw(vec, func)
				return Vector3.new(func(vec.X), func(vec.Y), func(vec.Z))
			end

			gridLocalPosition = Elw(gridLocalPosition, function(v) 
				return math.round(v / placer.GridSize) * placer.GridSize
			end)

			--Re-apply normal component
			gridLocalPosition += normalComponent
		end
		
		surfaceLocalPosition = snapGridTransform:Inverse() * gridLocalPosition
		
		--Good job reading the code, comment this out to stop the spinning
		--fineRotation = CFrame.fromAxisAngle(Vector3.zAxis, time())
		--warn("YOU NEED TO READ THE CODE! I WILL SPIN YOUR PART UNTIL YOU DO!")
		--
		
		--Apply new snapped offset
		--Surface rotation plus the surface position converted to world space
		surfaceCFrame = (surfaceCFrame - position) * fineRotation + surfaceCFrame:PointToWorldSpace(surfaceLocalPosition)
		
		--Return surfaceCFrame and surfaceLocalPosition
		return surfaceCFrame, surfaceLocalPosition
	end
	
	return placer
end

return module
