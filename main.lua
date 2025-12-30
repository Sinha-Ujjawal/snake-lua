local snake = require("./snake")
local apple = require("./apple")
local bbox = require("./bbox")
local direction = require("./direction")
local tableUtils = require("./tableUtils")

local lick = require("./libraries/LICK/lick")
lick.reset = true
lick.updateAllFiles = true
lick.clearPackages = true

---@class GameState
---@field snake Snake
---@field snakeTimer number
---@field apple Vector2

---@type GameState
local gameState = {
	snake = snake.initial(),
	snakeTimer = 0,
	apple = apple.random(),
}

---This function is called exactly once at the beginning of the game.
---@param arg table
---@param unfilteredArg table
function love.load(arg, unfilteredArg)
	_ = arg -- UNUSED
	_ = unfilteredArg -- UNUSED
	math.randomseed(os.time()) -- Seed random number
	gameState.snake = snake.initial()
	gameState.snakeTimer = 0
end

---Callback function used to draw on the screen every frame.
function love.draw()
	snake.draw(gameState.snake)
	apple.draw(gameState.apple)
end

---Callback function used to update the state of the game every frame.
---@param dt number delta time in milliseconds
function love.update(dt)
	gameState.snakeTimer = gameState.snakeTimer + dt
	if gameState.snakeTimer >= 0.05 then
		snake.move(gameState.snake)
		gameState.snakeTimer = 0
	end
	local snakeBbox = snake.headBbox(gameState.snake)
	local appleBbox = apple.bbox(gameState.apple)
	if bbox.checkCollision(snakeBbox, appleBbox) then
		snake.grow(gameState.snake)
		gameState.apple = apple.random()
	else
		for i, bb in ipairs(snake.tailBboxes(gameState.snake)) do
			if bbox.checkCollision(snakeBbox, bb) then
				gameState.snake.body = tableUtils.islice(gameState.snake.body, i)
				break
			end
		end
	end
end

---Callback function triggered when a keyboard key is released.
---@param key love.KeyConstant
---@param scancode love.Scancode
function love.keyreleased(key, scancode)
	_ = scancode -- UNUSED
	if key == "down" then
		snake.turnOrthogonal(gameState.snake, direction.south)
	elseif key == "up" then
		snake.turnOrthogonal(gameState.snake, direction.north)
	elseif key == "left" then
		snake.turnOrthogonal(gameState.snake, direction.west)
	elseif key == "right" then
		snake.turnOrthogonal(gameState.snake, direction.east)
	end
end
