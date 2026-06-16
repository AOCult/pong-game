-- Global variables
function love.load()
    love.window.setMode(800, 600)
    
    -- Paddle dimensions
    paddleWidth = 10
    paddleHeight = 100
    
    -- Paddle positions
    player1Y = 250
    player2Y = 250
    
    -- Ball position and velocity
    ballX = 400
    ballY = 300
    ballDX = 300
    ballDY = 300
    
    -- Scores
    player1Score = 0
    player2Score = 0
end

function love.update(dt)
    -- Player 1 movement (W and S keys)
    if love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y - 500 * dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(500, player1Y + 500 * dt)
    end

    -- Player 2 movement (Up and Down arrows)
    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y - 500 * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(500, player2Y + 500 * dt)
    end

    -- Ball movement
    ballX = ballX + ballDX * dt
    ballY = ballY + ballDY * dt

    -- Ball collision with top and bottom
    if ballY <= 0 or ballY >= 590 then
        ballDY = -ballDY
    end

    -- Ball collision with paddles
    -- Check collision with Player 1
    if ballX <= 20 and ballY >= player1Y and ballY <= player1Y + paddleHeight then
        ballDX = -ballDX * 1.1 -- Bounce and speed up
    end
    -- Check collision with Player 2
    if ballX >= 770 and ballY >= player2Y and ballY <= player2Y + paddleHeight then
        ballDX = -ballDX * 1.1 -- Bounce and speed up
    end

    -- Scoring
    if ballX < 0 then
        player2Score = player2Score + 1
        ballX, ballY = 400, 300
        ballDX = 300
    elseif ballX > 800 then
        player1Score = player1Score + 1
        ballX, ballY = 400, 300
        ballDX = -300
    end
end

function love.draw()
    -- Draw paddles
    love.graphics.rectangle('fill', 10, player1Y, paddleWidth, paddleHeight)
    love.graphics.rectangle('fill', 780, player2Y, paddleWidth, paddleHeight)
    
    -- Draw ball
    love.graphics.rectangle('fill', ballX, ballY, 10, 10)
    
    -- Draw scores
    love.graphics.print("Player 1: " .. player1Score, 200, 20)
    love.graphics.print("Player 2: " .. player2Score, 500, 20)
end