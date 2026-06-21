local typer = {}

function typer.static(callbackFunction : (any?) -> any?)
	local self = {}
	local parameterAssertion = nil
	local returnAssertion = nil
	
	function self.withParameterTypes(...)
		parameterAssertion = typer.tupleAssertion(...)
		return self
	end
	
	function self.withReturnTypes(...)
		returnAssertion = typer.tupleAssertion(...)
		return self
	end
	
	function self.asserted()
		if parameterAssertion and returnAssertion then
			return function(...)
				local args = {...}
				
				if parameterAssertion then
					parameterAssertion(unpack(args))
				end
				
				local returnedValues = {callbackFunction(...)}

				if returnAssertion then
					local success, output = pcall(function()
						returnAssertion(unpack(returnedValues))
					end)

					if not success then
						error(`An error occurred when expecting return types from static function: {output}`)
					end
				end
				
				return unpack(returnedValues)
			end
		end
	end
	
	return self
end

function typer.cast(value : any) : () -> any
	return function(... : string) : any
		if not table.find({...}, typeof(value)) then
			error(`Expected casted value to be a {table.concat({...}, ", or ")}, instead got a {typeof(value)} type`)
		end
		
		return value
	end
end

function typer.casteq(a : any, b : any)
	if typeof(a) ~= typeof(b) then
		error(`Attempted to compare a {typeof(a)} to a {typeof(b)}`)
	end
	
	return a == b
end

function typer.tupleAssertion(... : string)
	local types = {...}
	
	return function(... : any)
		local args = {...}
		
		for index, type_ in types do
			if typeof(args[index]) ~= type_ then
				error(`Tuple #{index} in function does not match type; expected a {type_}, got a {typeof(args[index])}.`)
			end
		end
	end
end

function typer.expect(... : any)
	local self = {}
	
	local args = {...}
	local success, output
	
	function self.toBe(... : string)
		local types = {...}
		
		success, output = pcall(function()
			typer.tupleAssertion(unpack(types))(unpack(args))
		end)
		
		return self
	end
	
	function self.andIfNot(callback : (any?) -> nil)
		if not success then
			callback(output)
		end
		
		return self
	end
	
	function self.andIfSo(callback : (any?) -> nil)
		if success then
			callback(output)
		end
		
		return self
	end
	
	return self
end

function typer.env() : typeof(setmetatable({},{}))
	local self = {}
	
	return setmetatable({}, {
		__index = function(_, index)
			if not self[index] then
				warn(`Attemped to access an immutable value named "{index}" but it does not exist, returning nil`)
			end
			
			return self[index]
		end,
		
		__newindex = function(_, index, value)
			if self[index] then
				error("Attemped to modify an immutable value")
			end
			
			self[index] = value
			
			if typeof(value) == "Instance" then
				value.AncestryChanged:Connect(function()
					if value:FindFirstAncestor(game) == nil then
						self[index] = nil
					end
				end)
			end
		end,
		
		__call = function(_, command, ...)
			({
				dumpAll = function()
					self = {}
				end,
				
				dumpValue = function(index)
					self[index] = nil
				end,
				
				printAll = function()
					print(self)
				end,
				
				printValue = function(index)
					print(self[index])
				end,
			})[command](...)
		end,
	})
end

return typer