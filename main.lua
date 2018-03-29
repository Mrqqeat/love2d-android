-- code by Iwan 'qubodup' Gabovitch
-- licesnse/terms: public domain (cc0)
-- meaning do what you want, no credit needed, you can delete this text too
-- video tutorial: https://youtu.be/sArl6wypDfY
-- you can make a bee.png from https://openclipart.org/detail/215877/cartoon-bee

function love.load()
  gw = love.graphics.getWidth() -- game width
  gwp = gw/10 -- game widht "part"

  gh=love.graphics.getHeight()
  ghp = gh/10 -- game height "part"

  b = { -- buttons
    l = {gwp, ghp*2, gwp, ghp*6, 0}, -- left (left edge, top edge, width, height, timer)
    r = {gwp*8, ghp*2, gwp, ghp*6, 0}, -- right
    t = {gwp*2, ghp, gwp*6, ghp, 0}, -- top
    b = {gwp*2, ghp*8, gwp*6, ghp, 0} -- bottom
  }

  freq = 0.25 -- how many seconds until "button" can be pressed again, also visual aid

  -- sample player
  p = { gw/2, gh/2, love.graphics.newImage('bee20small.png') }
  -- sample player
end

function love.draw()
  -- draw buttons
  for i,v in pairs(b) do 
    opacity = 100 + v[5] * 400 -- change opacity over time to indicate
    love.graphics.setColor(255,255,255,opacity)
    love.graphics.rectangle("fill",v[1],v[2],v[3],v[4])
  end

  -- sample player
  love.graphics.setColor(255,255,255)
  love.graphics.draw(p[3],p[1],p[2],0,1,1,40,40)
  -- sample player
end

function love.update(dt)
  for i,v in pairs(b) do
    if v[5] > 0 then
      b[i][5] = v[5] - dt
    else
      b[i][5] = 0
    end
  end
end

function love.keypressed(key)
  if key == "up" then
    p[2] = p[2] - 10
  elseif key == "down" then
    p[2] = p[2] + 10
  elseif key == "right" then
    p[1] = p[1] + 10
  elseif key == "left" then
    p[1] = p[1] - 10
  end
end

function love.mousepressed(mx,my)
  for i,v in pairs(b) do
    -- check collision and restrict allowed repeat click speed
    if mx >= v[1] and mx <= v[1]+v[3] and my >= v[2] and my <= v[2] + v[4] and v[5] == 0 then
      b[i][5] = freq
      if i == "t" then
        -- do what uparrow does
      elseif i == "l" then
        -- do what leftarrow does
      elseif i == "b" then
        -- do what downarrow does
      elseif i == "r" then
        -- do what rightarrow does
      end
    end	
  end
end