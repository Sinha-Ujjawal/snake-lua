local conf = {}

conf.TITLE = "Infinite Snake"
conf.WIDTH = 300
conf.HEIGHT = conf.WIDTH -- Keep it same as width to make it a square. The math becomes easier with this
conf.DRAW_BBOX = false -- whether to draw the bbox or not
conf.BBOX_COLOR = { r = 1, g = 1, b = 1, a = 1 }

function love.conf(t)
	t.window.title = conf.TITLE
	t.window.vsync = false
	t.window.fullscreen = false
	t.window.resizable = false
	t.window.width = conf.WIDTH
	t.window.height = conf.HEIGHT
	t.window.refreshrate = 60.0
end

return conf
