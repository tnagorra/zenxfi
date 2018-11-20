white=color.new(255,255,255)
red=color.new(255,0,0)
black = color.new(0,0,0)
orange = color.new(249,175,47)
brown = color.new(137,89,85)

height  = screen.height()
width = screen.width()

maximum = 32

goal = 0
anglex = 0
angley = 0

view = true
shoot = false
ballmove = false

positionx = {}
positiony = {}

vx = {}
vy = {}
vz = {}

screen.fillrect(0,0,width,height,black)



function filltriangle(a,b,c,color)

    local x1 = positionx[a]
    local y1 = positiony[a]
    local x2 = positionx[b]
    local y2 = positiony[b]
    local x3 = positionx[c]
    local y3 = positiony[c]


    anglexround = math.floor(anglex)
    angleyround = math.floor(angley)

    if validate(a) or validate(b) or validate(c) then

        local const1=(y2-y1)/(x2-x1)
        local const2=(y3-y1)/(x3-x1)
        local const3=(y3-y2)/(x3-x2)

        if const1*(x3-x1) - (y3-y1) < 0 then  k1 = 1 else  k1 = -1 end
        if const2*(x2-x1) - (y2-y1) < 0 then  k2 = 1 else  k2 = -1 end
        if const3*(x1-x2) - (y1-y2) < 0 then  k3 = 1 else  k3 = -1 end

        minx =  math.min(x1,x2,x3)
        miny = math.min(y1,y2,y3)
        maxx = math.max(x1,x2,x3)
        maxy = math.max(y1,y2,y3)
        if minx < 0 then minx = 0 end
        if miny < 0 then miny = 0 end
        if maxx > width then maxx = width end
        if maxy > height then maxy = height end


        for x = minx,maxx do
            for y = miny,maxy do
                if k1*(const1*(x-x1) - (y-y1)) <= 0 and k2*(const2*(x-x1) - (y-y1)) <= 0 and k3*(const3*(x-x2) - (y-y2)) <=0 then
                    screen.drawpixel(x,y,color)
                end
            end
        end
    end

end

function distance(x1,y1,x2,y2)
    d = math.sqrt((x1-x2)^2 + (y1-y2)^2)
    return d
end

function assigntrigonometricvalues()
    cs = {}
    sn = {}
    for i = 0, 360  do
        cs[i] = math.cos(i * 3.141593E+000 / 180);
        sn[i] = math.sin(i * 3.141593E+000 / 180);
    end
end

function createpoints()

    --create post
    vx[1],vy[1],vz[1] = -120,-50,50 - 380
    vx[2],vy[2],vz[2] = 120,-50,50 - 380
    vx[3],vy[3],vz[3] = 120,70,50 - 380
    vx[4],vy[4],vz[4] = -120,70,50 - 380
    vx[5],vy[5],vz[5] = -120,-50,-100 - 380
    vx[6],vy[6],vz[6] = 120,-50,-100 - 380
    vx[7],vy[7],vz[7] = 120,70,-100 - 380
    vx[8],vy[8],vz[8] = -120,70,-100 - 380

    --create ball
    vx[9],vy[9],vz[9] =    -10,-10 -40, 10 - 10
    vx[10],vy[10],vz[10] =  10,-10 -40, 10 - 10
    vx[11],vy[11],vz[11] =  10, 10 -40, 10 - 10
    vx[12],vy[12],vz[12] = -10, 10 -40, 10 - 10
    vx[13],vy[13],vz[13] = -10,-10 -40,-10 - 10
    vx[14],vy[14],vz[14] =  10,-10 -40,-10 - 10
    vx[15],vy[15],vz[15] =  10, 10 -40,-10 - 10
    vx[16],vy[16],vz[16] = -10, 10 -40,-10 - 10

    vx[17],vy[17],vz[17] = 0, -40 , - 10 --midpoint of ball

    --create penguin keeper
    vx[18],vy[18],vz[18] = -18,-10 -40, 10 - 315
    vx[19],vy[19],vz[19] =  18,-10 -40, 10 - 315
    vx[20],vy[20],vz[20] =  18, 35 -40, 10 - 315
    vx[21],vy[21],vz[21] = -18, 35 -40, 10 - 315
    vx[22],vy[22],vz[22] = -18,-10 -40,-10 - 315
    vx[23],vy[23],vz[23] =  18,-10 -40,-10 - 315
    vx[24],vy[24],vz[24] =  18, 35 -40,-10 - 315
    vx[25],vy[25],vz[25] = -18, 35 -40,-10 - 315

    vx[26],vy[26],vz[26] =  0,26 -40, 10 - 315
    vx[27],vy[27],vz[27] = -4,20 -40, 10 - 315
    vx[28],vy[28],vz[28] =  4,20 -40, 10 - 315
    vx[29],vy[29],vz[29] =  0,23 -40, 10 - 305

    vx[30],vy[30],vz[30] =  -10,23 -40, 10 - 305
    vx[31],vy[31],vz[31] =  10,23 -40, 10 - 305

    vx[32],vy[32],vz[32] = 0, 25-40 , - 10 - 315 --midpoint of keeper


    --[[
    g = 18
    for n = 1,10 do
    for m = 1, 10 do
    vx[g],vy[g],vz[g] = -n*50 + 300,-50,-m*50
    g = g + 1
    end
    end
    print(g)
    --]]

