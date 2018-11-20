collectgarbage()

color_white=color.new(255,255,255)
color_yellow=color.new(255,255,0)
color_red=color.new(255,0,0)
color_brown= color.new(98,58,6)
color_black = color.new(0,0,0)

color_lightblack=color.new(10,0,26)
color_lightwhite=color.new(255,255,255,5)
color_lightred = color.new(10,1,40)
color_lightyellow = color.new(255,255,0,30)

color_trans = color.new(0,0,0,50)

height  = screen.height()
width = screen.width()
PI = 180/(22/7)
paused = nil

screen.fillrect(0,0,width,height,color_black)
screen.update()

function assigntrigonometricvalues()
cs = {}
sn = {}
for i = 0, 360  do
    cs[i] = math.cos(i * 3.141593E+000 / 180);
    sn[i] = math.sin(i * 3.141593E+000 / 180);
end
end
assigntrigonometricvalues()

function distance(x1,y1,x2,y2)
local d = math.sqrt((x1-x2)^2 + (y1-y2)^2)
return d
end




score =0
meteor_no = 3
meteor_x={}
meteor_y={}
meteor_radius={}
meteor_point = {}
meteor_ax={}
meteor_ay={}
meteor_life={}

function createmeteor(num)
local temp,i,j = 0

for j = 1, num do
meteor_radius[j] = 20+math.random(20)
meteor_point[j] = 15
meteor_life[j] = meteor_radius[j]*3
meteor_ax[j]= (math.random(3)-2)+0.5
meteor_ay[j]= (math.random(3)-2)

for i = 1, meteor_point[j] do
meteor_x[i+temp] =  meteor_radius[j]*cs[360/meteor_point[j]*i] + (math.random(3)-2)
meteor_y[i+temp] =  meteor_radius[j]*sn[360/meteor_point[j]*i] + (math.random(3)-2)
end

temp = temp + meteor_point[j]
end
end

function movemeteor(num)
local temp,i,j = 0

for j = 1, num do

for i = 1,meteor_point[j] do
meteor_x[i+temp] = meteor_x[i+temp]+meteor_ax[j]
meteor_y[i+temp] = meteor_y[i+temp]+meteor_ay[j]
end

for i = 1 , bullet do
if distance(meteor_x[temp+1]-meteor_radius[j],meteor_y[temp+1],bullet_x[i],bullet_y[i]) < 2+meteor_radius[j] then
meteor_life[j] = meteor_life[j] - 10
score = score + meteor_radius[j]
bullet_x[i] = width + 1
end
end


if meteor_life[j] <= 0 then

local h,w,l = math.random(height),math.random(width)

if math.random(2) == 1 then

for l = 2,meteor_point[j] do
meteor_x[l+temp] = meteor_x[l+temp] - meteor_x[temp+1] + h
meteor_y[l+temp] = meteor_y[l+temp] - meteor_y[temp+1] - 60
end

meteor_x[temp+1] = h
meteor_y[temp+1] = -60

else

for l = 2,meteor_point[j] do
meteor_x[l+temp] = meteor_x[l+temp] - meteor_x[temp+1] - 60
meteor_y[l+temp] = meteor_y[l+temp] - meteor_y[temp+1] + w
end
meteor_x[temp+1] =  - 60
meteor_y[temp+1] =  w

end

meteor_life[j] = 100

end


if distance(meteor_x[temp+1]-meteor_radius[j],meteor_y[temp+1],jet_x[0],jet_y[0]) < meteor_radius[j]+10 or distance(meteor_x[temp+1]-meteor_radius[j],meteor_y[temp+1],(jet_x[9]+jet_x[29])/2,(jet_y[9]+jet_y[29])/2) < meteor_radius[j]+10 then
if jet_life > 0 then jet_life = jet_life - 2 end
meteor_life[j] = meteor_life[j] - 2
jet_hit = true
end


if meteor_x[temp+1] > width + 2*meteor_radius[j] then
meteor_ax[j] = -math.random(2)/2-1
end
if meteor_y[temp+1] > height+meteor_radius[j] then
meteor_ay[j] = -math.random(2)/2-1
end
if meteor_x[temp+1] < 0 then
meteor_ax[j] = math.random(2)/2+1
end
if meteor_y[temp+1] < -meteor_radius[j] then
meteor_ay[j] = math.random(2)/2+1
end


temp = temp + meteor_point[j]
end
end


function drawmeteor(num,color)
local temp = 0
for j = 1, num do
for i = 1, meteor_point[j]-1 do
screen.drawline(meteor_x[i+temp],meteor_y[i+temp],meteor_x[i+1+temp],meteor_y[i+1+temp],color)
end
screen.drawline(meteor_x[1+temp],meteor_y[1+temp],meteor_x[meteor_point[j]+temp],meteor_y[meteor_point[j]+temp],color)
temp = temp + meteor_point[j]
end
end


jet_life = 100
jet_x = {}
jet_y = {}
function createjet()
local a = 100
local b = 200
local i

jet_y[0] = a
jet_x[0] = b

