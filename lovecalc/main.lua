function length(a)
	local i = 0
	while a ~= 0 do
		down = 10 ^ i
		up = 10 ^ (i + 1)
		i = i + 1
		if a >= down and a < up then break end
	end
	return i
end
function pos(posi,a)
	local num = math.floor((a % (10 ^ posi)) / (10 ^ (posi - 1)))
	return num
end
function calculate(a,b)
	
	local z,t,k = 0,0,""
	local a,b = string.lower(a),string.lower(b)
	local n = a.."loves"..b

	while n ~= "" do
		local m = string.sub(n,1,1)
		
		for j = 1,string.len(n) do
			if m == string.sub(n,j,j) then t = t + 1 else k = k .. string.sub(n,j,j) end
		end

		n = k
		k = ""
	
		z = z*10 + t
		t = 0
	end

	n,t,a,b,k = nil,nil,nil,nil,nil

	while z > 99 do

		local l,x = length(z)/2,0
		if math.ceil(l) ~= math.floor(l) then l = l + 1  end

		for i = 1, l do
			local g = pos(i,z)
			local h = pos(length(z)-i+1,z)
			local s = g + h
			if i == length(z) - i + 1 then s = s/2 end
			x = x*10 + s
		end
		z = x

	end
	return z

end

------------------------------------------------------------------------------------------------------------------

function createbutton() --searches the released button and draws released impression.gives the released button number.
local x,y,w,h,i,a,b

if page==1 then a = 32 b = 34 elseif page==2 then a = 1 b = 31 end
for i=a,b do

if xtouch >= button[i][1] and ytouch >= button[i][2] and xtouch <= button[i][1]+(button[i][7] or 40)-1 and ytouch <= button[i][2]+(button[i][8] or 40)-1 then 

temp_btn = i

if not shift and not num then temp_btn2 = 4
elseif not shift_temp and  num then temp_btn2 = 5
elseif shift and not num then temp_btn2 = 3
elseif shift_temp and num then temp_btn2 = 6
end

if page==1 then temp_btn2 = 3 end

if string.len(button[temp_btn][temp_btn2]) <= 1 then textsize2 = textsize + 8 else textsize2 = textsize+3 end
text.size(textsize2)
text.color(white)
x,y,w,h = button[temp_btn][1],button[temp_btn][2]+3,(button[temp_btn][7] or 40),((button[i][8] or 40)-6)
screen.fillrect(x,y,w,h,grey1)
text.draw(x,y+h/2-textsize2/2,button[temp_btn][temp_btn2],"center",x+w)
break 
end
end


end
function createallbuttons() --draws all the buttons
text.size(textsize)
text.color(black)
local i,a,b
if page==1 then a = 32 b = 34 elseif page==2 then a = 1 b = 31 end

if not shift and not num then temp_btn2 = 4
elseif not shift_temp and  num then temp_btn2 = 5
elseif shift and not num then temp_btn2 = 3
elseif shift_temp and num then temp_btn2 = 6
end

if page==1 then temp_btn2 = 3 end
for i=a,b do
local x,y,w,h = button[i][1],button[i][2]+3,(button[i][7] or 40),((button[i][8] or 40)-6)
screen.fillrect(x,y,w,h/2+5,white)
screen.fillrect(x,y+h/2+5,w,h/2-5,grey3)
screen.drawrect(x,y,x+w,y+h-1,grey2)
text.draw(x,y+h/2-textsize/2,button[i][temp_btn2],"center",x+w)
end

end

------------------------------------------------------------------------------------------------------------------

black = color.new(0,0,0)
white = color.new(255,255,255)
grey1 = color.new(60,60,60)
grey2 = color.new(180,180,180)
grey3 = color.new(245,245,245)


page = 1
updatepage = true
calculated = nil


textsize = 15
sample = nil
num = nil
shift = nil
shift_temp = nil

start = nil

temp_btn = nil
temp_btn2 = nil
temp_bnt3 = nil


button = {} for i=1,31 do button[i] = {} end
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
button[31] = {319,200,"Enter","Enter","Enter","Enter",81}

button[32] = {0,30,"Romeo",nil,nil,nil,400,60}
button[33] = {0,90,"Juliet",nil,nil,nil,400,60}
button[34] = {340,185,"Go",nil,nil,nil,55,55}