end

function dimensionalpos()

    if angley > 360 then angley = angley - 360 elseif angley <= 0 then angley = angley + 360 end
    if anglex > 360 then anglex = anglex - 360 elseif anglex <= 0 then anglex = anglex + 360 end
    if angley > 15 and angley < 180 then angley = 15 elseif angley >180 and angley <350 then angley = 350 end

    local angley2 = math.floor(angley)
    local anglex2 = math.floor(anglex) 

    local xconstant = sn[anglex2]*width/2
    local yconstant = sn[angley2]*height/2
    for  n = 1, maximum do

        local tz = vz[n] * cs[angley2] - vy[n] * sn[angley2];
        local ty = vy[n] * cs[angley2] + vz[n] * sn[angley2];

        local c = tz

        local tx = vx[n] * cs[anglex2] - c * sn[anglex2];
        local tz = c * cs[anglex2] + vx[n] * sn[anglex2];

        local k = (180 * 2 )/ (180 - tz)
        positionx[n] = width/2 + tx * k  + xconstant
        positiony[n] = height/2 - ty * k + yconstant
    end

end

function validate(a)
    if sn[anglexround]*vx[a] + cs[anglexround]*vz[a]  - cs[anglexround]*width/2  < 0 then
        if sn[angleyround]*vy[a] + cs[angleyround]*vz[a]  - cs[angleyround]*height/2  < 0 then
            if positionx[a] < width and positionx[a] > 0 and positiony[a] < height and positiony[a] > 0 then
                return true
            end
        end
    end
end

function drawline(a,b,color) 
    if validate(a) or validate(b) then
        screen.drawline(positionx[a],positiony[a],positionx[b],positiony[b],color)
    end
end

function drawpoint(a,color) 
    if validate(a) then
        screen.drawpixel(positionx[a],positiony[a],color)
    end
end

function drawall(color1,color2,color3)

    --[[
    local anglex3 = math.floor(anglex) 
    for m = 18, 117 do
    if sn[anglex3]*vx[m] + cs[anglex3]*vz[m]  - cs[anglex3]*width/2  < 0 then
    if positionx[m] < width and positionx[m] > 0 and positiony[m] < height and positiony[m] > 0 then
    screen.drawpixel(positionx[m],positiony[m],color2)
    end
    end
    end
    --]]

    anglexround = math.floor(anglex)
    angleyround = math.floor(angley)

    drawline( 1, 2,color1)
    drawline( 2, 3,color1)
    drawline( 3, 4,color1)
    drawline( 4, 1,color1)

    drawline( 5, 6,color1)
    drawline( 6, 7,color1)
    drawline( 7, 8,color1)
    drawline( 8, 5,color1)

    drawline( 1, 5,color1)
    drawline( 2, 6,color1)
    drawline( 3, 7,color1)
    drawline( 4, 8,color1)



    drawline( 9, 10,color2)
    drawline( 10, 11,color2)
    drawline( 11, 12,color2)
    drawline( 12, 9,color2)

    drawline( 13, 14,color2)
    drawline( 14, 15,color2)
    drawline( 15, 16,color2)
    drawline( 16, 13,color2)

    drawline( 9, 13,color2)
    drawline( 10, 14,color2)
    drawline( 11, 15,color2)
    drawline( 12, 16,color2)




    drawline( 18, 19,color1)
    drawline( 19, 20,color1)
    drawline( 20, 21,color1)
    drawline( 21, 18,color1)

    drawline( 22, 23,color1)
    drawline( 23, 24,color1)
    drawline( 24, 25,color1)
    drawline( 25, 22,color1)

    drawline( 18, 22,color1)
    drawline( 19, 23,color1)
    drawline( 20, 24,color1)
    drawline( 21, 25,color1)


    drawline( 26, 27,color3)
    drawline( 27, 28,color3)
    drawline( 28, 26,color3)


    drawline( 26, 29,color3)
    drawline( 27, 29,color3)
    drawline( 28, 29,color3)


    drawpoint(31,color1)
    drawpoint(30,color1)

    anglexround = nil
