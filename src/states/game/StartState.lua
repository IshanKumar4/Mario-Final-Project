--[[
    GD50
    Super Mario Bros. Remake

    -- StartState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

StartState = Class{__includes = BaseState}

textures = {'green-alien', 'blue-alien', 'pink-alien'}
playerTexture = 'green-alien'
selectedTexture = 1

function StartState:init()
    self.map = LevelMaker.generate(100, 10)
    self.background = math.random(3)
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end

    if love.keyboard.wasPressed('right') then
        if selectedTexture == 3 then
            selectedTexture = 1
            playerTexture = textures[selectedTexture]
        else
            selectedTexture = selectedTexture + 1
            playerTexture = textures[selectedTexture]
        end
    end

    if love.keyboard.wasPressed('left') then
        if selectedTexture == 1 then
            selectedTexture = 3
            playerTexture = textures[selectedTexture]
        else
            selectedTexture = selectedTexture - 1
            playerTexture = textures[selectedTexture]
        end
    end
end

function StartState:render()
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0, 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0,
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    self.map:render()

    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Super 50 Bros.', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Super 50 Bros.', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press Enter', 1, VIRTUAL_HEIGHT / 2 + 17, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')

    love.graphics.draw(gTextures[playerTexture], gFrames[playerTexture][1], 15, 15)
end