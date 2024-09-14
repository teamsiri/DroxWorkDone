URL     = require("./libs/url")
JSON    = require("./libs/dkjson")
serpent = require("libs/serpent")
json = require('libs/json')
Redis = require('libs/redis').connect('127.0.0.1', 6379)
http  = require("socket.http")
https   = require("ssl.https")
-------------------


local Methods = io.open("./luatele.lua","r")
if Methods then
URL.tdlua_CallBack()
end
SshId = io.popen("echo $SSH_CLIENT ︙ awk '{ print $1}'"):read('*a')
luatele = require 'luatele'
local FileInformation = io.open("./Information.lua","r")
if not FileInformation then
if not Redis:get(SshId.."Info:Redis:Token") then
io.write('\27[1;31mارسل لي توكن البوت الان \nSend Me a Bot Token Now ↡\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe')
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mعذرا توكن البوت خطأ تحقق منه وارسله مره اخره \nBot Token is Wrong\n')
else
io.write('\27[1;34mتم حفظ التوكن بنجاح \nThe token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TheTokenBot)
Redis:set(SshId.."Info:Redis:Token",TokenBot)
Redis:set(SshId.."Info:Redis:Token:User",Json_Info.result.username)
end 
else
print('\27[1;34mلم يتم حفظ التوكن جرب مره اخره \nToken not saved, try again')
end 
os.execute('lua BuKa.lua')
end
if not Redis:get(SshId.."Info:Redis:User") then
io.write('\27[1;31mارسل معرف المطور الاساسي الان \nDeveloper UserName saved ↡\n\27[0;39;49m')
local UserSudo = io.read():gsub('@','')
if UserSudo ~= '' then
io.write('\n\27[1;34mتم حفظ معرف المطور \nDeveloper UserName saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User",UserSudo)
else
print('\n\27[1;34mلم يتم حفظ معرف المطور الاساسي \nDeveloper UserName not saved\n')
end 
os.execute('lua BuKa.lua')
end
if not Redis:get(SshId.."Info:Redis:User:ID") then
io.write('\27[1;31mارسل ايدي المطور الاساسي الان \nDeveloper ID saved ↡\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('(%d+)') then
io.write('\n\27[1;34mتم حفظ ايدي المطور \nDeveloper ID saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User:ID",UserId)
else
print('\n\27[1;34mلم يتم حفظ ايدي المطور الاساسي \nDeveloper ID not saved\n')
end 
os.execute('lua BuKa.lua')
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Redis:get(SshId.."Info:Redis:Token")..[[",
UserBot = "]]..Redis:get(SshId.."Info:Redis:Token:User")..[[",
UserSudo = "]]..Redis:get(SshId.."Info:Redis:User")..[[",
SudoId = ]]..Redis:get(SshId.."Info:Redis:User:ID")..[[
}
]])
Informationlua:close()
local BuKa = io.open("BuKa", 'w')
BuKa:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
lua5.3 BuKa.lua
done
]])
BuKa:close()
local Run = io.open("Run", 'w')
Run:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
screen -S ]]..Redis:get(SshId.."Info:Redis:Token:User")..[[ -X kill
screen -S ]]..Redis:get(SshId.."Info:Redis:Token:User")..[[ ./BuKa
done
]])
Run:close()
Redis:del(SshId.."Info:Redis:User:ID");Redis:del(SshId.."Info:Redis:User");Redis:del(SshId.."Info:Redis:Token:User");Redis:del(SshId.."Info:Redis:Token")
os.execute('chmod +x BuKa;chmod +x Run;./Run')
end
Information = dofile('./Information.lua')
Sudo_Id = Information.SudoId
UserSudo = Information.UserSudo
Token = Information.Token
UserBot = Information.UserBot
BuKa = Token:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..BuKa)
LuaTele = luatele.set_config{api_id=1846213,api_hash='c545c613b78f18a30744970910124d53',session_name=BuKa,token=Token}
function var(value)
print(serpent.block(value, {comment=false}))   
end 
function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
return './'..name
end
end
clock = os.clock
function sleep(n)
local t0 = clock()
while clock() - t0 <= n do end
end

function Dev(msg) 
local var = false 
local SudoIds ={Sudo_Id,6590885543}  
for k,v in pairs(SudoIds) do 
if tonumber(msg.sender_id.user_id) == v then 
var = true 
end 
end 
if tonumber(msg.sender_id.user_id) == tonumber(Sudo_Id) or Redis:sismember(BuKa.."Dev",msg.sender_id.user_id) then
var = true 
end 
return var 
end
function Run(msg,data)  

