local PlayerSystem = {}

function PlayerSystem:load()
end

function PlayerSystem:update(dt)
    if love.keyboard.wasPressed('space') and player.dy == 0 then
        currentAnimation = jump
        player.dy = PLAYER_JUMP_VELOCITY
    end
    player.dy = player.dy + GRAVITY

    if love.keyboard.isDown('left') then
        player.x, player.y, cols, cols_len = world:move(player, player.x - PLAYER_WALK_SPEED*dt, player.y + player.dy * dt)
        if #cols>0 then
            player.dy = 0
        end
        for k = 1, cols_len do
            if cols[k].other.tag == 2 then
                world:remove(cols[k].other)
                if cols[k].other.loot == 1 then
                    loot1 = false
                    player.loots = player.loots + 1
                elseif cols[k].other.loot == 2 then
                    loot2 = false
                    player.loots = player.loots + 1
                elseif cols[k].other.loot == 3 then
                    loot3 = false
                    player.loots = player.loots + 1
                elseif cols[k].other.loot == 4 then
                    loot4 = false
                    player.loots = player.loots + 1
                else
                    loot5 = false
                    player.loots = player.loots + 1
                end
            end
        end
        if player.dy == 0 then
            if not (currentAnimation == attackAnimation) then
                currentAnimation = moving
            end
        end
        direction = 'left'
    elseif love.keyboard.isDown('right') then
        player.x, player.y, cols, cols_len = world:move(player, player.x + PLAYER_WALK_SPEED*dt, player.y + player.dy * dt)
        if #cols>0 then
            player.dy = 0
        end
        for k = 1, cols_len do
            if cols[k].other.tag == 2 then
                world:remove(cols[k].other)
                if cols[k].other.loot == 1 then
                    loot1 = false
                    player.loots = player.loots + 1
                elseif cols[k].other.loot == 2 then
                    loot2 = false
                    player.loots = player.loots + 1
                elseif cols[k].other.loot == 3 then
                    loot3 = false
                    player.loots = player.loots + 1
                elseif cols[k].other.loot == 4 then
                    loot4 = false
                    player.loots = player.loots + 1
                else
                    loot5 = false
                    player.loots = player.loots + 1
                end
            end
        end
        if player.dy == 0 then
            if not (currentAnimation == attack) then
                currentAnimation = moving
            end
        end
        direction = 'right'
    elseif not (currentAnimation == attack) then
        player.x, player.y, cols, cols_len = world:move(player, player.x, player.y + player.dy * dt)
        if #cols>0 then
            player.dy = 0
        end
        currentAnimation = idle
    end

    if love.keyboard.isDown('up') and ((player.x >= 1024 and player.x <= 1061) or 
                                        (player.x >= 1376 and player.x <= 1413) or
                                        (player.x >= 3040 and player.x <= 3077)) then

        player.y = player.y - 1 - GRAVITY
    end
end

function PlayerSystem:draw()
    love.graphics.draw(gTextures[player.texture], gFrames[player.texture][currentAnimation:getCurrentFrame()], 
        math.floor(player.x) + player.w / 2,  math.floor(player.y) + 9, 
        0, 
        direction == 'left' and -1 or 1, 1, player.w / 2, player.h/2)
    love.graphics.setColor(1,1,1,1)
end

return PlayerSystem