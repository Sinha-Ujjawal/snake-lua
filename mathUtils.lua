local mathUtils = {}

---Checks if two numbers are near within a given threshold epsilon
---@param a number first number
---@param b number second number
---@param epsilon number? Defaults to 1e-7
---@return boolean
function mathUtils.areNear(a, b, epsilon)
	local epsilon = epsilon or 1e-7 -- Default threshold
	return math.abs(a - b) < epsilon
end

return mathUtils
