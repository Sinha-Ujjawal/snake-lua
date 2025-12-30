local direction = {}

---@alias Direction fun(mag: number):Vector2

local vector2 = require("./Vector2")

---Return a new Vector2 in North (^) direction with a particular Magnitude
---@param mag number
---@return Vector2
function direction.north(mag)
	return vector2.new(0, -mag)
end

---Return a new Vector2 in South (v) direction with a particular Magnitude
---@param mag number
---@return Vector2
function direction.south(mag)
	return vector2.new(0, mag)
end

---Return a new Vector2 in East (>) direction with a particular Magnitude
---@param mag number
---@return Vector2
function direction.east(mag)
	return vector2.new(mag, 0)
end

---Return a new Vector2 in West (<) direction with a particular Magnitude
---@param mag number
---@return Vector2
function direction.west(mag)
	return vector2.new(-mag, 0)
end

---Return a new Vector2 in North-East (^>) direction with a particular Magnitude
---@param mag number
---@return Vector2
function direction.northEast(mag)
	return vector2.new(mag, -mag)
end

---Return a new Vector2 in North-West (<^) direction with a particular Magnitude
---@param mag number
---@return Vector2
function direction.northWest(mag)
	return vector2.new(-mag, -mag)
end

---Return a new Vector2 in South-East (v>) direction with a particular Magnitude
---@param mag number
---@return Vector2
function direction.southEast(mag)
	return vector2.new(mag, mag)
end

---Return a new Vector2 in South-West (<v) direction with a particular Magnitude
---@param mag number
---@return Vector2
function direction.southWest(mag)
	return vector2.new(-mag, mag)
end

return direction