if data.content and data.content.text and data.content.text.text then
text = data.content.text.text
end
if msg.message then
msg = msg.message
if msg.content.text and msg.content.text.text then
text = msg.content.text.text
end
end
if data.sender_id and data.sender_id.user_id then
if tonumber(data.sender_id.user_id) == tonumber(BuKa) then
return false
end
end
function markup(keyboard,inline)
local response = {} 
response.keyboard = keyboard  
response.inline_keyboard = inline 
response.resize_keyboard = true 
response.one_time_keyboard = false 
response.selective = false  
return JSON.encode(response) 
end
function ChannelJoin(id)
JoinChannel = true
local chh = Redis:get(BuKa.."chfalse")
if chh then
local url = https.request("https://api.telegram.org/bot"..Token.."/getchatmember?chat_id="..chh.."&user_id="..id)
data = json:decode(url)
if data.result.status == "left" or data.result.status == "kicked" then
JoinChannel = false 
end
end 
return JoinChannel
end
function send(chat,rep,text,parse,dis,clear,disn,back,markup)
LuaTele.sendText(chat,rep,text,parse,dis, clear, disn, back, markup)
end
if msg.sender_id and msg.sender_id.user_id then
if msg.sender_id.user_id == tonumber(BuKa) then
return false
end
if Redis:get(BuKa.."chsource") then
chsource = Redis:get(BuKa.."chsource")
else
chsource = "cllllllT"
end
function Reply_Status(UserId,TextMsg)
local UserInfo = LuaTele.getUser(UserId)
Name_User = UserInfo.first_name
if Name_User then
UserInfousername = '['..Name_User..'](tg://user?id='..UserId..')'
else
UserInfousername = UserId
end
return {
Lock     = '\n*⇘: بواسطه ↜ *'..UserInfousername..'\n*'..TextMsg..'\n⇘:خاصيه المسح *',
unLock   = '\n*⇘: بواسطه ↜ *'..UserInfousername..'\n'..TextMsg,
lockKtm  = '\n*⇘: بواسطه ↜ *'..UserInfousername..'\n*'..TextMsg..'\n⇘:خاصيه الكتم *',
lockKid  = '\n*⇘: بواسطه ↜ *'..UserInfousername..'\n*'..TextMsg..'\n⇘:خاصيه التقييد *',
lockKick = '\n*⇘: بواسطه ↜ *'..UserInfousername..'\n*'..TextMsg..'\n⇘:خاصيه الطرد *',
Reply    = '\n*⇘: المستخدم ↜ *'..UserInfousername..'\n*'..TextMsg..'*'
}
end

if Dev(msg) then
if text == "تحديث" or text == "⌯ اعادة تشغيل الملفات ⌯" then
LuaTele.sendText(msg.chat_id,msg.id,"⇘: تمت اعاده تشغيل الملفات بنجاح ✅")
dofile('BuKa.lua')  
return false 
end
if msg.reply_to_message_id ~= 0 then
local Message_Get = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Get.forward_info then
local Info_User = Redis:get(BuKa.."Twasl:UserId"..Message_Get.forward_info.date) or 46899864
if text == 'حظر' then
Redis:sadd(BuKa..'BaN:In:Tuasl',Info_User)  
return send(msg.chat_id,msg.id,Reply_Status(Info_User,'⇘: تم حظره من الصانع').Reply,"md",true)  
end 
if text =='الغاء الحظر' or text =='الغاء حظر' then
Redis:srem(BuKa..'BaN:In:Tuasl',Info_User)  
return send(msg.chat_id,msg.id,Reply_Status(Info_User,'⇘: تم الغاء حظره من الصانع ').Reply,"md",true)  
end 
end
end
if text == "⌯ الغاء الامر ⌯" then
Redis:del(BuKa..msg.sender_id.user_id.."bottoken")
Redis:del(BuKa..msg.sender_id.user_id.."botuser")
Redis:del(BuKa..msg.sender_id.user_id.."make:bot")
return send(msg.chat_id,msg.id,"⇘: تم الغاء الامر بنجاح")
end
if text == "/start" then
Redis:del(BuKa..msg.sender_id.user_id.."bottoken")
Redis:del(BuKa..msg.sender_id.user_id.."botuser")
Redis:del(BuKa..msg.sender_id.user_id.."make:bot")
reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = '⌯ انشاء بوت ⌯',type = 'text'},{text = '⌯ حذف بوت ⌯',type = 'text'},
},
{
{text = '⌯ تشغيل بوت ⌯',type = 'text'},{text = '⌯ ايقاف بوت ⌯',type = 'text'},
},
{
{text = '⌯ الغاء الامر ⌯',type = 'text'},
},
{
{text = '⌯ Team Drox - سورس دروكس ⌯',type = 'text'},
},
}
}
send(msg.chat_id,msg.id,"⇘: اهلا بك عزيزي المطور الاساسي \n","md",true, false, false, true, reply_markup)
return false 
end
---
if text and text:match("^رفع مطور (%d+)$") then
Redis:sadd(BuKa.."Dev",text:match("^رفع مطور (%d+)$"))
send(msg.chat_id,msg.id,'⇘: تم رفع العضو مطور ف الصانع بنجاح ',"md",true)  
return false 
end
if text and text:match("^تنزيل مطور (%d+)$") then
Redis:sadd(BuKa.."Dev",text:match("^تنزيل مطور (%d+)$"))
send(msg.chat_id,msg.id,'⇘: تم تنزيل العضو مطور من الصانع بنجاح ',"md",true)  
return false 
end

