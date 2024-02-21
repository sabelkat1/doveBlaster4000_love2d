-- gameManager.lua

local player = require "player"
local enemy = require "enemy"
local weapon = require "weapon"
local event = require "event"
local colors = require "UtillityFunctions.colors"
local inputManager = require "inputManager"
local collision = require "collision"

local gameManager = {
    score = 0
}

function gameManager.load()
    print('gameManager started...')
    player.load()
    enemy.load()
    weapon.load()
    inputManager.load()
    --print(colors.ColorPalette_pico8Micro('green'))
    --colors.ColorPalette_pico8Micro('green')
    love.graphics.setBackgroundColor(0, 212/255, 59/255)
    --subscribe to a event. the function is called every time a playerCollision is published
    --even though this is placed in the load function, if you move this to the update function is can be called 900-1000 times for each published event.
    --so keep events subscribtion in the load function 
    event.subscribe("increaseScore", function(score)
        gameManager.incrementScore(score)
        --gameManager.incrementScore()
    end)
    -- Additional game manager initialization if needed
end

function gameManager.update(dt)
    player.update(dt)
    enemy.update(dt)
    weapon.update(dt)
    inputManager.update(dt)
    collision.update()

      -- Game manager update logic
    
    -- Additional game manager update logic if needed
end

function gameManager.draw()
    player.draw()
    enemy.draw()
    weapon.draw()
    inputManager.draw()
    
    colors.ColorPalette_pico8Micro('yellow')
    love.graphics.print(gameManager.score, 50,20)
    colors.ColorPalette_pico8Micro('white')
    -- Additional game manager drawing logic if needed
end

function gameManager.spawnEnemy(x, y)
    enemy.create(x, y)
end

function gameManager.incrementScore(scoreIncrement)
    --if no scoreIncrement is added, then we just want to add 1
    if scoreIncrement == nill then
        gameManager.score = gameManager.score + 1
    else
        gameManager.score = gameManager.score + scoreIncrement
    end
    
    --print("Score: " .. gameManager.score)
end


return gameManager
