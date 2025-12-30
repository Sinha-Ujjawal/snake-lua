local vector2 = {}

---@class Vector2
---@field x number
---@field y number

---Returns a new 2d vector
---@param x number
---@param y number
---@return Vector2
function vector2.new(x, y)
	return { x = x, y = y }
end

---Returns a new random 2d vector within a range
---@param xlow number lowest possible x value
---@param xhigh number highest possible x value
---@param ylow number lowest possible y value
---@param yhigh number highest possible y value
---@return Vector2 vec random vector sampled from [xlow .. xhigh] and [ylow .. yhigh]
function vector2.random(xlow, xhigh, ylow, yhigh)
	return { x = math.random(xlow, xhigh), y = math.random(ylow, yhigh) }
end

---Return clone of 2d vector
---@param vec Vector2
---@return Vector2
function vector2.clone(vec)
	return { x = vec.x, y = vec.y }
end

---Return -vec
---@param vec Vector2
---@return Vector2
function vector2.negate(vec)
	return { x = -vec.x, y = -vec.y }
end

---Return magnitude of the Vector2
---@param vec Vector2
---@return number
function vector2.mag(vec)
	return math.sqrt(vector2.dot(vec, vec))
end

---Return vec1 + vec2
---@param vec1 Vector2
---@param vec2 Vector2
---@return Vector2
function vector2.add(vec1, vec2)
	return { x = vec1.x + vec2.x, y = vec1.y + vec2.y }
end

---Return vec1 - vec2
---@param vec1 Vector2
---@param vec2 Vector2
---@return Vector2
function vector2.sub(vec1, vec2)
	return { x = vec1.x - vec2.x, y = vec1.y - vec2.y }
end

---Return vec1 `dot` vec2
---@param vec1 Vector2
---@param vec2 Vector2
---@return number
function vector2.dot(vec1, vec2)
	return (vec1.x * vec2.x) + (vec1.y * vec2.y)
end

---Return vec * scaler
---@param vec Vector2
---@param scale number
---@return Vector2
function vector2.scaleBoth(vec, scale)
	return { x = vec.x * scale, y = vec.y * scale }
end

---Return vec * scale
---@param vec Vector2
---@param scale Vector2
---@return Vector2
function vector2.scale(vec, scale)
	return { x = vec.x * scale.x, y = vec.y * scale.y }
end

---Return scaler projection of vec1 in direction of vec2
---(vec1 `dot` vec2) / mag(vec2)
---@param vec1 Vector2
---@param vec2 Vector2
---@return Vector2
function vector2.scalerProjection(vec1, vec2)
	local mag = vector2.dot(vec1, vec2) / vector2.mag(vec2)
	return vector2.scaleBoth(vec2, mag)
end

---Return pairwise modulus between two vectors
---@param vec1 Vector2
---@param vec2 Vector2
---@return Vector2
function vector2.mod(vec1, vec2)
	return { x = vec1.x % vec2.x, y = vec1.y % vec2.y }
end

---Return the rotated vector by a given angle
---@param vec Vector2
---@param theta number angle in radians
---@return Vector2
function vector2.rotate(vec, theta)
	local cosTheta = math.cos(theta)
	local sinTheta = math.sin(theta)
	return { x = vec.x * cosTheta - vec.y * sinTheta, y = vec.x * sinTheta + vec.y * cosTheta }
end

---Returns the angle between two vectors in radians
---@param vec1 Vector2
---@param vec2 Vector2
---@return number signed angle in radians
function vector2.angle(vec1, vec2)
	local x1, y1 = vec1.x, vec1.y
	local x2, y2 = vec2.x, vec2.y
	return math.atan2(x1 * y2 - y1 * x2, x1 * x2 + y1 * y2)
end

return vector2
