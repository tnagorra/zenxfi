black = color.new(0,0,0)
white = color.new(255,255,255)
grey1 = color.new(60,60,60)
grey2 = color.new(180,180,180)
grey3 = color.new(245,245,245)

textsize = 15
sample = ""
num = nil
shift = nil
shift_temp = nil

start = nil
stop = nil

temp_btn = nil
temp_btn2 = nil


button_no = 31
button = {} for i=1,button_no do button[i] = {} end
button[1] = {0,80,"Q","q","1","["}
button[2] = {40,80,"W","w","2","]"}
button[3] = {80,80,"E","e","3","{"}
button[4] = {120,80,"R","r","4","}"}
button[5] = {160,80,"T","t","5","#"}
button[6] = {200,80,"Y","y","6","%"}
button[7] = {240,80,"U","u","7","^"}
button[8] = {280,80,"I","i","8","*"}
button[9] = {320,80,"O","o","9","+"}
button[10] = {360,80,"P","p","0","="}
button[11] = {20,120,"A","a","-","_"}
button[12] = {60,120,"S","s","/",string.char(92)}
button[13] = {100,120,"D","d",":","~"}
button[14] = {140,120,"F","f",";","<"}
button[15] = {180,120,"G","g","(",">"}
button[16] = {220,120,"H","h",")",string.char(128)}
button[17] = {260,120,"J","j","$","Rs."}
button[18] = {300,120,"K","k","#","..."}
button[19] = {340,120,"L","l","@","!!!"}
button[20] = {60,160,"Z","z",".","."}
button[21] = {100,160,"X","x",",",","}
button[22] = {140,160,"C","c","?","?"}
button[23] = {180,160,"V","v","!","!"}
button[24] = {220,160,"B","b","'","'"}
button[25] = {260,160,"N","n",string.char(34),string.char(34)}
button[26] = {300,160,"M","m","|","|"}
button[27] = {0,160,"SHIFT","Shift","#+=","123",60}
button[28] = {340,160,"Back","Back","Back","Back",60}
button[29] = {0,200,".?123",".?123","Abc","Abc",81}
button[30] = {81,200,"Space","Space","Space","Space",238}
button[31] = {319,200,"Return","Return","Return","Return",81}


function createallbuttons()
    text.size(textsize)
    text.color(black)

    local temp_btn,i

    for i=1,button_no do

        if not shift and not num then temp_btn2 = 4
        elseif not shift_temp and  num then temp_btn2 = 5
        elseif shift and not num then temp_btn2 = 3
        elseif shift_temp and num then temp_btn2 = 6
        end

        local x,y,w,h = button[i][1],button[i][2]+3,(button[i][7] or 40),(40-6)
        screen.fillrect(x,y,w,h/2+5,white)
        screen.fillrect(x,y+h/2+5,w,h/2-5,grey3)
        screen.drawrect(x,y,x+w,y+h-1,grey2)
        text.draw(x,y+h/2-textsize/2,button[i][temp_btn2],"center",x+w)
    end


end

function createbutton()
    local x,y,w,h,i

    for i=1,button_no do

        if xtouch >= button[i][1] and ytouch >= button[i][2] and xtouch <= button[i][1]+(button[i][7] or 40)-1 and ytouch <= button[i][2]+40-1 then 

            if not shift and not num then temp_btn2 = 4
            elseif not shift_temp and  num then temp_btn2 = 5
            elseif shift and not num then temp_btn2 = 3
            elseif shift_temp and num then temp_btn2 = 6
            end

            temp_btn = i

            if string.len(button[i][temp_btn2]) <= 1 then textsize2 = textsize + 8 else textsize2 = textsize+3 end
            text.size(textsize2)
            text.color(white)
            x,y,w,h = button[i][1],button[i][2]+3,(button[i][7] or 40),(40-6)
            screen.fillrect(x,y,w,h,grey1)
            text.draw(x,y+h/2-textsize2/2,button[i][temp_btn2],"center",x+w)
        end
    end


end

screen.fillrect(0,0,400,240,white)
createallbuttons()
screen.update()

while true do
    os.sleep(1)

    if control.read() == 1 then
        if control.isTouch()==1 then
            if touch.down() == 1 then

                xtouch,ytouch = touch.pos()
                pressed = true
                start = nil

                if temp_btn then
                    local x,y,w,h = button[temp_btn][1],button[temp_btn][2]+3,(button[temp_btn][7] or 40),(40-6)
                    --screen.fillrect(x,y-3,w,h+6,white)
                    screen.fillrect(x,y,w,h/2+5,white)
                    screen.fillrect(x,y+h/2+5,w,h/2-5,grey3)
                    screen.drawrect(x,y,x+w,y+h-1,grey2)
                    text.size(textsize)
                    text.color(black)
                    text.draw(x,y+h/2-textsize/2,button[temp_btn][temp_btn2],"center",x+w)
                    temp_btn = nil
                    temp_bnt2 = nil
                end

                createbutton()
                screen.update()

            elseif touch.hold() == 1 then
            elseif touch.move() == 1 then
            else

                if pressed then
                    print("dsaga")
                    pressed = nil

                    if temp_btn then

                        start = os.ostime()

                        if button[temp_btn][3] == "SHIFT" then
                            if num then shift_temp = not shift_temp else  shift = not shift end
                        elseif button[temp_btn][3] == ".?123" then
                            if num then shift_temp = nil else shift = nil end
                            num = not num
                        elseif button[temp_btn][temp_btn2] == "Back" then
                            if string.len(sample) >= 1 then sample = string.sub(sample,1,string.len(sample)-1) end
                        elseif button[temp_btn][temp_btn2] == "Return" then ------------
                        elseif button[temp_btn][temp_btn2] == "Space" then sample = sample.." "
                        else sample = sample..button[temp_btn][temp_btn2] end


                        if button[temp_btn][3] == "SHIFT" or button[temp_btn][3] == ".?123" then
                            local x,y,w,h = button[temp_btn][1]+3,button[temp_btn][2]+3,(button[temp_btn][7] or 40)-6,(40-6)
                            screen.fillrect(x-3,y-3,w+6,h+6,white)
                            createallbuttons()
                            temp_btn = nil
                            temp_bnt2 = nil
                        end

                        screen.fillrect(0,0,400,80,white)
                        text.size(textsize)
                        text.color(black)
                        text.draw(0,0,sample)
                        screen.update()

                    end
                end

            end

        elseif control.isButton()==1 then
            break
        end
        control.read()
        control.read()
        control.read()
    end


    if start then
        stop = os.ostime()
        if start and stop - start >= 500 then
            if temp_btn then
                local x,y,w,h = button[temp_btn][1],button[temp_btn][2]+3,(button[temp_btn][7] or 40),(40-6)
                --screen.fillrect(x,y-3,w,h+6,white)
                screen.fillrect(x,y,w,h/2+5,white)
                screen.fillrect(x,y+h/2+5,w,h/2-5,grey3)
                screen.drawrect(x,y,x+w,y+h-1,grey2)
                text.size(textsize)
                text.color(black)
                text.draw(x,y+h/2-textsize/2,button[temp_btn][temp_btn2],"center",x+w)
                temp_btn = nil
                temp_bnt2 = nil
            end
            screen.update()
            start = nil
            stop = nil
        end
    end


end
