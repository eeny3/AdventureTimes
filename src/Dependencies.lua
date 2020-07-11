Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

nata = require 'lib/nata'
bump = require 'lib/bump'

player = require 'src/entities/player'
tile = require 'src/entities/tile'
enemy = require 'src/entities/enemy'

require 'src/LevelMaker'
require 'src/Util'
require 'src/constants'
require 'src/Animation'
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/StartState'
require 'src/states/PlotState'
require 'src/states/EndState'
require 'src/states/GameOverState'
require 'src/StateMachine'

gTextures = {
    ['characterSheet'] = love.graphics.newImage('graphics/finn.png'),
    ['background'] = love.graphics.newImage('graphics/bg.png'),
    ['doge'] = love.graphics.newImage('graphics/doge.png'),
    ['jake'] = love.graphics.newImage('graphics/jake.png'),
    ['enemy1'] = love.graphics.newImage('graphics/enemy1.png'),
    ['enemy2'] = love.graphics.newImage('graphics/enemy2.png'),
    ['enemy3'] = love.graphics.newImage('graphics/enemy3.png'),
    ['heart'] = love.graphics.newImage('graphics/heart.png')
}

gFrames = {
    ['characterSheet'] = GenerateQuads(gTextures['characterSheet'], CHARACTER_WIDTH, CHARACTER_HEIGHT),
    ['doge'] = GenerateQuads(gTextures['doge'], 128, 118),
    ['enemy1'] = GenerateQuads(gTextures['enemy1'], CHARACTER_WIDTH, CHARACTER_HEIGHT),
    ['enemy2'] = GenerateQuads(gTextures['enemy2'], CHARACTER_WIDTH, CHARACTER_HEIGHT),
    ['enemy3'] = GenerateQuads(gTextures['enemy3'], CHARACTER_WIDTH, CHARACTER_HEIGHT)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}