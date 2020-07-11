local EnemySystem = {}

enemyMovingR = Animation {
    frames = {1, 2, 3, 4, 5, 6},
    interval = 0.15
}

enemyMovingL = Animation {
    frames = {7, 8, 9, 10,11, 12},
    interval = 0.15
}

curEnemyAn = enemyMovingR
enemySpeed = 80

function EnemySystem:load()
end

function EnemySystem:update(dt)
    for _, e in ipairs(self.pool.groups.enemy.entities) do
        if curEnemyAn == enemyMovingR then
            e.x, e.y, cols, cols_len = world:move(e, e.x + enemySpeed*dt, e.y)
            for i = 1, cols_len do
                if cols[i].other == player then
                    curEnemyAn = enemyMovingL
                    player.x = player.x + 5
                    currentAnimation = hurt
                    player.health = player.health - 1 
                else
                    curEnemyAn = enemyMovingL
                end
            end
        else
            if e.x <= 448 then
                curEnemyAn = enemyMovingR
            end
            e.x, e.y, cols, cols_len = world:move(e, e.x - enemySpeed*dt, e.y)
            for i = 1, cols_len do
                if cols[i].other == player then
                    curEnemyAn = enemyMovingR
                    player.x = player.x - 5
                    currentAnimation = hurt
                    player.health = player.health - 1
                end
            end
        end
    end
end

function EnemySystem:draw()
    for _, e in ipairs(self.pool.groups.enemy.entities) do
        if e.dead == false then
            love.graphics.draw(gTextures[e.texture], gFrames[e.texture][curEnemyAn:getCurrentFrame()], math.floor(e.x - 5), math.floor(e.y - 5))
        end
    end
end

return EnemySystem