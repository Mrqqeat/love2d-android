-- modified a bit and translated to Italian from
-- code by Iwan 'qubodup' Gabovitch
-- license/terms: public domain (cc0)
-- meaning do what you want, no credit needed, you can delete this text too
-- video tutorial: https://youtu.be/sArl6wypDfY
-- you can make a bee.png from https://openclipart.org/detail/215877/cartoon-bee


function love.load()
  -- Per fare debug da ZeroBrane
  local debug = load_mod("mobdebug")
  if debug then
    debug.start()
  end

  gameWidth = love.graphics.getWidth()
  gameHeight = love.graphics.getHeight()



  -- sample player
  player = { x = gameWidth / 2, y = gameHeight / 2, image = love.graphics.newImage('bee20small.png') }
  -- sample player
end

-- l'area di gioco viene suddivisa in blocchi di coordinate 1/10
-- rispetto all'area effettiva di gioco, questo semplifica il posizionamento
-- dei singoli oggetti. L'idea viene ripresa da minetest (!)

function px(x)
  return gameWidth / 10 * x
end
function py(y)
  return gameHeight / 10 * y
end

function buttons()
  return {
    left = { x = px(0), y = py(1), w = px(1), h = py(6) },
    right = { x = px(7), y = py(1), w = px(1), h = py(6) },
    top = { x = px(1), y = py(0), w = px(6), h = py(1) },
    bottom = { x = px(1), y = py(7), w = px(6), h = py(1) },
    quit = { x = px(1), y = py(9), w= px(1), h = py(1) }
  }

end

function love.draw()
  -- draw buttons
  for _, button in pairs(buttons()) do
    love.graphics.setColor(255, 255, 255, 100)
    love.graphics.rectangle("fill", button.x, button.y, button.w,
        button.h)
  end

  -- sample player
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(player.image, player.x, player.y, 0, 1, 1, 40, 40)
  -- sample player
end

--function love.mousepressed(x,y,button)
--  checkButtons(x,y)
--end

function love.update(dt)
  if love.keyboard.isDown("up") then
    up()
  end
  if love.keyboard.isDown("down") then
    down()
  end
  if love.keyboard.isDown("left") then
    left()
  end
  if love.keyboard.isDown("right") then
    right()
  end
   local touches = love.touch.getTouches()

   for i, id in pairs(touches) do
     local x, y = love.touch.getPosition(id)
     checkButtons(x, y)
   end

end

function up()
  player.y = player.y - 10
end
function down()
  player.y = player.y + 10
end
function left()
  player.x = player.x - 10
end
function right()
  player.x = player.x + 10
end

function checkButtons(mx, my)
  for name, button in pairs(buttons()) do
    -- verifica se abbiamo cliccato all'interno del rettangolo corrispondente
    -- a questo bottone ma solo se t e' zero (evita di cliccare troppo velocemente)
    if
    -- se il click e' nell'intervallo di x in cui e' il bottone
    (mx >= button.x) and mx <= (button.x + button.w)
        -- se il click e' nell'intervallo di y in cui e' il bottone
        and (my >= button.y) and my <= (button.y + button.h)
    then
      if name == "top" then
        up()
      elseif name == "left" then
        left()
      elseif name == "bottom" then
        down()
      elseif name == "right" then
        right()
      elseif name == "quit" then
        love.event.quit()
      end
    end
  end
end

function load_mod(name)
  local ok, mod = pcall(require, name)
  if not ok then
    mod = nil
  end
  if mod then
    mod.start()
  end
end