jet_y[1] = -13 +a
jet_x[1] = -10 +b
jet_y[2] = -10 +a
jet_x[2] = b
jet_y[3] = 13 +a
jet_x[3] = -10 +b
jet_y[4] = 10 +a
jet_x[4] = b

jet_y[5] = -10 +a
jet_x[5] = 10 +b
jet_y[6] = 10 +a
jet_x[6] = 10 +b
jet_y[7] = 10 +a
jet_x[7] = -10 +b
jet_y[8] = -10 +a
jet_x[8] = -10 +b

for i = 9,29 do
jet_y[i] = (i-9)-10 + a
jet_x[i] = math.sqrt(10^2-(i-9-10)^2)+10 + b
end

end
function drawjet(color1,color2)
local i
screen.drawline(jet_x[1],jet_y[1],jet_x[2],jet_y[2],color1,1)
screen.drawline(jet_x[5],jet_y[5],jet_x[2],jet_y[2],color1,1)
screen.drawline(jet_x[5],jet_y[5],jet_x[6],jet_y[6],color1,1)
screen.drawline(jet_x[4],jet_y[4],jet_x[6],jet_y[6],color1,1)
screen.drawline(jet_x[4],jet_y[4],jet_x[3],jet_y[3],color1,1)
screen.drawline(jet_x[1],jet_y[1],jet_x[3],jet_y[3],color1,1)

screen.drawline(jet_x[2],jet_y[2],jet_x[8],jet_y[8],color1,1)
screen.drawline(jet_x[4],jet_y[4],jet_x[7],jet_y[7],color1,1)

for i = 10,29 do
screen.drawline(jet_x[i-1],jet_y[i-1],jet_x[i],jet_y[i],color2,1)
end

end


xSpeed = 0
ySpeed = 0

function movejet()

if cosine_xxx == nil then cosine_xxx = cs[rotation] end
if sine_xxx == nil then sine_xxx = sn[rotation] end

if thrust then
xSpeed = 3*cosine_xxx
ySpeed = 3*sine_xxx
else
xSpeed = xSpeed*0.97
ySpeed = ySpeed*0.97
end

for i = 0,29 do
jet_x[i] = jet_x[i] + xSpeed
jet_y[i] = jet_y[i] + ySpeed
end

end

rotation = 0
oldrotation = 0
function rotatejet()

change = rotation - oldrotation
oldrotation = rotation

if rotation > 360 then rotation = rotation - 360 elseif rotation < 0 then rotation = rotation + 360 end
if change > 360 then change = change - 360 elseif change < 0 then change = change + 360 end

cosine_xxx = cs[rotation]
sine_xxx = sn[rotation]

local cosine_jet = cs[change]
local sine_jet  = sn[change]

--change = nil

for i = 1,29 do
local m = jet_x[0] + (jet_x[i]-jet_x[0])*cosine_jet - (jet_y[i]-jet_y[0])*sine_jet 
local n  = jet_y[0] + (jet_x[i]-jet_x[0])*sine_jet + (jet_y[i]-jet_y[0])*cosine_jet  
jet_x[i] = m
jet_y[i] = n
end


end


bullet = 0
timer = 0
bullet_delay = 3
cosine = {} 
sine = {}
bullet_x = {}
bullet_y = {}

function createbullet()
bullet =  bullet + 1
bullet_x[bullet] = jet_x[5]
bullet_y[bullet] = jet_y[5]
sine[bullet] = 5*sine_xxx
cosine[bullet] = 5*cosine_xxx


bullet =  bullet + 1
bullet_x[bullet] = jet_x[6]
bullet_y[bullet] = jet_y[6]
sine[bullet] = 5*sine_xxx
cosine[bullet] = 5*cosine_xxx
end

function movebullet()
local i
for i = 1, bullet do
if (bullet_x[i] + cosine[i]) > 1 and (bullet_y[i] + sine[i]) > 1 and bullet_x[i] < width and bullet_y[i] < height then
bullet_x[i] = bullet_x[i] + cosine[i]
bullet_y[i] = bullet_y[i] + sine[i]
else
bullet_x[i] = -1
bullet_remove = true
end
end
end

function removebullet()
local temp,i = 0

for i = 1, bullet do
if bullet_x[i] > 0 then
temp = temp + 1
sine[temp] = sine[i]
cosine[temp] = cosine[i]
bullet_x[temp] = bullet_x[i]
bullet_y[temp] = bullet_y[i]
end
end

for i = temp + 1 , bullet do
sine[i] = nil
cosine[i] = nil
bullet_x[i] = nil
bullet_y[i] = nil
end

bullet = temp

if bullet == 0 then
cosine = {} 
sine = {}
bullet_x = {}
bullet_y = {}
end

end


function drawbullet(color)
for i = 1, bullet do
screen.drawpixel(bullet_x[i],bullet_y[i],color)
end
end