------------------------------------------------------------------------------------------------------------------









while true do
os.sleep(1)

if updatepage then
updatepage = nil
screen.fillrect(0,0,400,240,white)
if page==2 then
		text.size(textsize)
		text.color(black)
		text.draw(0,0,sample)
end
createallbuttons()
screen.update()
end


if control.read() == 1 then
	
	if control.isButton()==1 then
		if not calculated then break end		
	elseif control.isTouch()==1 then
		if touch.down() == 1 then if not calculated then xtouch,ytouch = touch.pos() released = true end		
		elseif touch.hold() == 1 then
		elseif touch.move() == 1 then
		elseif released then --all work is done in this segment.
		released = nil
		 
		if temp_btn then --restores the button released if another button is released
		local x,y,w,h = button[temp_btn][1],button[temp_btn][2]+3,(button[temp_btn][7] or 40),(button[temp_btn][8] or 40-6)
		screen.fillrect(x,y,w,h/2+5,white)
		screen.fillrect(x,y+h/2+5,w,h/2-5,grey3)
		screen.drawrect(x,y,x+w,y+h-1,grey2)
		text.size(textsize)
		text.color(black)
		text.draw(x,y+h/2-textsize/2,button[temp_btn][temp_btn2],"center",x+w)
		temp_btn = nil
		temp_bnt2 = nil
		start = nil
		end
		
		createbutton() --create a button event
		
		if temp_btn then  --if a button was clicked
		start = os.ostime()
	
		if temp_btn == 27 or temp_btn == 29 then
		
		if temp_btn == 27 then if num then shift_temp = not shift_temp else  shift = not shift end --shift
		elseif temp_btn == 29 then if num then shift_temp = nil else shift = nil end num = not num --.?123 
		end
		local x,y,w,h = button[temp_btn][1]+3,button[temp_btn][2]+3,(button[temp_btn][7] or 40)-6,(40-6)
		screen.fillrect(x-3,y-3,w+6,h+6,white)
		createallbuttons()
		createbutton()
		
		elseif temp_btn == 34 then calculated = true --go 
		elseif temp_btn == 31 then page = 1 updatepage = true if string.len(sample) > 0 then button[temp_btn3][3] = sample  end sample=nil temp_btn3 = nil temp_btn = nil temp_btn2 = nil start = nil--enter
		elseif temp_btn == 32 or temp_btn == 33 then page = 2 updatepage= true sample = button[temp_btn][3] temp_btn3 = temp_btn  temp_btn = nil temp_btn2 = nil start = nil--romeo/juliet buttons
		else 
		
		if temp_btn == 28 then if string.len(sample) >= 1 then sample = string.sub(sample,1,string.len(sample)-1) end --back
		elseif temp_btn == 30 then sample = sample.." " --space
		else sample = sample..button[temp_btn][temp_btn2] end
		if page==2 then
		screen.fillrect(0,0,400,80,white)
		text.size(textsize)
		text.color(black)
		text.draw(0,0,sample)
		end
		
		end
		
		end
		
		screen.update()
		end

	end
	control.read()
	control.read()
	control.read()
end



if start and os.ostime() - start >= 500 then --restores the button released after some time
local x,y,w,h = button[temp_btn][1],button[temp_btn][2]+3,(button[temp_btn][7] or 40),(button[temp_btn][8] or 40-6)
screen.fillrect(x,y,w,h/2+5,white)
screen.fillrect(x,y+h/2+5,w,h/2-5,grey3)
screen.drawrect(x,y,x+w,y+h-1,grey2)
text.size(textsize)
text.color(black)
text.draw(x,y+h/2-textsize/2,button[temp_btn][temp_btn2],"center",x+w)
temp_btn = nil
temp_bnt2 = nil
start = nil
screen.update()
end

if calculated then --if calculated
percent = percent or calculate(button[32][3],button[33][3])
percent1 =  percent1 or 0
text.size(80)
text.color(grey1)
if percent1 == 0 then text.draw(100,150,"%","left") end
percent1 = percent1 + 1
screen.fillrect(0,150,100,90,white)
text.draw(0,150,percent1,"right",100)
os.wait(25)
screen.update()
if percent1 == percent then calculated = nil percent = nil percent1 = nil end
end


end
