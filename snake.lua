local snake = {}

local vector2 = require("./vector2")
local bbox = require("./bbox")
local direction = require("./direction")
local loveUtils = require("./loveUtils")
local conf = require("./conf")
local mathUtils = require("./mathUtils")

snake.BODY_RADIUS = 5
snake.BODY_COLOR = loveUtils.colorFromBytes(128, 0, 128)
snake.HEAD_COLOR = loveUtils.colorFromBytes(0, 255, 255)
snake.BODY_BBOX_SNUG = 0.8

---@class Snake
---@field body     Vector2[]
---@field velocity Vector2
---@field wrap     Vector2

---Initialize a new Snake
---@param pos    Vector2
---@param length number
---@param dir    Direction
---@return Snake
function snake.new(pos, length, dir)
	---@type Vector2[]
	local SnakeBody = {}
	local currPos = pos
	local dirVec = vector2.scalerProjection(direction.east(snake.BODY_RADIUS * 2), dir(1))
	for _ = 1, length do
		SnakeBody[#SnakeBody + 1] = currPos
		currPos = vector2.add(currPos, dirVec)
	end
	local wrap = vector2.new(conf.WIDTH, conf.HEIGHT)
	return { body = SnakeBody, velocity = dirVec, wrap = wrap }
end

---Returns you an initial Snake
---@return Snake
function snake.initial()
	return snake.new(vector2.new(10, 10), 3, direction.east)
end

---Grow the snake in the current direction
---@param snk Snake
function snake.grow(snk)
	local head = snk.body[#snk.body]
	local newHead = vector2.mod(vector2.add(head, snk.velocity), snk.wrap)
	snk.body[#snk.body + 1] = newHead
end

---Move the snake in the current direction
---@param snk Snake
function snake.move(snk)
	snake.grow(snk)
	table.remove(snk.body, 1)
end

---Turn the snake to its left
---@param snk Snake
function snake.turnLeft(snk)
	snk.velocity = vector2.rotate(snk.velocity, -math.pi / 2)
end

---Turn the snake to its right
---@param snk Snake
function snake.turnRight(snk)
	snk.velocity = vector2.rotate(snk.velocity, math.pi / 2)
end

---Turn the snake orthogonally based on the direction
---@param snk Snake
---@param dir Direction
function snake.turnOrthogonal(snk, dir)
	local angle = vector2.angle(snk.velocity, dir(1))
	if mathUtils.areNear(angle, math.pi / 2) then
		snake.turnRight(snk)
	elseif mathUtils.areNear(angle, -math.pi / 2) then
		snake.turnLeft(snk)
	end
end

---Draws the snake using love2d
---@param snk Snake
function snake.draw(snk)
	for idx, snakeBody in ipairs(snk.body) do
		local color = snake.BODY_COLOR
		if idx == #snk.body then
			color = snake.HEAD_COLOR
		end
		loveUtils.drawWithColor(color, function()
			love.graphics.circle("fill", snakeBody.x, snakeBody.y, snake.BODY_RADIUS)
		end)
	end
	if conf.DRAW_BBOX then
		local hbb = snake.headBbox(snk)
		loveUtils.drawWithColor(conf.BBOX_COLOR, function()
			love.graphics.rectangle("line", hbb.x, hbb.y, hbb.width, hbb.height)
		end)
		for _, bb in ipairs(snake.tailBboxes(snk)) do
			loveUtils.drawWithColor(conf.BBOX_COLOR, function()
				love.graphics.rectangle("line", bb.x, bb.y, bb.width, bb.height)
			end)
		end
	end
end

---Returns the bbox for the snake's head. Specifically this can be used for collision detection
---@param snk Snake
---@return BBox
function snake.headBbox(snk)
	local head = snk.body[#snk.body]
	return bbox.ofCircle(head.x, head.y, snake.BODY_RADIUS * snake.BODY_BBOX_SNUG)
end

---Returns the array of bbox for the snake's tail. Specifically this can be used for collision detection
---@param snk Snake
---@return BBox[]
function snake.tailBboxes(snk)
	---@type BBox[]
	local bboxes = {}
	for i = 1, #snk.body - 1 do
		local body = snk.body[i]
		bboxes[i] = bbox.ofCircle(body.x, body.y, snake.BODY_RADIUS * snake.BODY_BBOX_SNUG)
	end
	return bboxes
end

return snake