star_x ={}
star_y = {}
function createstars()
local i
for i = 1, 50 do
star_x[i] = math.random(width)
star_y[i] = math.random(height)
end
end
function drawstars(color)
local i
for i = 1, 50 do
screen.drawpixel(star_x[i],star_y[i],color)
end
end

function drawscore(color1,color2)
text.size(10)
text.color(color1)
text.draw(10,10,"Score : "..score,"left")
text.draw(330,10,"Life : "..jet_life,"left")

screen.fillrect(330,22,jet_life/2,3,color1)
screen.fillrect(330+jet_life/2,22,50-jet_life/2,3,color2)
end

fire_x = {}
fire_y = {}
function createfire()
local i
fire_y[0] = -10+jet_y[0]
fire_x[0] = -11+jet_x[0]
fire_y[10] = 10+jet_y[0]
fire_x[10] = -11+jet_x[0]

for i = 1,9 do
fire_y[i] = (jet_y[0]+i*2-10)
fire_x[i] = (jet_x[0]-3-(math.random(5)+10))
end

for i = 0,10 do
local m = jet_x[0] + (fire_x[i]-jet_x[0])*cosine_xxx - (fire_y[i]-jet_y[0])*sine_xxx
local n = jet_y[0] + (fire_x[i]-jet_x[0])*sine_xxx + (fire_y[i]-jet_y[0])*cosine_xxx  
fire_x[i] = m
fire_y[i] = n
end

end

function drawfire(color)
local i
for i = 1,10 do
screen.drawline(fire_x[i-1],fire_y[i-1],fire_x[i],fire_y[i],color,1)
end
end

--[[
function drawfire(color)
for i = 1,10 do
for j = 0, 5 do
screen.drawline(fire_x[i-1]+cosine_xxx*j,fire_y[i-1]+sine_xxx*j,fire_x[i]+cosine_xxx*j,fire_y[i]+sine_xxx*j,color,1)
end
end
end
--]]


createjet()
createmeteor(meteor_no)
createstars()


























while true do
	
if control.read() == 1 then
	if control.isTouch()==1 then
		xtouch,ytouch = touch.pos()
		if touch.down() == 1 then
			pressed = true
		elseif touch.up() == 1 then
			pressed = nil
		elseif touch.click() == 1 then
			pressed = nil
		end
	elseif control.isButton()==1 then
		break
	end
	control.read()
	control.read()
	control.read()
end


if not paused then

if pressed then

if xtouch < 200 and xtouch > 100 and ytouch > 190 and ytouch < height then
thrust = true
end

if xtouch < 100 and ytouch > 190 then
rotation = rotation - 8
rotating = true
elseif xtouch < width and xtouch > 300 and ytouch > 190 and ytouch < height then
rotation = rotation + 8
rotating = true
end



if xtouch < 300 and xtouch > 200 and ytouch > 190 and ytouch < height then
fire = true
end

else
rotating = nil
fire = nil
thrust = nil
end



drawstars(color_white)

---------------------------------------------
if jet_hit then
color = color_lightred
jet_hit = nil
else
color = color_lightblack
end
screen.fillrect(0,190,99,50,color)
screen.fillrect(100,190,99,50,color)
screen.fillrect(200,190,99,50,color)
screen.fillrect(300,190,100,50,color)
color = nil
-------------------------------------------------

if rotating then
rotatejet()
end

if fire and timer == bullet_delay then
createbullet()
timer = 0
end
if timer < bullet_delay then
timer = timer + 1
end

if thrust then
createfire()
drawfire(color_yellow)
end

movemeteor(meteor_no)
drawmeteor(meteor_no,color_brown)
movebullet()

if bullet_remove then
removebullet()
bullet_remove = nil
end

drawbullet(color_yellow)
movejet()
drawjet(color_white,color_red)
drawscore(color_white,color_lightred)

collectgarbage()

screen.update()
os.sleep(1)

----------------------------------for score and life
if jet_life < 1 then
jet_life = 0
paused = true
else

screen.fillrect(10,10,70,10,color_black)
screen.fillrect(330,10,350,10,color_black)

drawstars(color_black)
drawbullet(color_black)
drawjet(color_black,color_black)
drawmeteor(meteor_no,color_black)

if thrust then
drawfire(color_black)
fire_x = {}
fire_y = {}
end

end

else

if not abc then
pressed = nil
screen.fillrect(0,0,width,height,color_trans)

text.size(50)
text.color(color_white)
text.draw(0,50,"Game Over","center")
text.size(10)
text.draw(170,115,"Score : "..score,"left")

dofile("score.lua")
io.open("score.lua","r")
hscore = highscore
io.close()

if score > hscore then
save = io.open("score.lua","w+")
save:write("highscore = "..score)
io.close()
print(score,hscore)
text.draw(170,130,"Highscore : "..score,"left")
else
text.draw(170,130,"Highscore : "..hscore,"left")
end


screen.update()
abc = true
screen.fillrect(0,0,width,height,color_black)
end

if pressed then
jet_life = 100
score = 0
paused = nil
createmeteor(meteor_no)
abc = nil
end

os.sleep(1)
end

end
	
