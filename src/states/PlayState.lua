PlayState = Class{__includes = BaseState}

function PlayState:enter()
end

function PlayState:update(dt)
    pool:flush()
    pool:emit('update', dt)
    cameraScroll = player.x - (VIRTUAL_WIDTH / 2) + (CHARACTER_WIDTH / 2)
    love.keyboard.keysPressed = {}
    currentAnimation:update(dt)
    curEnemyAn:update(dt)
    Timer.update(dt)
end

function PlayState:render()
    love.graphics.draw(gTextures['background'], 0, 0)
    love.graphics.draw(gTextures['background'], 320, 0)
    love.graphics.draw(gTextures['background'], 640, 0) 
    love.graphics.draw(gTextures['background'], 960, 0) 

    love.graphics.translate(-math.floor(cameraScroll), 0)

    gMap:draw()
    pool:emit 'draw'

    if player.x > 2400 then
        love.graphics.draw(gTextures['doge'], gFrames['doge'][1], 3130 - 32, 28, 0, 0.3, 0.3)
    end

    love.graphics.setFont(gFonts['small'])
    love.graphics.print('loots: '..player.loots, math.floor(player.x - 260), 5)
    for k = 1, player.health do
        love.graphics.draw(gTextures['heart'],math.floor(player.x - 260) + (k-1)*15, 15, 0.05, 0.05)
    end

    if (player.x > 3045 and player.y > 32 and player.y < 64) then
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.print('press F', 3130, 25)
        if love.keyboard.isDown('f') then
            if player.loots == 5 then
                gStateMachine:change('end')
            else
                love.graphics.print('need '.. (5 - player.loots).. ' more loots', 3135, 40)
                love.graphics.setColor(1, 1, 1, 1)
            end
        end
    end

    if player.y > VIRTUAL_HEIGHT then
        gStateMachine:change('game-over')
    end

    if player.health == 0 then
        gStateMachine:change('game-over')
    end
end