end

function resetball()
    vx[9],vy[9],vz[9] =    -10,-10 -40, 10 - 10
    vx[10],vy[10],vz[10] =  10,-10 -40, 10 -10
    vx[11],vy[11],vz[11] =  10, 10 -40, 10 - 10
    vx[12],vy[12],vz[12] = -10, 10 -40, 10 - 10
    vx[13],vy[13],vz[13] = -10,-10 -40,-10 - 10
    vx[14],vy[14],vz[14] =  10,-10 -40,-10 - 10
    vx[15],vy[15],vz[15] =  10, 10 -40,-10 -10
    vx[16],vy[16],vz[16] = -10, 10 -40,-10 - 10
    --midpoint
    vx[17],vy[17],vz[17] = 0, -40 , - 10


    vx[18],vy[18],vz[18] = -18,-10 -40, 10 - 315
    vx[19],vy[19],vz[19] =  18,-10 -40, 10 - 315
    vx[20],vy[20],vz[20] =  18, 35 -40, 10 - 315
    vx[21],vy[21],vz[21] = -18, 35 -40, 10 - 315
    vx[22],vy[22],vz[22] = -18,-10 -40,-10 - 315
    vx[23],vy[23],vz[23] =  18,-10 -40,-10 - 315
    vx[24],vy[24],vz[24] =  18, 35 -40,-10 - 315
    vx[25],vy[25],vz[25] = -18, 35 -40,-10 - 315
    --midpoint of ball

    vx[26],vy[26],vz[26] =  0,26 -40, 10 - 315
    vx[27],vy[27],vz[27] = -4,20 -40, 10 - 315
    vx[28],vy[28],vz[28] =  4,20 -40, 10 - 315
    vx[29],vy[29],vz[29] =  0,23 -40, 10 - 305

    vx[30],vy[30],vz[30] =  -10,23 -40, 10 - 305
    vx[31],vy[31],vz[31] =  10,23 -40, 10 - 305


    vx[32],vy[32],vz[32] = 0, 25-40 , - 10 - 315

end



assigntrigonometricvalues()
createpoints()

