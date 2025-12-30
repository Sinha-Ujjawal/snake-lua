local apple = {}

local loveUtils = require("./loveUtils")
local vector2 = require("./vector2")
local bbox = require("./bbox")
local conf = require("./conf")

apple.PAD = 1
apple.RADIUS = 5
apple.COLOR = loveUtils.colorFromBytes(255, 0, 0)

---Returns a new random apple within the game window
---@return Vector2
function apple.random()
	local xlow = apple.RADIUS + apple.PAD
	local xhigh = conf.WIDTH - apple.RADIUS - apple.PAD
	local ylow = apple.RADIUS + apple.PAD
	local yhigh = conf.HEIGHT - apple.RADIUS - apple.PAD
	return vector2.random(xlow, xhigh, ylow, yhigh)
end

---Draws the apple using love2d
---@param apl Vector2
function apple.draw(apl)
	loveUtils.drawWithColor(apple.COLOR, function()
		love.graphics.circle("fill", apl.x, apl.y, apple.RADIUS)
	end)
	if conf.DRAW_BBOX then
		local bb = apple.bbox(apl)
		loveUtils.drawWithColor(conf.BBOX_COLOR, function()
			love.graphics.rectangle("line", bb.x, bb.y, bb.width, bb.height)
		end)
	end
end

---Returns the bbox for the apple. Specifically this can be used for collision detection
---@param apl Vector2
---@return BBox
function apple.bbox(apl)
	return bbox.ofCircle(apl.x, apl.y, apple.RADIUS * 0.8)
end

return apple
