local bbox = {}

---@class BBox
---@field x number
---@field y number
---@field width number
---@field height number

---Returns a new BBox
---@param x number
---@param y number
---@param width number
---@param height number
---@return BBox
function bbox.new(x, y, width, height)
	return { x = x, y = y, width = width, height = height }
end

---Get the BBox of a circle
---@param x number
---@param y number
---@param radius number
---@return BBox
function bbox.ofCircle(x, y, radius)
	local bx = x - radius
	local by = y - radius
	local size = 2 * radius
	return bbox.new(bx, by, size, size)
end

---Checks if two BBox are colliding using Simple AABB (Axis-Aligned Bounding Box) Detection
---@param bbox1 BBox
---@param bbox2 BBox
---@return boolean
function bbox.checkCollision(bbox1, bbox2)
	return bbox1.x < bbox2.x + bbox2.width
		and bbox1.x + bbox1.width > bbox2.x
		and bbox1.y < bbox2.y + bbox2.height
		and bbox1.y + bbox1.height > bbox2.y
end

return bbox