while true do

    if control.read() then

        if control.isTouch()==1 then
            xtouch,ytouch = touch.pos()
            if  touch.down() == 1 then
                x1,y1 = xtouch,ytouch
                pressed = true
            elseif  touch.up() == 1 then
                released = true
                pressed = false
            elseif  touch.click() == 1 then
                clicked = true
                pressed = false
            end
        end

        if control.isButton()==1 then
            break
        end

    end

    if clicked then

        if  xtouch < 100 and ytouch < 100 then --not view  and
            print("view")
            view = true
            shoot = false
        end

        if not shoot and xtouch < 100 and ytouch > 140  and not ballmove then
            print("shoot")
            shoot = true
            view = false
        end

        if xtouch < 100 and ytouch > 140  and ballmove then
            print("reset")
            resetball()
            ballmove = false
            view = true
        end

        clicked = false
    end
    if pressed then

        if view then
            anglex =  anglex + (x1 - xtouch)/2
            angley =  angley + (y1 - ytouch)/4
        end


        if shoot  then
            velx =  (x1 - xtouch)
            vely = (y1 - ytouch)
        end

        x1 = xtouch
        y1 = ytouch
    end
    if released then

        if shoot then

            powx = velx/2
            powy = vely/2.9
            powz = vely/1.35

            velx = 0
            vely = 0

            if powy > 0 then

                ballmove = true
                shoot = false
                view = true

                if math.abs(powx) > 4 or powy > 7 then 
                    powx2 =  (math.random(3) - 2)*math.random(4)
                    powy2 =  math.random(4)
                else

                    powx2 = powx + (math.random(3) - 2)
                    powy2 = powy  + (math.random(3) - 2)

                    if powy2 < 0 then powy2 = 1 end
                end
                prevangle = 0
                prevy2 = 0
                prevy = 0

            end


        end

        released = false
    end


    if ballmove then
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------FOR BALL



        if powy ~= nil then
            if vy[17] < -40 then
                powy = - powy*0.7
                if powz < 0.2 and powz > -0.2 then powz = 0 else powz  = powz/2 end
                if powx <0.1 and powx > -0.1 then powx = 0 else powx = powx/2 end
                if math.abs(powy) + math.abs(prevy)  < 0.0001 then powy = nil end
                prevy = powy
            else
                powy = powy  - 0.1 
            end
        end

        if powy ~= nil then

            for  n = 9, 17 do
                vx[n],vy[n],vz[n] = vx[n]-powx,vy[n]+powy,vz[n] - powz
            end


            --front side ie. goal
            if vz[17] < vz[1]-5 and vz[17] > vz[1] - powz-5 then
                if vx[17] < vx[3] and vx[17] > vx[1] and vy[17] < vy[3] and vy[17] > vy[1]  then

                    goal = goal + 1
                    print("goal \n" .. goal)

                else
                    print("out")
                end
            end


            --keeper ERRORS PRONE WHILE DIVING
            if vz[17] < vz[18] and vz[17] > vz[18] - powz then
                if distance(vx[17],vy[17],vx[32],vy[32]) < 45 then
                    powz = -powz
                end
            end


            --backside
            if vz[17] <= vz[5] + powz  and vz[17] >= vz[5] - powz then
                if vx[17] <= vx[7] and vx[17] >= vx[5] and vy[17] <= vy[7] and vy[17] >= vy[5]  then
                    powz = -powz/10
                end
            end

            --leftside
            if vx[17] >= vx[1] - powx and vx[17] <= vx[1] + powx then
                if vz[17] >= vz[8] and vz[17] <= vz[1] and vy[17] <= vy[8] and vy[17] >= vy[1]  then
                    powx = -powx/1.5
                end
            end

            --rightside
            if vx[17] <= vx[2] - powx and vx[17] >= vx[2] + powx then
                if vz[17] >= vz[7] and vz[17] <= vz[2] and vy[17] <= vy[7] and vy[17] >= vy[2]  then
                    powx = -powx/1.5
                end
            end

            --upside
            if vy[17] >= vy[3] - powy and vy[17] <= vy[3] + powy then
                if vz[17] >= vz[8] and vz[17] <= vz[3] and vx[17] >= vx[8] and vx[17] <= vx[3]  then
                    powy = -powy/2
                end
            end



        end

        --ball rotate
        if powz ~= 0  or powx ~= 0 then

            local anglebally = math.floor(powz)*5
            local angleballx = -math.floor(powx)*8

            if angleballx > 360 then angleballx = angleballx - 360 elseif angleballx <= 0 then angleballx = angleballx + 360 end
            if anglebally > 360 then anglebally = anglebally - 360 elseif anglebally <= 0 then anglebally = anglebally + 360 end

            for i = 9,16 do
                --x axis
                local tempx = vx[17] + (vx[i]-vx[17])*cs[angleballx] - (vz[i]-vz[17])*sn[angleballx]
                local tempz = vz[17] + (vx[i]-vx[17])*sn[angleballx] + (vz[i]-vz[17])*cs[angleballx]
                vx[i] = tempx
                vz[i] = tempz

                --y axis
                local tempy = vy[17] + (vy[i]-vy[17])*cs[anglebally] - (vz[i]-vz[17])*sn[anglebally]
                local tempz = vz[17] + (vy[i]-vy[17])*sn[anglebally] + (vz[i]-vz[17])*cs[anglebally]
                vy[i] = tempy
                vz[i] = tempz
            end

        end

        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------FOR KEEPER

        if powx2 ~= 0 then

            local tempangle = math.ceil( math.atan((vy[32]+40)/vx[32]) / (3.141593E+000 / 180))
            if tempangle < 0 then tempangle = -(tempangle + 90) else  tempangle = 90 - tempangle end
            local anglex = prevangle-tempangle
            anglex = anglex % 360

            for i = 18,31 do
                --x axis
                local tempx = vx[32] + (vx[i]-vx[32])*cs[anglex] - (vy[i]-vy[32])*sn[anglex]
                local tempy = vy[32] + (vx[i]-vx[32])*sn[anglex] + (vy[i]-vy[32])*cs[anglex]
                vx[i] = tempx
                vy[i] = tempy
            end
            prevangle = tempangle
        end


        if powy2 ~= nil then
            if vy[32] < -15  then
                powy2 = - powy2*0.7
                if powx2 <0.1 and powx2 > -0.1 then powx2 = 0 else powx2 = powx2/1.5 end
                if math.abs(powy2) + math.abs(prevy2)  < 0.0001 then powy2 = nil end
                prevy2 = powy2
            else
                powy2 = powy2  - 0.1
            end
        end

        if powy2 ~= nil then
            for  n = 18, 32 do
                vx[n],vy[n] = vx[n]-powx2,vy[n]+powy2
            end
        end


    end


    dimensionalpos()
    drawall(white,brown,orange)

    collectgarbage()

    screen.update()

    drawall(black,black,black)
    os.sleep(1)
end
