PlotState = Class{__includes = BaseState}

function PlotState:init()
end

function PlotState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function PlotState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    love.graphics.draw(gTextures['background'], 320, 0) 
    gMap:draw()
    
    love.graphics.draw(gTextures['jake'], 90, 200, 0, 0.5, 0.5)
    love.graphics.setColor(1, 1, 1, 0.9)
    love.graphics.rectangle('fill', 200, 170, 150, 100)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print('Hey, Finn!', 240, 180)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print('Collect all the loot', 210, 200)
    love.graphics.print('and meet me on the other end', 210, 210)
    love.graphics.print('HURRY UP!', 210, 220)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('press enter', 210, 240)
    love.graphics.setColor(1, 1, 1, 1)
end