if text == "⌯ تفعيل الوضع المجاني ⌯" then 
Redis:del(BuKa.."free:bot")
send(msg.chat_id,msg.id,'⇘: تم تفعيل الوضع المجاني ',"md",true)  
end
if text == "⌯ تعطيل الوضع المجاني ⌯" then 
Redis:set(BuKa.."free:bot",true)
send(msg.chat_id,msg.id,'⇘: تم تعطيل الوضع المجاني ',"md",true)  
end
if text == "⌯ Team Drox - سورس دروكس ⌯" then 
send(msg.chat_id,msg.id,"˛ 𝘞𝘦𝘭𝘤𝘰𝘮𝘦 𝘵𝘰 TeamDrox \n𝘛𝘩𝘦 𝘴𝘰𝘶𝘳𝘤𝘦 𝘪𝘴 𝘥𝘦𝘥𝘪𝘤𝘢𝘵𝘦𝘥 𝘵𝘰 𝘱𝘶𝘣𝘭𝘪𝘴𝘩𝘪𝘯𝘨 𝘣𝘰𝘵𝘴 𝘢𝘯𝘥 𝘴𝘰𝘧𝘵𝘸𝘢𝘳𝘦 𝘰𝘣𝘫𝘦𝘤𝘵𝘴 \n𝘈𝘯𝘥 𝘴𝘦𝘭𝘭𝘪𝘯𝘨 𝘧𝘪𝘭𝘦𝘴 𝘪𝘯 𝘢𝘭𝘭 𝘭𝘢𝘯𝘨𝘶𝘢𝘨𝘦𝘴, 𝘓𝘶𝘢, 𝘗𝘏𝘗, 𝘗𝘺𝘵𝘩𝘰𝘯\n\n𝘋𝘦𝘷𝘦𝘭𝘰𝘱𝘦𝘳: @YIPll \nDrox source: @TeADRox\n𝘞𝘦 𝘥𝘰𝘯𝘵 𝘩𝘢𝘷𝘦 𝘢𝘯𝘺 𝘰𝘵𝘩𝘦𝘳 𝘢𝘤𝘤𝘰𝘶𝘯𝘵𝘴 𝘰𝘵𝘩𝘦𝘳 𝘵𝘩𝘢𝘯 𝘵𝘩𝘦𝘴𝘦 .","md",true)  
if text == "source" then 
send(msg.chat_id,msg.id,"hello @dython , dev @ssuxs .","md",true)  
end
-----تشغيل البوتات ---
if text and Redis:get(BuKa..msg.sender_id.user_id.."run:bot") then
Redis:del(BuKa..msg.sender_id.user_id.."run:bot")
Redis:del(BuKa.."screen:on")
Redis:del(BuKa.."bots:folder")
userbot = text:gsub("@","")
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
Redis:sadd(BuKa.."bots:folder",folder:gsub("@",""))
end
end
if not Redis:sismember(BuKa.."bots:folder",userbot) then
send(msg.chat_id,msg.id,"⇘: عفوا هذا البوت ليس ضمن البوتات المصنوعه")
return false 
end
for screen in io.popen('ls /var/run/screen/S-root'):lines() do
Redis:sadd(BuKa.."screen:on",screen)
end
local list = Redis:smembers(BuKa..'screen:on')
for k,v in pairs(list) do
if v:match("(%d+)."..userbot) then
send(msg.chat_id,msg.id,"⇘: هذا البوت يعمل بالفعل")
return false 
end
end
os.execute("cd @"..userbot.." ; screen -d -m -S "..userbot.." ./Run")
send(msg.chat_id,msg.id,"⇘: تم تشغيل البوت @"..userbot.." بنجاح")
return false 
end
if text == "⌯ تشغيل بوت ⌯" then
Redis:set(BuKa..msg.sender_id.user_id.."run:bot",true)
send(msg.chat_id,msg.id,"⇘: ارسل معرف البوت ليتم تشغيله")
return false 
end
---ايقاف البوتات
if text and Redis:get(BuKa..msg.sender_id.user_id.."stop:bot") then
Redis:del(BuKa..msg.sender_id.user_id.."stop:bot")
Redis:del(BuKa.."screen:on")
Redis:del(BuKa.."bots:folder")
userbot = text:gsub("@","")
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
Redis:sadd(BuKa.."bots:folder",folder:gsub("@",""))
end
end
if not Redis:sismember(BuKa.."bots:folder",userbot) then
send(msg.chat_id,msg.id,"⇘: عفوا هذا البوت ليس ضمن البوتات المصنوعه")
return false 
end
for screen in io.popen('ls /var/run/screen/S-root'):lines() do
Redis:sadd(BuKa.."screen:on",screen)
end
local list = Redis:smembers(BuKa..'screen:on')
for k,v in pairs(list) do
if v:match("(%d+)."..userbot) then
os.execute('screen -X -S '..userbot..' quit')
send(msg.chat_id,msg.id,"⇘: تم ايقاف البوت @"..userbot.." بنجاح")
return false 
end
end
send(msg.chat_id,msg.id,"⇘: البوت متوقف بالفعل")
return false 
end
if text == "⌯ ايقاف بوت ⌯" then
Redis:set(BuKa..msg.sender_id.user_id.."stop:bot",true)
send(msg.chat_id,msg.id,"⇘: ارسل معرف البوت ليتم ايقافه")
return false 
end
--الاشتراك الاجباري 
if Redis:get(BuKa.."ch:addd"..msg.sender_id.user_id) == "on" then
Redis:set(BuKa.."ch:addd"..msg.sender_id.user_id,"off")
local m = https.request("http://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
da = json:decode(m)
if da.result.invite_link then
local ch = da.result.id
send(msg.chat_id,msg.id,'⇘: تم حفظ القناه ',"md",true)  
Redis:del(BuKa.."chfalse")
Redis:set(BuKa.."chfalse",ch)
Redis:del(BuKa.."ch:admin")
Redis:set(BuKa.."ch:admin",da.result.invite_link)
else
send(msg.chat_id,msg.id,'⇘: المعرف خطأ او البوت ليس مشرف في القناه ',"md",true)  
end
end
if text == "⌯ تفعيل الاشتراك الاجباري ⌯" then
Redis:set(BuKa.."ch:addd"..msg.sender_id.user_id,"on")
send(msg.chat_id,msg.id,'⇘: ارسل الان معرف القناه ',"md",true)  
end
if text == "⌯ تعطيل الاشتراك الاجباري ⌯" then
Redis:del(BuKa.."ch:admin")
Redis:del(BuKa.."chfalse")
send(msg.chat_id,msg.id,'⇘: تم حذف القناه ',"md",true)  
end
if text and Redis:get(BuKa..msg.sender_id.user_id.."make:bot") == "devuser" then
local UserName = text:match("^@(.*)$")
if UserName then
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
send(msg.chat_id,msg.id,"⇘: اليوزر ليس لحساب شخصي تأكد منه ","md",true)  
return false
end
if UserId_Info.type.is_channel == true then
send(msg.chat_id,msg.id,"⇘: اليوزر لقناه او مجموعه تأكد منه","md",true)  
return false
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
send(msg.chat_id,msg.id,"⇘: عذرا يجب ان تستخدم معرف لحساب شخصي فقط ","md",true)  
return false
end
local bottoken = Redis:get(BuKa..msg.sender_id.user_id.."bottoken")
local botuser = Redis:get(BuKa..msg.sender_id.user_id.."botuser")
local uu = LuaTele.getUser(UserId_Info.id)
local Informationlua = io.open("./source/Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..bottoken..[[",
UserBot = "]]..botuser..[[",
UserSudo = "]]..UserName..[[",
SudoId = ]]..UserId_Info.id..[[
}
]])
Informationlua:close()
os.execute('cp -a ./source/. ./@'..botuser..' && cd @'..botuser..' && chmod +x * && screen -d -m -S '..botuser..' ./Run')
botid = bottoken:match("(%d+)")
Redis:set('@'..botuser,botid.."&"..'@'..botuser.."$"..UserId_Info.id.."+"..bottoken)
Redis:sadd(BuKa.."userbots",botuser)
Redis:del(BuKa..msg.sender_id.user_id.."bottoken")
Redis:del(BuKa..msg.sender_id.user_id.."botuser")
Redis:del(BuKa..msg.sender_id.user_id.."make:bot")
send(msg.chat_id,msg.id,"⇘: تم تشغيل البوت بنجاح \n⇘: معرف البوت [@"..botuser.."]\n⇘: المطور ⇘: ["..uu.first_name.."](tg://user?id="..UserId_Info.id..")","md",true)  
else
send(msg.chat_id,msg.id,"⇘: اليوزر ليس لحساب شخصي تأكد منه ","md",true)  
end
end
if text and Redis:get(BuKa..msg.sender_id.user_id.."make:bot") == "token" then
if text:match("(%d+):(.*)") then
local url = https.request("http://api.telegram.org/bot"..text.."/getme")
local json = JSON.decode(url)
if json.ok == true then
local botuser = json.result.username
if Redis:sismember(BuKa.."userbots",botuser) then
send(msg.chat_id,msg.id, "\n⇘: عذرا هذا البوت مصنوع بالفعل","md",true)  
return false 
end 
Redis:set(BuKa..msg.sender_id.user_id.."botuser",botuser)
Redis:set(BuKa..msg.sender_id.user_id.."bottoken",text)
Redis:set(BuKa..msg.sender_id.user_id.."make:bot","devuser")
send(msg.chat_id,msg.id, "\n⇘: ارسل الان معرف المطور الاساسي ")
return false 
end
send(msg.chat_id,msg.id, "\n⇘: التوكن الذي ارسلته غير صحيح ")
return false
end
send(msg.chat_id,msg.id, "\n⇘: من فضلك ارسل التوكن بشكل صحيح ")
end
if text == "⌯ انشاء بوت ⌯" then
Redis:set(BuKa..msg.sender_id.user_id.."make:bot","token")
send(msg.chat_id,msg.id, "\n⇘: ارسل توكن البوت الان","md",true)  
return false 
end 
----------end making
----broadcast all
if Redis:get(BuKa.."all:texting") then
if text == "الغاء" or text == '⌯ الغاء الامر ⌯' then   
Redis:del(BuKa.."all:texting")
send(msg.chat_id,msg.id, "\n⇘: تم الغاء الاذاعه","md",true)  
return false 
end 
Redis:set(BuKa.."3z:gp",text)
Redis:del(BuKa.."all:texting")
send(msg.chat_id,msg.id,"⇘: جاري عمل الاذاعه لكل البوتات ومجموعاتهم يرجي الانتظار ...","html",true)
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
m = Redis:get(folder)
x = {m:match("(.*)&(.*)$(.*)+(.*)")}
bot_id = x[1]
botuser = x[2] 
devbot = x[3]
bottoken = x[4]
list = Redis:smembers(bot_id.."BuKa:ChekBotAdd") 
for k,v in pairs(list) do
https.request("https://api.telegram.org/bot"..bottoken.."/sendmessage?chat_id="..v.."&text="..URL.escape(Redis:get(BuKa.."3z:gp")).."&parse_mode=Markdown")
end
end
end
Redis:del(BuKa.."3z:gp")
Redis:del(BuKa.."all:texting")
send(msg.chat_id,msg.id,"⇘: تم انتهاء الاذاعه في كل البوتات","html",true)
end
if Redis:get(BuKa.."all:texting:pv") then
if text == "الغاء" or text == '⌯ الغاء الامر ⌯' then   
Redis:del(BuKa.."all:texting:pv")
send(msg.chat_id,msg.id, "\n⇘: تم الغاء الاذاعه","md",true)  
return false 
end 
Redis:set(BuKa.."eza3a:pv",text)
Redis:del(BuKa.."all:texting:pv")
send(msg.chat_id,msg.id,"⇘: جاري عمل الاذاعه لكل البوتات ومطورينهم ومشتركينهم يرجي الانتظار ...","html",true)
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
m = Redis:get(folder)
x = {m:match("(.*)&(.*)$(.*)+(.*)")}
bot_id = x[1]
botuser = x[2] 
devbot = x[3]
bottoken = x[4]
list = Redis:smembers(bot_id.."BuKa:Num:User:Pv") 
for k,v in pairs(list) do
https.request("https://api.telegram.org/bot"..bottoken.."/sendmessage?chat_id="..v.."&text="..URL.escape(Redis:get(BuKa.."eza3a:pv")).."&parse_mode=Markdown")
end
end
end
Redis:del(BuKa.."eza3a:pv")
Redis:del(BuKa.."all:texting:pv")
send(msg.chat_id,msg.id,"⇘: تم انتهاء الاذاعه في كل البوتات","html",true)
end
if text == "⌯ اذاعة عام للمجموعات ⌯" then
Redis:set(BuKa.."all:texting",true)
send(msg.chat_id,msg.id,"ارسل النص الان","html",true)
end
if text == "⌯ اذاعة عام للمشتركين ⌯" then
Redis:set(BuKa.."all:texting:pv",true)
send(msg.chat_id,msg.id,"ارسل النص الان","html",true)
end
-------screen -ls
if text == "⌯ السكرينات المفتوحة ⌯" then  
rqm = 0
local message = ' ⇘: السكرينات الموجوده بالسيرفر \n\n'
for screnName in io.popen('ls /var/run/screen/S-root'):lines() do
rqm = rqm + 1
message = message..rqm..'-  { `'..screnName..' `}\n'
end
send(msg.chat_id,msg.id,message..'\n حاليا عندك `'..rqm..'` اسكرين مفتوح ...\n',"md",true)
return false
end
---all stutes
if text == "⌯ معلومات البوتات المصنوعة ⌯" then
local txx = "⇘: تقرير باحصائيات بوتاتك\n"
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
m = Redis:get(folder)
x = {m:match("(.*)&(.*)$(.*)+(.*)")}
bot_id = x[1]
botuser = x[2] 
devbot = x[3]
bottoken = x[4]
list = Redis:smembers(bot_id.."BuKa:ChekBotAdd") 
lt = Redis:smembers(bot_id.."BuKa:Num:User:Pv") 
txx = txx.."⇘: ["..botuser.."] *("..#list.." GP)*".." *("..#lt.." PV)*".."\n"
end
end
send(msg.chat_id,msg.id,txx,"md",true)
end
if text == "⌯ فحـص ⌯" then
Redis:del(BuKa.."All:pv:st")
Redis:del(BuKa.."All:gp:st")
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
m = Redis:get(folder)
x = {m:match("(.*)&(.*)$(.*)+(.*)")}
bot_id = x[1]
botuser = x[2] 
devbot = x[3]
bottoken = x[4]
list = Redis:smembers(bot_id.."BuKa:ChekBotAdd") 
lt = Redis:smembers(bot_id.."BuKa:Num:User:Pv") 
Redis:incrby(BuKa.."All:gp:st",tonumber(#list))
Redis:incrby(BuKa.."All:pv:st",tonumber(#lt))
end
end
send(msg.chat_id,msg.id,'\n⇘: احصائيات جميع البوتات المصنوعه \n ⇘: عدد المجموعات '..Redis:get(BuKa.."All:gp:st")..' مجموعه \n⇘: عدد المشتركين '..Redis:get(BuKa.."All:pv:st")..' مشترك',"html",true)
end
-----ban all
if text and text:match('^حظر عام (%d+)$') then
local id = text:match('^حظر عام (%d+)$')
local U = LuaTele.getUser(id)
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
m = Redis:get(folder)
x = {m:match("(.*)&(.*)$(.*)+(.*)")}
bot_id = x[1]
Redis:sadd(bot_id.."BuKa:BanAll:Groups",id) 
end
end
if U.first_name then
name = U.first_name
else
name = id
end
send(msg.chat_id,msg.id,"⇘: الكلب ["..name.."](tg://user?id="..id..")\n⇘: تم حظره عام","md",true)
end
if text and text:match('^الغاء عام (%d+)$') then
local id = text:match('^الغاء عام (%d+)$')
local U = LuaTele.getUser(id)
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
m = Redis:get(folder)
x = {m:match("(.*)&(.*)$(.*)+(.*)")}
bot_id = x[1]
Redis:srem(bot_id.."BuKa:BanAll:Groups",id) 
end
end
if U.first_name then
name = U.first_name
else
name = id
end
send(msg.chat_id,msg.id,"⇘: العضو ["..name.."](tg://user?id="..id..")\n⇘: تم الغاء حظره عام","md",true)
end
----update bots
if text == "⌯ تحديث المصنوعات ⌯" then
Redis:del(BuKa..'3ddbots')
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
os.execute('cp -a ./update/. ./'..folder..' && cd '..folder..' &&chmod +x * && screen -X -S '..folder:gsub("@","")..' quit && screen -d -m -S '..folder:gsub("@","")..' ./Run')
Redis:sadd(BuKa..'3ddbots',folder)
end
end
os.execute('cp -a ./update/. ./source')
local list = Redis:smembers(BuKa..'3ddbots')
send(msg.chat_id,msg.id,"تم تحديث "..#list.." بوت","html",true)  
end
if text == "⌯ تشغيل البوتات ⌯" then
Redis:del(BuKa..'3ddbots')
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
os.execute('cd '..folder..' && chmod +x * && screen -d -m -S '..folder:gsub("@","")..' ./Run')
Redis:sadd(BuKa..'3ddbots',folder)
end
end
local list = Redis:smembers(BuKa..'3ddbots')
send(msg.chat_id,msg.id,"تم تشغيل "..#list.." بوت","html",true)  
end
--------mange bots
if text == "⌯ تصفية المصنوعات ⌯" then
Redis:del(BuKa.."fake")
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
m = Redis:get(folder)
x = {m:match("(.*)&(.*)$(.*)+(.*)")}
bot_id = x[1]
botuser = x[2] 
devbot = x[3]
bottoken = x[4]
list = Redis:smembers(bot_id.."BuKa:ChekBotAdd") 
lt = Redis:smembers(bot_id.."BuKa:Num:User:Pv") 
if #list < 2 then
Redis:sadd(BuKa.."fake",botuser )
os.execute("sudo rm -fr "..botuser)
os.execute('screen -X -S '..botuser:gsub("@","")..' quit')
end
end
end
local list = Redis:smembers(BuKa..'fake')
send(msg.chat_id,msg.id,"⇘: تم ايقاف "..#list.." بوت \n عدد مجموعاتهم اقل من 2","html",true)
end
if text == "⌯ المصنوعات الوهمية ⌯" then
local txx = "قائمه بوتاتك الوهيمه \n"
local Abs = 0
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
m = Redis:get(folder)
x = {m:match("(.*)&(.*)$(.*)+(.*)")}
bot_id = x[1]
botuser = x[2] 
devbot = x[3]
bottoken = x[4]
list = Redis:smembers(bot_id.."BuKa:ChekBotAdd") 
lt = Redis:smembers(bot_id.."BuKa:Num:User:Pv") 
if #list < 2 then
Abs = Abs + 1
txx = txx.."⇘: "..botuser.." » "..#list.."\n"
end
end
end
if Abs == 0 then
return send(msg.chat_id,msg.id,"لاتوجد بوتات وهميه","html",true)
end
send(msg.chat_id,msg.id,txx,"html",true)
end
-------delete 
if text and Redis:get(BuKa..msg.sender_id.user_id.."make:bot") == "del" then
if text == "الغاء" or text == '⌯ الغاء الامر ⌯' then   
Redis:del(BuKa..msg.sender_id.user_id.."make:bot")
send(msg.chat_id,msg.id, "\n⇘: تم الغاء تعيين قناه ال⌯ السورس ⌯","md",true)  
return false 
end 
Redis:del(BuKa..msg.sender_id.user_id.."make:bot")
os.execute("sudo rm -fr "..text)
os.execute("screen -X -S "..text:gsub("@","").." quit")
Redis:srem(BuKa.."userbots",text:gsub("@",""))
send(msg.chat_id,msg.id, "\n⇘: تم حذف البوت بنجاح","md",true)  
return false 
end 
if text == "⌯ حذف بوت ⌯" then
Redis:set(BuKa..msg.sender_id.user_id.."make:bot","del")
send(msg.chat_id,msg.id, "\n⇘: ارسل معرف البوت الان","md",true)  
return false 
end 
----end deleting 
-----states
if text == "⌯ عدد البوتات ⌯" then
Redis:del(BuKa..'3ddbots')
bots = "\nقائمه البوتات\n"
botat = "\nقائمه البوتات\n"
for folder in io.popen('ls'):lines() do
if folder:match('@[%a%d_]') then
m = Redis:get(folder)
x = {m:match("(.*)&(.*)$(.*)+(.*)")}
bot_id = x[1]
botuser = x[2] 
devbot = x[3]
bottoken = x[4]
Redis:sadd(BuKa..'3ddbots',botuser..' » '..devbot)
end
end
local list = Redis:smembers(BuKa..'3ddbots')
if #list <= 100 then
for k,v in pairs(list) do
bots = bots..' '..k..'-'..v..'\n'
end
else
for k = 1,100 do
bots = bots..' '..k..'-'..list[k]..'\n'
end
for i = 101 , #list do
botat = botat..' '..i..'-'..list[i]..'\n'
end
end
if #list <= 100 then
send(msg.chat_id,msg.id,bots.."\n".."وعددهم "..#list.."","html",true)  
else
send(msg.chat_id,msg.id,bots,"html",true)  
send(msg.chat_id,msg.id,botat.."\n".."وعددهم "..#list.."","html",true)  
end
end
----end--3dd
if text and Redis:get(BuKa..msg.sender_id.user_id.."setchannel") then
if text == "الغاء" or text == '⌯ الغاء الامر ⌯' then   
Redis:del(BuKa..msg.sender_id.user_id.."setchannel")
send(msg.chat_id,msg.id, "\n⇘: تم الغاء تعيين قناه ال⌯ السورس ⌯","md",true)  
return false 
end 
if text:match("@(.*)") then
local ch = text:match("@(.*)")
Redis:set(BuKa.."chsource",ch)
send(msg.chat_id,msg.id,"⇘: تم تعيين قناه البوت بنجاح")
Redis:del(BuKa..msg.sender_id.user_id.."setchannel")
else
send(msg.chat_id,msg.id,"⇘: ارسل المعرف مع علامه @")
end
end
if text == "⇘: تعيين قناه البوت" then
Redis:set(BuKa..msg.sender_id.user_id.."setchannel",true)
send(msg.chat_id,msg.id,"⇘: ارسل الان معرف القناه")
return false 
end
if text == "⌯ تفعيل التواصل ⌯" then
Redis:del(BuKa.."twsl")
send(msg.chat_id,msg.id,"⇘: تم تفعيل التواصل")
return false 
end
if text == "⌯ تعطيل التواصل ⌯" then
Redis:set(BuKa.."twsl",true)
send(msg.chat_id,msg.id,"⇘: تم تعطيل التواصل")
return false 
end
if text == "⌯ الاحصائيات ⌯" then
local list = Redis:smembers(BuKa.."total")
send(msg.chat_id,msg.id,"⇘: عدد مشتركين بوتك "..#list.." مشترك")
return false 
end
if text == 'رفع النسخه الاحتياطيه' and msg.reply_to_message_id ~= 0 or text == 'رفع نسخه احتياطيه' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if Name_File ~= UserBot..'.json' then
return send(msg_chat_id,msg_id,'⇘: عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open("./"..UserBot..".json","r"):read('*a')
local FilesJson = JSON.decode(Get_Info)
if tonumber(BuKa) ~= tonumber(FilesJson.BotId) then
return send(msg_chat_id,msg_id,'⇘: عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end botid
send(msg_chat_id,msg_id,'⇘:جاري استرجاع المشتركين والجروبات ...')
Y = 0
for k,v in pairs(FilesJson.UsersBot) do
Y = Y + 1
Redis:sadd(BuKa..'total',v)  
end
end
end
if text == "جلب نسخه" then
local UsersBot = Redis:smembers(BuKa.."total")
local Get_Json = '{"BotId": '..BuKa..','  
if #UsersBot ~= 0 then 
Get_Json = Get_Json..'"UsersBot":['  
for k,v in pairs(UsersBot) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
local File = io.open('./'..UserBot..'.json', "w")
File:write(Get_Json)
File:close()
return LuaTele.sendDocument(msg.chat_id,msg.id,'./'..UserBot..'.json', '*• تم جلب النسخه الاحتياطيه\n• تحتوي على 0 جروب \n• وتحتوي على {'..#UsersBot..'} مشترك *\n', 'md')
end
----brodcast all

--brodcast
if Redis:get(BuKa..msg.sender_id.user_id.."brodcast") then 
if text == "الغاء" or text == '⌯ الغاء الامر ⌯' then   
Redis:del(BuKa..msg.sender_id.user_id.."brodcast") 
send(msg.chat_id,msg.id, "\n⇘: تم الغاء الاذاعه","md",true)  
return false 
end 
local list = Redis:smembers(BuKa.."total") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then   
for k,v in pairs(list) do 
send(v,0,text,"md",true)  
end
end
send(msg.chat_id,msg.id,"⇘: تمت الاذاعه الى *- "..#list.." * عضو في البوت ","md",true)      
Redis:del(BuKa..msg.sender_id.user_id.."brodcast") 
return false
end
if text == "⌯ اذاعة ⌯" then
Redis:set(BuKa..msg.sender_id.user_id.."brodcast",true)
send(msg.chat_id,msg.id,"⇘: ارسل الاذاعه الان")
return false 
end
---fwd
if Redis:get(BuKa..msg.sender_id.user_id.."brodcast:fwd") then 
if text == "الغاء" or text == '⌯ الغاء الامر ⌯' then   
Redis:del(BuKa..msg.sender_id.user_id.."brodcast:fwd")
send(msg.chat_id,msg.id, "\n⇘: تم الغاء الاذاعه بالتوجيه","md",true)    
return false 
end 
if msg.forward_info then 
local list = Redis:smembers(BuKa.."total") 
send(msg.chat_id,msg.id,"⇘: تم التوجيه الى *- "..#list.." * مشترك ف البوت ","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg.chat_id, msg.id,0,0,true,false,false)
end   
Redis:del(BuKa..msg.sender_id.user_id.."brodcast:fwd")
end 
return false
end
if text == "⌯ اذاعة بالتوجية ⌯" then
Redis:set(BuKa..msg.sender_id.user_id.."brodcast:fwd",true)
send(msg.chat_id,msg.id,"⇘: ارسل التوجيه الان")
return false 
end


end -- sudo cmd
--
if not Dev(msg) then
if text and ChannelJoin(msg.sender_id.user_id) == false then
chinfo = Redis:get(BuKa.."ch:admin")
send(msg.chat_id,msg.id,'\n⇘: عليك الاشتراك في قناة البوت لاستخذام الاوامر\n\n'..chinfo..'')
return false 
end
if not Redis:get(BuKa.."twsl") then
if msg.sender_id.user_id ~= tonumber(BuKa) then
if Redis:sismember(BuKa..'BaN:In:Tuasl',msg.sender_id.user_id) then
return false 
end
if msg.id then
Redis:setex(BuKa.."Twasl:UserId"..msg.date,172800,msg.sender_id.user_id)
LuaTele.forwardMessages(Sudo_Id, msg.chat_id, msg.id,0,0,true,false,false)
end   
end
end
if Redis:sismember(BuKa..'BaN:In:Tuasl',msg.sender_id.user_id) then
return false 
end
if text and Redis:get(BuKa.."free:bot") then
return send(msg.chat_id,msg.id,"⇘: الوضع المجاني معطل من قبل مطور الصانع")
end
---making user
if text and Redis:get(BuKa..msg.sender_id.user_id.."make:bot") then
if text == "⌯ الغاء ⌯" then
Redis:del(BuKa..msg.sender_id.user_id.."make:bot")
send(msg.chat_id,msg.id,"⇘: تم الغاء امر صناعه البوت")
return false 
end
local url = https.request("http://api.telegram.org/bot"..text.."/getme")
local json = JSON.decode(url)
if json.ok == true then
local botuser = json.result.username
if Redis:sismember(BuKa.."userbots",botuser) then
send(msg.chat_id,msg.id, "\n⇘: عذرا هذا البوت مصنوع بالفعل","md",true)  
return false 
end 
local uu = LuaTele.getUser(msg.sender_id.user_id)
if uu.username then
username = uu.username
else
username = ""
end
if username == "" then
sudo_state = "["..uu.first_name.."](tg://user?id="..msg.sender_id.user_id..")" 
else
sudo_state = "[@"..username.."]" 
end
local Informationlua = io.open("./source/Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..text..[[",
UserBot = "]]..botuser..[[",
UserSudo = "]]..username..[[",
SudoId = ]]..msg.sender_id.user_id..[[
}
]])
Informationlua:close()
os.execute('cp -a ./source/. ./@'..botuser..' && cd @'..botuser..' && chmod +x * && screen -d -m -S '..botuser..' ./Run')
botid = text:match("(%d+)")
Redis:set('@'..botuser,botid.."&"..'@'..botuser.."$"..msg.sender_id.user_id.."+"..text)
Redis:set(BuKa..msg.sender_id.user_id.."my:bot",botuser)
Redis:sadd(BuKa.."userbots",botuser)
Redis:del(BuKa..msg.sender_id.user_id.."make:bot")
send(Sudo_Id,0,"⇘: تم تنصيب بوت جديد \n⇘: توكن البوت `"..text.."` \n⇘: معرف البوت @["..botuser.."] \n⇘: معرف المطور الاساسي "..sudo_state.."","md",true)
send(msg.chat_id,msg.id,"⇘: تم تنصيب بوتك بنجاح \n⇘: معرف البوت @["..botuser.."] \n⇘: معرف المطور الاساسي "..sudo_state.."","md",true)
return false 
end
send(msg.chat_id,msg.id,"⇘: التوكن غير صحيح تأكد منه")
end

end --non Sudo_Id
end--msg.sender
end--Run
function callback(data)
if data and data.luatele and data.luatele == "updateNewMessage" then
if tonumber(data.message.sender_id.user_id) == tonumber(BuKa) then
return false
end
Run(data.message,data.message)
elseif data and data.luatele and data.luatele == "updateMessageEdited" then
local Message_Edit = LuaTele.getMessage(data.chat_id, data.message_id)
if Message_Edit.sender_id.user_id == BuKa then
return false
end
Run(Message_Edit,Message_Edit)
elseif data and data.luatele and data.luatele == "updateNewCallbackQuery" then
Text = LuaTele.base64_decode(data.payload.data)
IdUser = data.sender_user_id
ChatId = data.chat_id
Msg_id = data.message_id

end--data
end--callback 
luatele.run(callback)
