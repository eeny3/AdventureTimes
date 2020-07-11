require 'src/Dependencies'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 576
VIRTUAL_HEIGHT = 324

pool = nata.new {
  groups = {
    alive = {filter = {'alive'}},
    enemy = {filter = {'state'}}
  },

  systems = {
 	nata.oop(),
	require 'src/systems/PlayerSystem',
    require 'src/systems/EnemySystem'
  }
}

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.graphics.setFont(gFonts['medium'])
    love.window.setTitle('Adventure Times')

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    	fullscreen = false,
        resizable = true,
        vsync = true
    })

    cameraScroll = 0

    love.keyboard.keysPressed = {}

    world = bump.newWorld(32)

    world:add(player, player.x,player.y,player.w,player.h)

    idle = Animation {
        frames = {1,2,3,4,5,6,7,8,9},
        interval = 0.2
    }

    moving = Animation {
        frames = {10, 11, 12, 13, 14, 15},
        interval = 0.15
    }

    jump = Animation {
        frames = {16},
        interval = 1
    }

    attack = Animation {
        frames = {24,25,26,27,28},
        interval = 0.05
    }

    hurt = Animation {
        frames = {17, 18},
        interval = 0.3
    }

    currentAnimation = idle
    direction = 'right'

    white = enemy(448 + 32,256 - 32 + 7, 'enemy1')
    pool:queue(white)
    world:add(white, white.x,white.y,white.w,white.h)

    yellow = enemy(1408 + 32, 32, 'enemy2')
    pool:queue(yellow)
    world:add(yellow, yellow.x,yellow.y,yellow.w,yellow.h)

    blue = enemy(2496, 256, 'enemy3')
    pool:queue(blue)
    world:add(blue, blue.x,blue.y,blue.w,blue.h)

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['plot'] = function() return PlotState() end,
        ['play'] = function() return PlayState() end,
        ['end'] = function() return EndState() end,
        ['game-over'] = function() return GameOverState() end
    }

    gStateMachine:change('start')
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
	gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
	push:start()
	gStateMachine:render()
    push:finish()
end
