local white = color.new(255,255,255)
local black = color.new(0,0,0)

local cs,sn = {361},{361}
for i = 0, 360  do
    cs[i] = math.cos(i * 3.141593E+000 / 180)
    sn[i] = math.sin(i * 3.141593E+000 / 180)
end

local function drawcircle(centrex,centrey,radius,steps,color)
    local posx,posy = centrex,centrey-radius
    local prevx,prevy = posx,posy
    for i = steps,360,steps do
        local tempx = centrex + (posx-centrex)*cs[i] - (posy-centrey)*sn[i]
        local tempy  = centrey + (posx-centrex)*sn[i] + (posy-centrey)*cs[i]
        screen.drawline(tempx,tempy,prevx,prevy,color)
        prevx,prevy = tempx,tempy
    end
end

local function secondline(a,b,color)
    local second = tonumber(string.sub(date,16,17))
    local angle  = second*6
    local tempx = centrex + (a-centrex)*cs[angle] - (b-centrey)*sn[angle]
    local tempy  = centrey + (a-centrex)*sn[angle] + (b-centrey)*cs[angle]
    screen.drawline(tempx,tempy,centrex,centrey,color)
end

local function minuteline(a,b,color)
    local minute = tonumber(string.sub(date,13,14))
    local angle  = minute*6
    local tempx = centrex + (a-centrex)*cs[angle] - (b-centrey)*sn[angle]
    local tempy  = centrey + (a-centrex)*sn[angle] + (b-centrey)*cs[angle]
    screen.drawline(tempx,tempy,centrex,centrey,color)
end

local function hourline(a,b,color)
    hour = tonumber(string.sub(date,10,11))
    if hour > 12 then hour = hour -12 end
    angle  = 30*hour
    tempx = centrex + (a-centrex)*cs[angle] - (b-centrey)*sn[angle]
    tempy  = centrey + (a-centrex)*sn[angle] + (b-centrey)*cs[angle]
    screen.drawline(tempx,tempy,centrex,centrey,color)
end








local width,height = screen.width(), screen.height()
local centrex, centrey, radius = 200,100,50

screen.fillrect(0,0,width,height,black)
drawcircle(centrex,centrey,radius,1,white)
drawcircle(centrex,centrey,radius+1,1,white)
drawcircle(centrex,centrey,radius+2,1,white)

while true do
    local date = os.date()

    secondline(centrex,centrey-(radius-5),white)
    minuteline(centrex,centrey-(radius-10),white)
    hourline(centrex,centrey-(radius-15),white)

    screen.update()
    os.sleep(1)

    secondline(centrex,centrey-(radius-5),black)
    minuteline(centrex,centrey-(radius-10),black)
    hourline(centrex,centrey-(radius-15),black)
end
