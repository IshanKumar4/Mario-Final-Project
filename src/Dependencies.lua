--[[
    GD50
    Super Mario Bros. Remake

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    -- Dependencies --

    A file to organize all of the global dependencies for our project, as
    well as the assets for our game, rather than pollute our main.lua file.
]]

--
-- libraries
--
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

--
-- our own code
--

-- utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'

-- game states
require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'

-- entity states
require 'src/states/entity/PlayerFallingState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerJumpState'
require 'src/states/entity/PlayerWalkingState'

require 'src/states/entity/snail/SnailChasingState'
require 'src/states/entity/snail/SnailIdleState'
require 'src/states/entity/snail/SnailMovingState'

-- general
require 'src/Animation'
require 'src/Entity'
require 'src/GameObject'
require 'src/GameLevel'
require 'src/LevelMaker'
require 'src/Player'
require 'src/Snail'
require 'src/Tile'
require 'src/TileMap'
require 'src/Fireball'


gSounds = {
    ['jump'] = love.audio.newSource('sounds/jump.wav'),
    ['death'] = love.audio.newSource('sounds/death.wav'),
    ['music'] = love.audio.newSource('sounds/music.wav'),
    ['powerup-reveal'] = love.audio.newSource('sounds/powerup-reveal.wav'),
    ['pickup'] = love.audio.newSource('sounds/pickup.wav'),
    ['empty-block'] = love.audio.newSource('sounds/empty-block.wav'),
    ['kill'] = love.audio.newSource('sounds/kill.wav'),
    ['kill2'] = love.audio.newSource('sounds/kill2.wav')
}

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tiles.png'),
    ['toppers'] = love.graphics.newImage('graphics/tile_tops.png'),
    ['bushes'] = love.graphics.newImage('graphics/bushes_and_cacti.png'),
    ['jump-blocks'] = love.graphics.newImage('graphics/jump_blocks.png'),
    ['gems'] = love.graphics.newImage('graphics/gems.png'),
    ['backgrounds'] = love.graphics.newImage('graphics/backgrounds.png'),
    ['green-alien'] = love.graphics.newImage('graphics/green_alien.png'),
    ['creatures'] = love.graphics.newImage('graphics/creatures.png'),
    ['coins'] = love.graphics.newImage('graphics/coins_and_bombs.png'),
    ['fireballs'] = love.graphics.newImage('graphics/fireballs.png'),
    ['fireballAnimation'] = love.graphics.newImage('graphics/red_fireball.png'),
    ['blue-alien'] = love.graphics.newImage('graphics/blue_alien.png'),
    ['pink-alien'] = love.graphics.newImage('graphics/pink_alien.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),
    
    ['toppers'] = GenerateQuads(gTextures['toppers'], TILE_SIZE, TILE_SIZE),
    
    ['bushes'] = GenerateQuads(gTextures['bushes'], 16, 16),
    ['jump-blocks'] = GenerateQuads(gTextures['jump-blocks'], 16, 16),
    ['gems'] = GenerateQuads(gTextures['gems'], 16, 16),
    ['backgrounds'] = GenerateQuads(gTextures['backgrounds'], 256, 128),
    ['green-alien'] = GenerateQuads(gTextures['green-alien'], 16, 20),
    ['creatures'] = GenerateQuads(gTextures['creatures'], 16, 16),
    ['coins'] = GenerateQuads(gTextures['coins'], 16, 16),
    ['fireballs'] = GenerateQuads(gTextures['fireballs'], 16, 16),
    ['fireballAnimation'] = GenerateQuads(gTextures['fireballAnimation'], 16, 16),
    ['blue-alien'] = GenerateQuads(gTextures['blue-alien'], 16, 20),
    ['pink-alien'] = GenerateQuads(gTextures['pink-alien'], 16, 20)
}

-- these need to be added after gFrames is initialized because they refer to gFrames from within
gFrames['tilesets'] = GenerateTileSets(gFrames['tiles'], 
    TILE_SETS_WIDE, TILE_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)

gFrames['toppersets'] = GenerateTileSets(gFrames['toppers'], 
    TOPPER_SETS_WIDE, TOPPER_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}