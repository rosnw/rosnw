--[[
# Dev @ii7MOD •||• Cha @RRlRR 
#-------------------------------------------------------------------
]]

function dl_cb(a,d) end
 
function GetInputFile(file)
local file = file or "" 
if file:match('/') then
infile = {ID= "InputFileLocal", path_  = file}
elseif file:match('^%d+$') then
infile = {ID= "InputFileId", id_ = file}
else
infile = {ID= "InputFilePersistentId", persistent_id_ = file}
end
return infile
end

local clock = os.clock
function sleep(time)  
local untime = clock()
while clock() - untime <= time do end
end

function sendMsg(chat_id,reply_id,text,markup,funcb)
pcall(tdcli_function({
ID="SendMessage",
chat_id_=chat_id,
reply_to_message_id_= reply_id,
disable_notification_=1,
from_background_= 1,
reply_markup_= nil,
input_message_content_={
ID = "InputMessageText",
text_= text,
disable_web_page_preview_= 1,
clear_draft_= 0,
entities_={},
parse_mode_=  {ID = "TextParseModeMarkdown"} ,
}},funcb or dl_cb,nil)
)
end

function sendPhoto(chat_id,reply_id,photo,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessagePhoto",
photo_ = GetInputFile(photo),
added_sticker_file_ids_ = {},
width_ = 0,
height_ = 0,
caption_ = caption or ''
}
},func or dl_cb,nil))
end
	
	 
function sendVoice(chat_id,reply_id,voice,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVoice",
voice_ = GetInputFile(voice),
duration_ = '',
waveform_ = '',
caption_ = caption or ''
}},func or dl_cb,nil))
end

function sendAnimation(chat_id,reply_id,animation,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAnimation",
animation_ = GetInputFile(animation),
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil))
end

function sendAudio(chat_id,reply_id,audio,title,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = '',
title_ = title or '',
performer_ = '',
caption_ = caption or ''
}},func or dl_cb,nil))
end

function sendSticker(chat_id,reply_id,sticker,func)
pcall(tdcli_function({
ID='SendMessage',
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageSticker",
sticker_ = GetInputFile(sticker),
width_ = 0,
height_ = 0
}},func or dl_cb,nil))
end

function sendVideo(chat_id,reply_id,video,caption,func)
pcall(tdcli_function({ 
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 0,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVideo",  
video_ = GetInputFile(video),
added_sticker_file_ids_ = {},
duration_ = 0,
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil))
end


function sendDocument(chat_id,reply_id,document,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageDocument",
document_ = GetInputFile(document),
caption_ = caption
}},func or dl_cb,nil))
end


function fwdMsg(chat_id,from_chat_id,msg_id,func)
pcall(tdcli_function({
ID="ForwardMessages",
chat_id_ = chat_id,
from_chat_id_ = from_chat_id,
message_ids_ = {[0] = msg_id},
disable_notification_ = 0,
from_background_ = 0
},func or dl_cb,nil))
end


function SendMention(chat_id,user_id,msg_id,Text,offset, length) 
pcall(tdcli_function ({ 
ID = "SendMessage", 
chat_id_ = chat_id, 
reply_to_message_id_ = msg_id, 
disable_notification_ = 0, 
from_background_ = 1, 
reply_markup_ = nil, 
input_message_content_ = { 
ID = "InputMessageText", 
text_ = Text, 
disable_web_page_preview_ = 1, 
clear_draft_ = 0, 
entities_ = {[0]={ 
ID="MessageEntityMentionName", 
offset_ = offset , 
length_ = length , 
user_id_ = user_id },},},
},dl_cb, nil))
end
   
function sendChatAction(chatid,action,func)
pcall(tdcli_function({ID = 'SendChatAction',chat_id_ = chatid,action_ = {ID = "SendMessage"..action.."Action",progress_ = 1},}, func or dl_cb,nil))
end

--================================{{  GetChannelFull  }} ===================================
function download_file(Link,Bath)
local Get_Files, res = https.request(Link)
print(res)
if res == 200 then
print("DONLOADING_FROM_URL: "..Link)
local FileD = io.open(Bath,'w+')
FileD:write(Get_Files)
FileD:close()
end
end
--================================{{  GetChannelFull  }} ===================================

function GetFullChat(GroupID,func)
pcall(tdcli_function({ID="GetChannelFull",channel_id_ = GroupID:gsub('-100','')},func or dl_cb,nil))
end

--================================{{  KickUser  }} ===================================

function kick_user(user_id,chat_id,func)
pcall(tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusKicked"}},func or dl_cb,nil))
end

--================================{{  UnBlock  }} ===================================

function StatusLeft(chat_id,user_id,func)
pcall(tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusLeft"}},func or dl_cb,nil))
end
--================================{{  DeleteMsg  }} ===================================

function Del_msg(GroupID,msg_id,func)
pcall(tdcli_function({ID="DeleteMessages",chat_id_=GroupID,message_ids_={[0]=msg_id}},func or dl_cb,nil))
end


function GetPhotoUser(User,func)
pcall(tdcli_function({ID='GetUserProfilePhotos',user_id_=User,offset_=0,limit_=1},func,nil))
end
  
function GetMsgInfo(UID,Msg_id,Cb,Arg)
pcall(tdcli_function({ID="GetMessage",chat_id_ = UID,message_id_ = Msg_id},Cb,Arg))
end

function GetUserName(User,Cb,Arg)
pcall(tdcli_function({ID="SearchPublicChat",username_ = User},Cb,Arg))
end

function GetUserID(User,Cb,Arg)
pcall(tdcli_function({ID="GetUser",user_id_ = User},Cb,Arg))
end


function GroupTitle(GroupID,func)
pcall(tdcli_function({ID="GetChat",chat_id_ = GroupID},func or dl_cb,nil))
end

function GetChannelAdministrators(GroupID,func,limit)
pcall(tdcli_function({ID="GetChannelMembers",channel_id_= GroupID:gsub('-100',''),filter_={ID = "ChannelMembersAdministrators"},offset_=0,limit_=40},func,nil))
end 

function GetChatMember(GroupID,UserID,func)
pcall(tdcli_function({ID='GetChatMember',chat_id_ = GroupID,user_id_ = UserID},func,nil))
end

function GetHistory(GroupID,NumDel,func)
pcall(tdcli_function({ID="GetChatHistory",chat_id_ = GroupID,from_message_id_ = 0,offset_ = 0,limit_ = NumDel},func,nil))
end
-----------------------{ Start Api Token Bot}-----------------------------
function getr(br)
if br then
return "✓"
else
return "✖️"
end
end

function GetApi(web)
local info, res = https.request(web)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, info);
if success then
if not res.ok then return false end
res = res
else
res = false
end
return res
end


--================================{{  ExportChatInviteLink  }} ===================================

function ExportLink(GroupID)
local GetLin,res = https.request(ApiToken..'/exportChatInviteLink?chat_id='..GroupID)
print(res)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, GetLin)
return (res or "")
end

function Restrict(chat_id,user_id,right)
if right == 1 then
https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=false')
elseif right == 2 then
https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=true&can_send_other_messages=true&can_add_web_page_previews=true')
elseif right == 3 then
https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=false&can_send_other_messages=false&can_add_web_page_previews=false')
end
end


function send_msg(chat_id,text,msg_id)
local url = ApiToken..'/sendMessage?chat_id='..chat_id..'&text='..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true"
if msg_id then
url = url.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(url)
end

function EditMsg(chat_id,message_id,text,funcb)
local url = ApiToken..'/editMessageText?chat_id='..chat_id ..'&message_id='..tonumber(message_id/2097152/0.5)..'&text='..URL.escape(text)..'&parse_mode=Markdown&disable_web_page_preview=true'
return GetApi(url)
end

function send_key(chat_id,text,keyboard,inline,msg_id)
local response = {}
response.inline_keyboard = inline
response.keyboard = keyboard
response.resize_keyboard = true
response.one_time_keyboard = false
local Send_api = ApiToken.."/sendMessage?chat_id="..chat_id.."&text="..
URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response))
if msg_id then 
Send_api = Send_api.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(Send_api)
end 

function GetFilePath(FileID)
local UrlInfo = https.request(ApiToken..'/getfile?file_id='..FileID)
return ApiToken..'/'..JSON.decode(UrlInfo).result.file_path
end

----------------------{ End Api Token Bot }-----------------------------

----------------------{ Get Name Bot }-----------------------------
Bot_Name = redis:get(max..":NameBot:")


function GetType(ChatID) 
if tostring(ChatID):match('^-100') then
return 'channel' 
elseif tostring(ChatID):match('-') then
return 'chat' 
else 
return 'pv'
end 
end


function ResolveUser(datax)
if datax.username_ then 
USERNAME = '@'..Flter_Markdown(datax.username_)
else 
USERNAME = FlterName(datax.first_name_..' '..(datax.last_name_ or ""),20) 
USERNAME = "["..USERNAME.."](tg://user?id="..datax.id_..")"
end
return USERNAME
end


function FlterName(Name,Num)
local CharNumber = tonumber(Num or 25)
local Name = tostring(Name):lower()
Name = Name:gsub("https://[%a%d_]+",'') 
Name = Name:gsub("http://[%a%d_]+",'') 
Name = Name:gsub("telegram.dog/[%a%d_]+",'') 
Name = Name:gsub("telegram.me/[%a%d_]+",'') 
Name = Name:gsub("t.me/[%a%d_]+",'') 
Name = Name:gsub("[%a%d_]+.pe[%a%d_]+",'') 
Name = Name:gsub("@[%a%d_]+",'')
Name = Name:gsub("#[%a%d_]+",'')

Name = FlterEmoje(Name)
Name = Flterzhrfa(Name)
Name = utf8.gsub(Name,"✸","")
Name = utf8.gsub(Name,"ﮧ","")
Name = utf8.gsub(Name,"│","")
Name = utf8.gsub(Name,"ٜ","")
Name = utf8.gsub(Name,"༒","")
Name = utf8.gsub(Name,"ᬼ","")
Name = utf8.gsub(Name,"̅","")
Name = utf8.gsub(Name,"❦","")
Name = utf8.gsub(Name,"ᝢ","")
Name = utf8.gsub(Name,"༼","")
Name = utf8.gsub(Name,"๘","")
Name = utf8.gsub(Name,"༽","")
Name = utf8.gsub(Name,"⎨","")
Name = utf8.gsub(Name,"ௌ","")
Name = utf8.gsub(Name,"⎬","")
Name = utf8.gsub(Name,"ۤ","")
Name = utf8.gsub(Name,"꧄","")
Name = utf8.gsub(Name,"░","")
Name = utf8.gsub(Name,"͝","")
Name = utf8.gsub(Name,"¥","")
Name = utf8.gsub(Name,"َ","")
Name = utf8.gsub(Name,"✧","")
Name = utf8.gsub(Name,"ֆ","")
Name = utf8.gsub(Name,"ۖ","")
Name = utf8.gsub(Name,"(])","")
Name = utf8.gsub(Name,"","")
Name = utf8.gsub(Name,"֧","")
Name = utf8.gsub(Name,"*","")
Name = utf8.gsub(Name,"","")
Name = utf8.gsub(Name,"﴿","")
Name = utf8.gsub(Name,"₪","")
Name = utf8.gsub(Name,"ૣ","")
Name = utf8.gsub(Name,"☆","")
Name = utf8.gsub(Name,"͞","")
Name = utf8.gsub(Name,"ٖ","")
Name = utf8.gsub(Name,"֯","")
Name = utf8.gsub(Name,"‘","")
Name = utf8.gsub(Name,"ُ","")
Name = utf8.gsub(Name,"ꪆ","")
Name = utf8.gsub(Name,"↡","")
Name = utf8.gsub(Name,"᭄","")
Name = utf8.gsub(Name,"௵","")
Name = utf8.gsub(Name,"♚","")
Name = utf8.gsub(Name,"ﹻ","")
Name = utf8.gsub(Name,"ۦ","")
Name = utf8.gsub(Name,"͟","")
Name = utf8.gsub(Name,"̶","")
Name = utf8.gsub(Name,"_","")
Name = utf8.gsub(Name,"`","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"๘","")
Name = utf8.gsub(Name,"͡","")
Name = utf8.gsub(Name,"⸨","")
Name = utf8.gsub(Name,"▓","")
Name = utf8.gsub(Name,"ـ","")
Name = utf8.gsub(Name,"ஞ","")
Name = utf8.gsub(Name,"❥","")
Name = utf8.gsub(Name,"ꨩ","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"ೈ","")
Name = utf8.gsub(Name,"٘","")
Name = utf8.gsub(Name,"ࣧ","")
Name = utf8.gsub(Name,"“","")
Name = utf8.gsub(Name,"•","")
Name = utf8.gsub(Name,']',"")
Name = utf8.gsub(Name,"}","")
Name = utf8.gsub(Name,"ཻ","")
Name = utf8.gsub(Name,"⸩","")
Name = utf8.gsub(Name,"ِ","")
Name = utf8.gsub(Name,"ࣩ","")
Name = utf8.gsub(Name,"ٰ","")
Name = utf8.gsub(Name,"ہ","")
Name = utf8.gsub(Name,"ۙ","")
Name = utf8.gsub(Name,"ৡ","")
Name = utf8.gsub(Name,"҉","")
Name = utf8.gsub(Name,"ٙ","")
Name = utf8.gsub(Name,"ّ","")
Name = utf8.gsub(Name,"ۨ","")
Name = utf8.gsub(Name,"ै","")
Name = utf8.gsub(Name,"ೋ","")
Name = utf8.gsub(Name,"๋","")
Name = utf8.gsub(Name,"͢","")
Name = utf8.gsub(Name,"ﮩ","")
Name = utf8.gsub(Name,"❁","")
Name = utf8.gsub(Name,"⃤","")
Name = utf8.gsub(Name,"ﮮ","")
Name = utf8.gsub(Name,"⸽","")
Name = utf8.gsub(Name,"̝","")
Name = utf8.gsub(Name,"{","")
Name = utf8.gsub(Name,"𖤍","")
Name = utf8.gsub(Name,"|","")
Name = utf8.gsub(Name,"ۧ","")
Name = utf8.gsub(Name,"ۗ","")
Name = utf8.gsub(Name,"ۣ","")
Name = utf8.gsub(Name,"ٍ","")
Name = utf8.gsub(Name,"ؔ","")
Name = utf8.gsub(Name,"ٌ","")
Name = utf8.gsub(Name,"͜","")
Name = utf8.gsub(Name,"ꪸ","")
Name = utf8.gsub(Name,"ۂ","")
Name = utf8.gsub(Name,"»","")
Name = utf8.gsub(Name,"̚","")
Name = utf8.gsub(Name,"𖣁","")
Name = utf8.gsub(Name,"۫","")
Name = utf8.gsub(Name,"ْ","")
Name = utf8.gsub(Name,"ৣ","")
Name = utf8.gsub(Name,"ے","")
Name = utf8.gsub(Name,"♱","")
Name = utf8.gsub(Name,"℘","")
Name = utf8.gsub(Name,"ً","")
Name = utf8.gsub(Name,"۪","")
Name = utf8.gsub(Name,"❰","")
Name = utf8.gsub(Name,"꯭","")
Name = utf8.gsub(Name,"ٚ","")
Name = utf8.gsub(Name,"﷽","")
Name = utf8.gsub(Name,"ۛ","")
Name = utf8.gsub(Name,"〞","")
Name = utf8.gsub(Name,"█","")
Name = utf8.gsub(Name,"✮","")
Name = utf8.gsub(Name,"✿","")
Name = utf8.gsub(Name,"✺","")
Name = utf8.gsub(Name,"̐","")
Name = utf8.gsub(Name,"ྀ","")
Name = utf8.gsub(Name,"←","")
Name = utf8.gsub(Name,"↝","")
Name = utf8.gsub(Name,"ؒ","")
Name = utf8.gsub(Name,"̷","")
Name = utf8.gsub(Name,"⇣","")
Name = utf8.gsub(Name,"«","")
Name = utf8.gsub(Name,"ٛ","")
Name = utf8.gsub(Name,"ॠ","")
Name = utf8.gsub(Name,"̲","")
Name = utf8.gsub(Name,"-","")
Name = utf8.gsub(Name,"͛","")
Name = utf8.gsub(Name,"☬","")
Name = utf8.gsub(Name,"ٓ","")
Name = utf8.gsub(Name,"❱","")
Name = utf8.gsub(Name,"ۓ","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"௸","")

if utf8.len(Name) > CharNumber then
Name = utf8.sub(Name,0,CharNumber)..'...' 
end
local CheckName = Name:gsub(' ','')
if not CheckName then 
Name = 'الاسم سبام'
end
return utf8.escape(Name)
end

function Flter_Markdown(TextMsg) 
local Text = tostring(TextMsg)
Text = Text:gsub('_',[[\_]])
Text = Text:gsub('*','\\*')
Text = Text:gsub('`','\\`')
local Hyperlink = Text:match('[(](.*)[)]')
local Hyperlink1 = Text:match('[[](.*)[]]')
if Hyperlink and Hyperlink1 then
Hyperlink = "("..Hyperlink:gsub([[\_]],'_')..")"
Text = Text:gsub('[(](.*)[)]',Hyperlink ) 
Hyperlink1 = Hyperlink1:gsub([[\_]],'_')
Hyperlink1 = "["..Hyperlink1:gsub('[[][]]','').."]"
Text = Text:gsub('[[](.*)[]]',Hyperlink1 ) 
end
return Text 
end



function Get_Ttl(msgs)
local MsgShow = '' 
local NumMsg = tonumber(msgs)
if NumMsg < 80 then 
MsgShow = 'بدون مجامله زي الزفت' 
elseif NumMsg < 300 then
MsgShow = 'شد الهمه يرجل' 
elseif NumMsg < 900 then 
MsgShow = 'مشي حالك' 
elseif NumMsg < 5000 then 
MsgShow = 'يجي منك' 
elseif NumMsg < 9000 then 
MsgShow = 'قوي' 
elseif NumMsg < 10000 then 
MsgShow = 'ابووي يالقوه' 
elseif NumMsg < 13000 then 
MsgShow = 'كنق التيلي'
elseif NumMsg < 100000 then 
MsgShow = 'امبروطور التيلي' 
elseif NumMsg > 150000 then 
MsgShow = 'ماشاءالله يالقوه' 
end
return MsgShow 
end

function Getrtba(UserID,ChatID)
if UserID == our_id then 
var = 'هذا البوت' 
elseif  UserID == SUDO_ID then
var = 'بابا' 
elseif  UserID == 943705552 then
var = 'NIRO' 
elseif  UserID == 1142798706 then
var = 'شوقر دادي' 
elseif  UserID == 1104399382 then
var = 'Dark' 
elseif  UserID == 1112415974 then
var = 'XO' 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then
var = 'Dev' 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then
var = 'المنشىء الاساسي' 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then
var = 'المنشىء' 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then
var = 'مدير' 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then
var = 'ادمن' 
elseif redis:sismember(max..'whitelist:'..ChatID,UserID) then
var = 'عضو مميز ⭐️' 
else
var = 'عضو' 
end
return var
end


function SaveNumMsg(msg)
if msg.edited then
redis:incr(max..':edited:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.text and not msg.forward_info then
redis:incr(max..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_)
elseif msg.adduser then 
redis:incr(max..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.photo then
redis:incr(max..':photo:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.sticker then
redis:incr(max..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.voice then
redis:incr(max..':voice:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.audio then
redis:incr(max..':audio:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.video or msg.video_note then
redis:incr(max..':video:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.animation then
redis:incr(max..':animation:'..msg.chat_id_..':'..msg.sender_user_id_)
end
end


--================================{{  We Sudoer  }} ===================================

function we_sudo(msg)
if msg.sender_user_id_ == SUDO_ID then
return true 
else
return false
end 
end


--================================{{  List Sudoer  }} ===================================


function sudolist(msg)
local list = redis:smembers(max..':SUDO_BOT:')
message = '*-----›* قائمة الـمـطـوريـن : \n`- بابا`**\n'..SUDO_USER..' » ❪' ..SUDO_ID.. '❫\n*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀ *\n'
if #list==0 then  message = message.."*---› مافيه Dev حاليا *"
else
for k,v in pairs(list) do
local info = redis:hgetall(max..'username:'..v)
local count = redis:scard(max..'mtwr_count'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '---› '..(info.username or '')..' » ❪`' ..v.. '`❫\n'
else
message = message ..k.. '---› '..(info.username or '')..' l » ❪`' ..v.. '`❫\n'
end
end 
end
send_msg(msg.chat_id_,message,msg.id_)
print(message)
return false 
end

--================================{{  List owner  }} ===================================

function ownerlist(msg)
local message = '*---› المنشئيين :*\n'
local monsha = redis:smembers(max..':MONSHA_BOT:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."-----› Not Creator - لا يوجد منشئيين !"
else
for k,v in pairs(monsha) do
local info = redis:hgetall(max..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '---› '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '---› '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end
end
message = message..'*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀ \n-----› قائمه المدراء :*\n'
local list = redis:smembers(max..'owners:'..msg.chat_id_)
if #list == 0 then  
message = message.."-----› Not Director - لا يوجد مدراء !\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(max..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '---› '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '---› '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end

--================================{{ List Admins  }} ===================================

function GetListAdmin(msg)
local list = redis:smembers(max..'admins:'..msg.chat_id_)
if #list==0 then  return  "*-----›* لا يوجد ادمن في هذه المجموعه" end
message = '*-----› قائمه الادمنيه :*\n'
for k,v in pairs(list) do
local info = redis:hgetall(max..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '---› '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '---› '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end

--================================{{  List WhiteList  }} ===================================

function whitelist(msg)
local list = redis:smembers(max..'whitelist:'..msg.chat_id_)
if #list == 0 then return "*---› لا يوجد مميزين في القائمه *" end
message = '*---›* قائمه الاعضاء المميزين :\n'   
for k,v in pairs(list) do
local info = redis:hgetall(max..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '---› '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '---› '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end

--================================{{  Mute User And List Mute User   }} ===================================

function MuteUser(Group, User)
if redis:sismember(max..'is_silent_users:'..Group,User) then 
return true 
else
return false
end 
end


function MuteUser_list(msg)
local list = redis:smembers(max..'is_silent_users:'..msg.chat_id_)
if #list==0 then return "*---›* لايوجد اعضاء مكتومين " end
message = '*---›* قائمة الاعضاء المكتومين :\n'
for k,v in pairs(list) do
local info = redis:hgetall(max..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '---› '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '---› '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--================================{{  Check Banned And List Banned  }} ===================================


function Check_Banned(Group,User)
if redis:sismember(max..'banned:'..Group,User) then 
return true 
else
return false
end 
end

function GetListBanned(msg)
local list = redis:smembers(max..'banned:'..msg.chat_id_)
if #list==0 then return "*---›* لايوجد أعضاء محظورين " end
message = '*---›* قائمة الاعضاء المحظورين :\n'
for k,v in pairs(list) do
local info = redis:hgetall(max..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '---› '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '---› '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end 
send_msg(msg.chat_id_,message,msg.id_)
return false
end



--================================{{  Sudoer  }} ===================================

function GeneralBanned(User)
if redis:sismember(max..'gban_users',User) then 
return true 
else
return false
end 
end

function GetListGeneralBanned(msg)
local list = redis:smembers(max..'gban_users')
if #list==0 then return  "*---› لايوجد اعضاء محظورين عام*" end
message = '*---›* قائمه المحظورين عام :\n'
for k,v in pairs(list) do
local info = redis:hgetall(max..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '---› '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '---› '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end 
send_msg(msg.chat_id_,message,msg.id_)
return false
end

--================================{{  Filter Words  }} ===================================

function FilterX(msg)
local var = false
local Text = (msg.text or msg.content_.caption_)
local list = redis:smembers(max..':Filter_Word:'..msg.chat_id_)
if #list ~=0 then
for k,word in pairs(list) do
if Text:match('^('..word..')$') or Text:match(word..' .*') or Text:match('.* '..word) then
Del_msg(msg.chat_id_,msg.id_)
print("Word is Del")
var = true
else
var = false
end
end
else
var = false
end 
return var
end


function FilterXList(msg)
local list = redis:smembers(max..':Filter_Word:'..msg.chat_id_)
if #list == 0 then return "*---›* قائمة الكلمات الممنوعه فاضيه" end
filterlist = '*---›* قائمة الكلمات الممنوعه :\n'    
for k,v in pairs(list) do
filterlist = filterlist..'*'..k..'* -  '..Flter_Markdown(v)..'\n'
end 
return filterlist
end

function AddFilter(msg, word)
if redis:sismember(max..':Filter_Word:'..msg.chat_id_,word) then 
return  "*---›* الكلمه *{"..word.."}* موجوده من قبل يغالي " 
else
redis:sadd(max..':Filter_Word:'..msg.chat_id_,word) 
return  "*---›* الكلمه *{"..word.."}* تم اضفتها الى قائمة المنع "
end
end

function RemFilter(msg, word)
if redis:sismember(max..':Filter_Word:'..msg.chat_id_,word) then 
redis:srem(max..':Filter_Word:'..msg.chat_id_,word) 
return  "*---›* الكلمه *{"..word.."}* تم السماح فيها " 
else
return  "*---›* الكلمه *{"..word.."}* مسموح فيها من قبل يغالي✓" 
end
end

------------------------------------------

function CheckFlood(msg)
EnterCmd = true
local NumberFlood = tonumber(redis:get(max..':Flood_Spam:'..msg.sender_user_id_..':msgs') or 0)
if NumberFlood > 3 then 
redis:setex(max..':Flood_Spam:'..msg.sender_user_id_..':Stoped',10,true)
EnterCmd = false
elseif redis:get(max..':Flood_Spam:'..msg.sender_user_id_..':Stoped') then
EnterCmd = false
else
redis:setex(max..':Flood_Spam:'..msg.sender_user_id_..':msgs',3,NumberFlood+1)
end
return EnterCmd
end


function buck_up_groups(msg)

json_data = '{"BotID": '..max..',"UserBot": "'..Bot_User..'","Groups" : {'
local All_Groups_ID = redis:smembers(max..'group:ids')
for key,GroupS in pairs(All_Groups_ID) do
local NameGroup = (redis:get(max..'group:name'..GroupS) or '')
NameGroup = NameGroup:gsub('"','')
NameGroup = NameGroup:gsub([[\]],'')
if key == 1 then
json_data =  json_data ..'"'..GroupS..'":{"Title":"'..NameGroup..'"'
else
json_data =  json_data..',"'..GroupS..'":{"Title":"'..NameGroup..'"'
end

local admins = redis:smembers(max..'admins:'..GroupS)
if #admins ~= 0 then
json_data =  json_data..',"Admins" : {'
for key,value in pairs(admins) do
local info = redis:hgetall(max..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

local creators = redis:smembers(max..':MONSHA_BOT:'..GroupS)
if #creators ~= 0 then
json_data =  json_data..',"Creator" : {'
for key,value in pairs(creators) do
local info = redis:hgetall(max..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end 
end
json_data =  json_data..'}'
end


local creator = redis:smembers(max..':KARA_BOT:'..GroupS)
if #creator ~= 0 then
json_data =  json_data..',"Kara" : {'
for key,value in pairs(creator) do
local info = redis:hgetall(max..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end 
end
json_data =  json_data..'}'
end

local owner = redis:smembers(max..'owners:'..GroupS)
if #owner ~= 0 then
json_data =  json_data..',"Owner" : {'
for key,value in pairs(owner) do
local info = redis:hgetall(max..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

json_data =  json_data.."}"
end

local Save_Data = io.open("./inc/"..Bot_User..".json","w+")
Save_Data:write(json_data..'}}')
Save_Data:close()
sendDocument(msg.chat_id_,msg.id_,"./inc/"..Bot_User..".json","---› ملف النسخه الاحتياطيه ...\n---› المجموعات » { "..#All_Groups_ID.." }\n---› للبوت » "..Bot_User.."\n---› التاريخ » "..os.date("%Y/%m/%d").."\n",dl_cb,nil)
end

function chat_list(msg)
local list = redis:smembers(max..'group:ids')
message = '*---›*قائمه المجموعات :\n'
for k,v in pairs(list) do 
local info = redis:get(max..'group:name'..v)
if info then 
if utf8.len(info) > 25 then
info = utf8.escape(utf8.gsub(info,0,25))..'...'
end
message = message..k..'ـ '..Flter_Markdown(info).. ' \nــ •⊱ { `' ..v.. '` } ⊰•\n\n'
else 
message = message..k.. 'ـ '..' ☜ •⊱ { `' ..v.. '` } ⊰• \n'
end 
end
all_groups = '---› قائمه المجموعات :<br><br>'
for k,v in pairs(list) do 
local info = redis:get(max..'group:name'..v)
if info then
all_groups = all_groups..' '..k..'- <span style="color: #bd2a2a;">'..info.. '</span> <br> ايدي ☜ (<span style="color:#078883;">' ..v.. '</span>)<br>'
else
all_groups = all_groups..' '..k.. '- '..' ☜ (<span style="color:#078883;">' ..v.. '</span>) <br>'
end 
end

if utf8.len(message) > 4096 then
sendMsg(msg.chat_id_,1,'---›* عذرا لديك الكثير من المجموعات\n*-*سوف ارسل لك ملف فيها قائمه مجموعات المفعله انتظر لحظه ...')
file = io.open("./inc/All_Groups.html", "w")
file:write([[
<html dir="rtl">
<head>
<title>قائمه المجموعات 🗣</title>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Harmattan" rel="stylesheet">

</head>
<style>*{font-family: 'Harmattan', sans-serif;font-weight: 600;text-shadow: 1px 1px 16px black;}</style>
<body>
<p style="color:#018bb6;font-size: 17px;font-weight: 600;" aligin="center">قائمه المجموعات 🗣</p>
<hr>
]]..all_groups..[[

</body>
</html>
]])
file:close()
return sendDocument(msg.chat_id_,msg.id_,'./inc/All_Groups.html','---› قائمه المجموعات بالكامله ✓ \n---› يحتوي ('..#list..') مجموعه \n---› افتح الملف في عارض HTML او بالمتصفح',dl_cb,nil)
else 
return sendMsg(msg.chat_id_,1,message) 
end 
end



function rem_data_group(id_group)
redis:del(
max..'group:add'..id_group,
max..'lock_link'..id_group, 
max..'lock_id'..id_group,
max..'lock_spam'..id_group, 
max..'lock_webpage'..id_group,
max..'lock_markdown'..id_group,
max..'lock_flood'..id_group,
max..'lock_bots'..id_group,
max..'mute_forward'..id_group,
max..'mute_contact'..id_group,
max..'mute_location'..id_group,
max..'mute_document'..id_group,
max..'mute_keyboard'..id_group,
max..'mute_game'..id_group,
max..'mute_inline'..id_group,
max..'lock_username'..id_group,
max..'num_msg_max'..id_group,
max..'replay'..id_group
)
redis:srem(max..'group:ids',id_group)
end



function set_admins(msg) 
GetChannelAdministrators(msg.chat_id_,function(arg,data)
local NumAdmin = 0
for k,v in pairs(data.members_) do
if not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
NumAdmin = NumAdmin + 1
GetUserID(v.user_id_,function(arg,data)
redis:hset(max..'username:'..data.id_,'username',ResolveUser(data))
redis:sadd(max..'admins:'..msg.chat_id_,data.id_)
end,nil)
end
end
if NumAdmin == 0 then 
return sendMsg(msg.chat_id_,msg.id_,"️---› مافي أدمـنـيـه عشان ارفعهم \n")
else
return sendMsg(msg.chat_id_,msg.id_,"---› تم رفعت  { *"..NumAdmin.."* } واحد مـن الادمنيه في البوت ")
end
end,100)
end

function modadd(msg)
if redis:get(max..'lock_service') then
service = true
Get_Director = 30
else
service = false
Get_Director = 1
end 
if not msg.SudoUser and not service then return '---› أنـت مو الـمـطـور️' end
if msg.is_post_ then return "---› عذرا هذا بوت حمايه المجموعات وليس القنوات" end
if msg.type ~= "channel" then return '---› لا يمكنك تفعيل البوت في المجوعات العاديه / البوت يدعم فقط المجموعات الخارقه️' end
if redis:get(max..'group:add'..msg.chat_id_) then  return '*---›* المجموعه مفعله من قبل يغالي ياغالي ' end

local UserChaneel = redis:get(max..":UserNameChaneel")
if UserChaneel and not msg.SudoBase then
local url , res = https.request(ApiToken..'/getchatmember?chat_id='..UserChaneel..'&user_id='..msg.sender_user_id_)
if res == 200 then
print(url) 
local Req = JSON.decode(url)
if Req.ok and Req.result and Req.result.status == "left" or Req.result.status == "kicked" then
return "---› اشترك بالقناة اول ["..UserChaneel.."] \n- ثم ارجع ارسل تفعيل ."
end
else
return "---› اشترك بالقناة اول ["..UserChaneel.."] \n- ثم ارجع ارسل تفعيل ."
end
end
 
redis:setex(max..":ismember:"..msg.sender_user_id_,1500,true)
GetFullChat(msg.chat_id_,function(arg,data) 
local GroupUsers = tonumber(redis:get(max..':addnumberusers') or 0)
local Groupcount = tonumber(data.member_count_)
if GroupUsers  >= Groupcount and not msg.SudoBase then
return sendMsg(msg.chat_id_,msg.id_,'*---›* مايمديني افعل البوت في المجموعة‏ لازم يصير اكثر مـن ( '..GroupUsers..' ) عضـو')
else 
GetChatMember(msg.chat_id_,our_id,function(arg,data)
if data.status_.ID == "ChatMemberStatusMember" then
return sendMsg(msg.chat_id_,msg.id_,'*---›* انا مو ادمن فلمجموعه يغالي ️\n*---›* ارفعني ادمن اذا سمحت عشان تفعلني ️')
else
local lock_service = redis:get(max..'lock_service')
if lock_service then 
sendMsg(msg.chat_id_,msg.id_,'*---› تم التفعيل يوحش  \n---›* وسويت كل شيء مطلوب مني ‏‏‏ ')
else
sendMsg(msg.chat_id_,msg.id_,'---› تم التفعيل يغالي ‏‏️')
end
GetChannelAdministrators(msg.chat_id_,function(arg,data)
for k,v in pairs(data.members_) do
if data.members_[k].status_.ID == "ChatMemberStatusCreator" then
GetUserID(v.user_id_,function(arg,data)
redis:hset(max..'username:'..data.id_, 'username', ResolveUser(data))
redis:sadd(max..':KARA_BOT:'..msg.chat_id_,data.id_)
end)
elseif lock_service and not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
GetUserID(v.user_id_,function(arg,data)
redis:hset(max..'username:'..data.id_,'username',ResolveUser(data))
redis:sadd(max..'admins:'..msg.chat_id_,data.id_)
end,nil)
end
end 

redis:mset(
max..'group:add'..msg.chat_id_,true,
max..'lock_link'..msg.chat_id_,true, 
max..'lock_id'..msg.chat_id_,true,
max..'lock_spam'..msg.chat_id_,true,
max..'lock_webpage'..msg.chat_id_,true,
max..'lock_markdown'..msg.chat_id_,true,
max..'lock_flood'..msg.chat_id_,true,
max..'lock_bots'..msg.chat_id_,true,
max..'mute_forward'..msg.chat_id_,true,
max..'mute_contact'..msg.chat_id_,true,
max..'mute_location'..msg.chat_id_,true,
max..'mute_document'..msg.chat_id_,true,
max..'mute_keyboard'..msg.chat_id_,true,
max..'mute_game'..msg.chat_id_,true,
max..'mute_inline'..msg.chat_id_,true,
max..'lock_username'..msg.chat_id_,true,
max..'num_msg_max'..msg.chat_id_,5, 
max..'replay'..msg.chat_id_,true
)

redis:sadd(max..'group:ids',msg.chat_id_) 
redis:sadd(max..'mtwr_count'..msg.sender_user_id_,msg.chat_id_)

GroupTitle(msg.chat_id_,function(arg,data)
local NameGroup = data.title_
redis:set(max..'group:name'..msg.chat_id_,NameGroup)
local Gp_Link = ExportLink(msg.chat_id_)
if Gp_Link and Gp_Link.result then
Gp_Link = Gp_Link.result
else
Gp_Link = ""
end
redis:set(max..'linkGroup'..msg.chat_id_,Gp_Link)
if not we_sudo(msg) then
GetUserID(msg.sender_user_id_,function(arg,datai)
if datai.username_ then 
USERNAME_T = '*---›* الـمعرف ❪ @['..datai.username_..'] ❫'
else 
USERNAME_T = ''
end
return send_msg(SUDO_ID,'*---›* تــــم تــفــعــيــل الـــبـــوت ...\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n---› معلومات المجموعه\n'
..'---› اسم المجموعه ❪ ['..NameGroup..']('..Gp_Link..') ❫\n'
..'---› ايدي المجموعه ❪ '..msg.chat_id_..' ❫\n'
..'---› عدد اعضاء المجموعه ❪ *'..Groupcount..'* ❫ \n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n---› معلومات الشخص الي ضافني \n'
..'*---›* الاسـم ❪ ['..FlterName(datai.first_name_..' '..(datai.last_name_ or ""),23)..'](tg://user?id='..msg.sender_user_id_..') ❫\n'
..USERNAME_T..'\n---› تاريخ التفعيل ❪* '..os.date("%Y/%m/%d")
..' *❫\n---› الساعه ❪* '..os.date("%I:%M%p")..' *❫')
end,nil)
end
end)
end,Get_Director) 
end
end)
end 
end)
return false
end 

function modrem(msg)
if not msg.SudoUser then return '*---›* أنـت لـسـت الـمـطـور️'end
if not redis:get(max..'group:add'..msg.chat_id_) then return '*---›* المجموعه معطله من قبل يغالي يالطيب!' end  
rem_data_group(msg.chat_id_)
return '*---›* ابشر تم التعطيل ️'
end

function modrem(msg)
if not msg.SudoUser then return '*---›* أنـت لـسـت الـمـطـور️'end
if not redis:get(max..'group:add'..msg.chat_id_) then return '*---›* المجموعه معطله من قبل يغالي يالطيب!' end  
rem_data_group(msg.chat_id_)
return '*---›* ابشر تم التعطيل ️'
end

function action_by_reply(arg,data)  --===  معلومات الرد 
local MsgID = arg.msg.id_
local ChatID = arg.msg.chat_id_
if data.sender_user_id_ then
local cmd = arg.cmd
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)

local Resolv = ResolveUser(data)

if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)


if cmd =="tqeed" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد بابا بعدين يضربك والله ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"‍*---›* مايمديك تقييد Dev ") 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد المنشئ الاساسي ")
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد الادمن ") 
end
GetChatMember(ChatID,UserID,function(arg,data)
if data.status_.ID == "ChatMemberStatusMember" then
Restrict(ChatID,UserID,1)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n- الايدي ❪ '..UserID..' ❫\n---› تم تقييد العضو  ',17,USERCAR) 
else
return sendMsg(ChatID,MsgID,"*---›* مايمديني اقييد المشرف ") 
end
end)
end

if cmd =="fktqeed" then
if UserID == our_id then  
return sendMsg(ChatID,MsgID,"*---›* البوت مو مقييد") 
end
Restrict(ChatID,UserID,2)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الغاء تقييد العضو  ',17,USERCAR) 
end

if cmd == "setmnsha" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*---›* ما يمديني ارفع نفسي انا مرفوع للتوب دوم") 
elseif data.type_.ID  == "UserTypeBot" then 
return sendMsg(ChatID,MsgID,"*---›* معليش مايمديني ارفع بوت في البوت") 
elseif data.type_.ID == "chatTypeChannel" then 
return sendMsg(ChatID,MsgID,"*---›* معليش مايمديني ارفع قناة في البوت") 
end
if redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› منشئ من قبل يغالي ',17,USERCAR) 
end
redis:hset(max..'username:'..UserID,'username',Resolv)
redis:sadd(max..':MONSHA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الترقية يغالي صار منشىء ',17,USERCAR) 
end

if cmd == "remmnsha" then
if not redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مو منشىء من قبل يغالي',17,USERCAR) 
end
redis:srem(max..':MONSHA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم تنزيله من المنشىء️',17,USERCAR) 
end

if cmd == "setkara" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*---›* ما يمديني ارفع نفسي انا مرفوع للتوب دوم") 
elseif data.type_.ID  == "UserTypeBot" then 
return sendMsg(ChatID,MsgID,"*---›* معليش مايمديني ارفع بوت في البوت") 
elseif data.type_.ID == "chatTypeChannel" then 
return sendMsg(ChatID,MsgID,"*---›* معليش مايمديني ارفع قناة في البوت") 
end
if redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› منشىء اساسي️ من قبل يغالي',17,USERCAR) 
end
redis:hset(max..'username:'..UserID,'username',Resolv)
redis:sadd(max..':KARA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الترقية يغالي صار منشىء اساسي في البوت️',17,USERCAR) 
end

if cmd == "remkara" then
if not redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مو منشىء اساسي من قبل يغالي️',17,USERCAR) 
end
redis:srem(max..':KARA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم تنزيله من المنشىء الاساسي️',17,USERCAR) 
end

if cmd == "setwhitelist" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*---›* ما يمديني ارفع نفسي انا مرفوع للتوب دوم") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*---›* معليش مايمديني ارفع بوت في البوت") 
elseif data.type_.ID == "ChatTypeChannel" then 
return sendMsg(ChatID,MsgID,"*---›* معليش مايمديني ارفع قناة في البوت") 
end
if redis:sismember(max..'whitelist:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› عضو مميز️ من قبل يغالي',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'whitelist:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الترقية يغالي صار عضو مميز️',17,USERCAR) 
end

if cmd == "remwhitelist" then
if not redis:sismember(max..'whitelist:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مو عضو مميز من قبل يغالي',17,USERCAR) 
end
redis:srem(max..'whitelist:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم تنزيله من عضو مميز',17,USERCAR) 
end

if cmd == "setowner" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*---›* ما يمديني ارفع نفسي انا مرفوع للتوب دوم") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*---›* معليش مايمديني ارفع بوت في البوت") 
end
if redis:sismember(max..'owners:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مدير️ من قبل يغالي',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'owners:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الترقية يغالي صار مدير️',17,USERCAR) 
end

if cmd == "promote" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*---›* ما يمديني ارفع نفسي انا مرفوع للتوب دوم") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*---›* معليش مايمديني ارفع بوت في البوت") 
end
if redis:sismember(max..'admins:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› ادمن️ من قبل يغالي',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'admins:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الترقية يغالي صار ادمن️',17,USERCAR) 
end

if cmd == "remowner" then
if not redis:sismember(max..'owners:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مو مدير من قبل يغالي',17,USERCAR) 
end
redis:srem(max..'owners:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم تنزيله من المدير ️',17,USERCAR) 
end

if cmd == "demote" then
if not redis:sismember(max..'admins:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مو ادمن️ من قبل يغالي',17,USERCAR) 
end
redis:srem(max..'admins:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم تنزيله من الادمنيه️',17,USERCAR) 
end

if cmd == "iduser" then
return SendMention(ChatID,UserID,MsgID,"---› اضغط على الايدي عشان تنسخ\n\n "..USERNAME.." ---› {` "..UserID.." `}",37,USERCAR)
end
if cmd == "whois" then
local namei = data.first_name_..' '..(data.last_name_ or "")
if data.username_ then useri = '@'..data.username_ else useri = " لا يوجد " end
return SendMention(ChatID,UserID,MsgID,'---› الاسم '..namei..'\n'
..'---› الايدي » {'..UserID..'} \n'
..'---› المعرف » '..useri..'\n'
..'---› الرتبه » '..Getrtba(UserID,ChatID)..'\n'
..'---› نوع الكشف » بالرد',13,utf8.len(namei))
end

if cmd == "active" then
local maseegs = redis:get(max..'msgs:'..UserID..':'..ChatID) or 1
local namei = FlterName(data.first_name_..' '..(data.last_name_ or ""))
return SendMention(ChatID,UserID,MsgID,'---› العضو '..namei..' \n---› رسائلك ❪ '..maseegs..' ❫ رسالةة\n---› التفاعل ❪ '..Get_Ttl(maseegs)..' ❫',12,utf8.len(namei)) 
end

if cmd == "ban" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر بابا ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر Dev ") 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر المنشئ ") 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر الادمن ") 
end
kick_user(UserID,ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'*---›* مايمديني احظر العضو .\n*---›* لانه مشرف في المجموعه')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'*---›* مايمديني احظر العضو .\n*---›* صلاحيه الحضر مقفله او انك نسيت ترفعني ادمن يا يغالي')    
else
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'banned:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› حظرته ️',17,USERCAR) 
end
end)

end

if cmd == "unban" then
if not redis:sismember(max..'banned:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› ملغيه حظره من قبل يغالي ️',17,USERCAR) 
else
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› الغيت حظره️',17,USERCAR) 
end
redis:srem(max..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
end

if cmd == "silent" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم بابا ياورع ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم Dev ") 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم المنشئ ") 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم الادمن ") 
end
if redis:sismember(max..'is_silent_users:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مكتوم من قبل يغالي ️',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'is_silent_users:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› لايدي ❪ '..UserID..' ❫\n---›  كتمته ️',17,USERCAR) 
end

if cmd == "unsilent" then
if not redis:sismember(max..'is_silent_users:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› ملغيه حظره من قبل يغالي ️',17,USERCAR) 
end
redis:srem(max..'is_silent_users:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› الغيت كتمه ️',17,USERCAR) 
end

if cmd == "banall" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"??*---›* مايمديك تحظر بابا ")
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر Dev ") 
end
if GeneralBanned(UserID) then return sendMsg(ChatID,MsgID,'*---›* العضو » ❪ '..USERNAME..' ❫\n*---›*الايدي » ❪ `'..UserID..'` ❫\n*---›* تم  حظره عام️') end
redis:hset(max..'username:'..UserID, 'username',Resolv)
redis:sadd(max..'gban_users',UserID)
kick_user(UserID, ChatID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم حظره عام ️',17,USERCAR) 
end

if cmd == "unbanall" then
if not GeneralBanned(UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم  الغاء حظره العام ',17,USERCAR) 
end
redis:srem(max..'gban_users',UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الغاء حظره العام ️',17,USERCAR) 
end

if cmd == "kick" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد بابا يورع ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد Dev ") 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المنشئ ") 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد الادمن ") 
end
kick_user(UserID, ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'*---›* مايمديني احظر العضو .\n*-*لانه مشرف في المجموعه')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'*---›* لا يمكنني حظر العضو .\n*-*ليس لدي صلاحيه الحظر او لست مشرف')    
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› طردته  ️',17,USERCAR) 
end)

end

if cmd == "rtba" then
GetChatMember(ChatID,UserID,function(arg,data)
if data.status_ and data.status_.ID == "ChatMemberStatusEditor" then
SudoGroups = 'مشرف '
elseif data.status_ and data.status_.ID == "ChatMemberStatusCreator" then 
SudoGroups = "منشئ اساسي ."
else
SudoGroups = "عضو .!"
end
if UserID == our_id then 
Getrtb = 'ادمن' 
elseif  UserID == SUDO_ID then
Getrtb = 'بابا' 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then
Getrtb = 'Dev' 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then
Getrtb = 'منشئ اساسي' 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then
Getrtb = 'منشئ' 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then
Getrtb = 'المدير ' 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then
Getrtb = 'ادمن' 
elseif redis:sismember(max..'whitelist:'..ChatID,UserID) then
Getrtb = 'مميز' 
else
Getrtb = 'عضو' 
end
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n\nـ⠀❪ رتـبـة الشخص ❫\n\n---› في البوت » ❪ '..Getrtb..' ❫\n---› في المجموعه » ❪ '..SudoGroups..' ❫',12,USERCAR) 
end)
end

if cmd == "up_sudo" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*---›* ما يمديني ارفع نفسي انا مرفوع للتوب دوم") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*---›* معليش مايمديني ارفع بوت في البوت ") 
end
if redis:sismember(max..':SUDO_BOT:',UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› Dev️ من قبل يغالي',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..':SUDO_BOT:',UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الترقية يغالي صار Dev️',17,USERCAR) 
end

if cmd == "dn_sudo" then
if not redis:sismember(max..':SUDO_BOT:',UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مو Dev من قبل يغالي ',17,USERCAR) 
end
redis:srem(max..':SUDO_BOT:',UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم تنزيله من Dev',17,USERCAR) 
end  -- End Cmd 
end,nil)
else
return sendMsg(ChatID,MsgID,"*---›* هذا العضو غير موجود بلجروب")
end 
end


function action_by_username(arg,data)
local cmd = arg.cmd 

local ChatID = arg.msg.chat_id_
local MsgID = arg.msg.id_
if data.id_ then
local UserID = data.id_
local UserName = '@'..arg.msg.text:match('@[%a%d_]+'):gsub('@',''):gsub('_',[[\_]])
print(UserName)
if cmd =="tqeed" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد بابا ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد Dev ")
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقيد المنشئ الاساسي ") 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد الادمن ") 
end
GetChatMember(ChatID,our_id,function(arg,data)
if data.status_.ID == "ChatMemberStatusEditor" then 
GetChatMember(ChatID,UserID,function(arg,data)
if data.status_.ID == "ChatMemberStatusMember" then 
Restrict(ChatID,UserID,1)  
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي » ❪ `'..UserID..'` ❫\n*---›* تم تقييد العضو  ️') 
else
return sendMsg(ChatID,MsgID,'*---›* مايمديني اقييد العضو .\n*---›* لانه مشرف في المجموعه')    
end
end)
else
return sendMsg(ChatID,MsgID,'*---›* مايمديني اقييد العضو .\n*---›* لاني مو مشرفه في المجموعه')    
end
end)

end

if cmd =="fktqeed" then
if UserID == our_id then  
return sendMsg(ChatID,MsgID,"*---›* البوت مو مقييد ") 
end
GetUserID(UserID,function(arg,data)
GetChatMember(ChatID,our_id,function(arg,data)
if data.status_.ID == "ChatMemberStatusEditor" then 
Restrict(ChatID,UserID,2)
return sendMsg(ChatID,MsgID,'*---›* العضو » ❪ '..UserName..' ❫\n*---›* الايدي » ❪ `'..UserID..'` ❫\n*---›* الغيت تقييده ') 
else
return sendMsg(ChatID,MsgID,'*---›* لا يمكنني فك تقييد العضو .\n*---›* لانني لست مشرفه في المجموعه ')    
end
end)
end,nil)
end

if cmd == "setmnsha" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*---›* ما يمديني ارفع نفسي انا مرفوع للتوب دوم") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"*---›* عذرا لا يمكن رفع بوت في البوت") 
elseif data.type_.ID == "ChatTypeChannel" then 
return sendMsg(ChatID,MsgID,"*---›* عذرا لا يمكن رفع قناة في البوت") 
end
if redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* منشئ من قبل يغالي ') 
end
redis:hset(max..'username:'..UserID, 'username', UserName)
redis:sadd(max..':MONSHA_BOT:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي » ❪ `'..UserID..'` ❫\n*---›* تم الترقية يغالي صار منشىء')
end

if cmd == "remmnsha" then
if not redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي » ❪ `'..UserID..'` ❫\n*---›* مو منشىء من قبل يغالي \n✓️') 
end
redis:srem(max..':MONSHA_BOT:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي » ❪ `'..UserID..'` ❫\n*---›* تم تنزيله من المنشىء \n✓️') 
end

if cmd == "setwhitelist" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*---›* ما يمديني ارفع نفسي انا مرفوع للتوب دوم") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(ChatID,MsgID,"*---›* عذرا لا يمكن رفع قناة في البوت") 
end
if redis:sismember(max..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›*  عضو مميز️ من قبل يغالي') 
end
redis:hset(max..'username:'..UserID, 'username', UserName)
redis:sadd(max..'whitelist:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* تم الترقية يغالي صار عضو مميز️')
end

if cmd == "remwhitelist" then
if not redis:sismember(max..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'*---›*العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* مو عضو مميز من قبل يغالي') 
end
redis:srem(max..'whitelist:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›*العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* تم نزلته من عضو مميز️')
end

if cmd == "setowner" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*---›* معليش مايمديني رفع نفسي") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(ChatID,MsgID,"*---›* عذرا لا يمكن رفع قناة في البوت") 
end
if redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو » ❪ '..UserName..' ❫\n*---›* الايدي » ❪ `'..UserID..'` ❫\n*---›* مدير️ من قبل يغالي') 
end
redis:hset(max..'username:'..UserID, 'username', UserName)
redis:sadd(max..'owners:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›* العضو » ❪ '..UserName..' ❫\n*---›* الايدي » ❪ `'..UserID..'` ❫\n*---›* تم الترقية يغالي صار مدير ')
end

if cmd == "promote" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*---›* ما يمديني ارفع نفسي انا مرفوع للتوب دوم") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(ChatID,MsgID,"*---›* عذرا لا يمكن رفع قناة في البوت") 
end
if redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* ادمن من قبل يغالي') 
end
redis:hset(max..'username:'..UserID, 'username', UserName)
redis:sadd(max..'admins:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* تم الترقية يغالي صار ادمن️')
end

if cmd == "remowner" then
if not redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* مو مدير️ من قبل يغالي') 
end
redis:srem(max..'owners:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* تم تنزيله من الاداره')
end

if cmd == "demote" then
if not redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* مو ادمن  من قبل يغالي️') 
end
redis:srem(max..'admins:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* تم تنزيله من الادمنيه ️')
end

if cmd == "iduser" then
return sendMsg(ChatID,MsgID,"-*›* اضغط على الايدي عشان تنسخه\n\n "..UserName.." ---› ( `"..UserID.."` )")
end

if cmd == "whois" then
return sendMsg(ChatID,MsgID,
  '*---›* الاسم » '..FlterName(data.title_,30)..'\n'
..'*---›* الايدي » {`'..UserID..'`} \n'
..'*---›* المعرف » '..UserName..'\n'
..'*---›* نوع الكشف » بالمعرف\n'
)
end

if cmd == "active" then
local maseegs = redis:get(max..'msgs:'..UserID..':'..ChatID) or 1
local namei = FlterName(data.title_)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..namei..' ❫\n---› رسائلك ❪ '..maseegs..' ❫ رسالة\n---› التفاعل ❪ '..Get_Ttl(maseegs)..' ❫',12,utf8.len(namei)) 
end 

if cmd == "ban" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر بابا ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر Dev ") 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر الادمن ") 
end
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"*---›* عذرا لا يمكنني حظر نفسي") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(ChatID,MsgID,"*---›* عذرا لا يمكن حظر قناة") 
end
if redis:sismember(max..'banned:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* محظور من قبل يغالي') 
end
kick_user(UserID, ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'*---›* مايمديني احظر العضو .\n*---›* لانه مشرف في المجموعه')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'️*---›* لا يمكنني حظر العضو .\n*---›*ليس لدي صلاحيه الحظر او لست مشرف')    
end
redis:hset(max..'username:'..UserID, 'username', UserName)
redis:sadd(max..'banned:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›*والعضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* حظرته️')
end)
end  

if cmd == "unban" then
if not redis:sismember(max..'banned:'..ChatID,UserID) then 
sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* الغيت حظره من قبل يغالي') 
else
sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* الغيت حظره️')
end
redis:srem(max..'banned:'..ChatID,UserID)
StatusLeft(ChatID, UserID)
end

if cmd == "silent" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك كتم البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم بابا ياورع ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم Dev ") 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم المنشئ ") 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم الادمن ") 
end
if redis:sismember(max..'is_silent_users:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪`'..UserID..'` ❫\n*---›* مكتوم من قبل يغالي') 
end
redis:hset(max..'username:'..UserID, 'username', UserName)
redis:sadd(max..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* كتمته ️')
end

if cmd == "unsilent" then
if not redis:sismember(max..'is_silent_users:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* الغيت كتمه من قبل يغالي') 
end
redis:srem(max..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* الغيت كتمه')
end

if cmd == "banall" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* لا يمكنك حظر البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* لا يمكنك حظر بابا ")
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* لا يمكنك حظر Dev ") 
end
if GeneralBanned(UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* تم  حظره عام️') 
end
redis:hset(max..'username:'..UserID, 'username', UserName)
redis:sadd(max..'gban_users',UserID)
kick_user(UserID, ChatID)
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي » ❪ `'..UserID..'` ❫\n*---›* تم حظره عام')
end

if cmd == "unbanall" then
if not GeneralBanned(UserID) then 
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* تم  الغاء حظره العام️') 
end
redis:srem(max..'gban_users',UserID)
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* تم الغاء حظره العام️')
end

if cmd == "kick" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد بابا ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد Dev") 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المنشئ ") 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد الادمن ") 
end
kick_user(UserID,ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'️*---›* مايمديني اطرد العضو .\n*---›* لانه مشرف في المجموعه')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'️*---›* لا يمكنني طرد العضو .\n*---›* ليس لدي صلاحيه الحظر او لست مشرف')    
end
redis:hset(max..'username:'..UserID, 'username', UserName)
redis:sadd(max..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return sendMsg(ChatID,MsgID,'*---›* العضو ❪ '..UserName..' ❫\n*---›* الايدي ❪ `'..UserID..'` ❫\n*---›* طردته ')
end)
 
end

if cmd == "up_sudo" then
if redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,'*---›*العضو ❪ '..UserName..' ❫\n*---›*الايدي ❪ `'..UserID..'` ❫\n*---›*Dev من قبل يغالي') 
end
redis:hset(max..'username:'..UserID, 'username', UserName)
redis:sadd(max..':SUDO_BOT:',UserID)
return sendMsg(ChatID,MsgID,'*---›*العضو ❪ '..UserName..' ❫\n*---›*الايدي ❪ `'..UserID..'` ❫\n*---›* تم الترقية يغالي صار Dev')
end

if cmd == "dn_sudo" then
if not redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,'*---›*العضو ❪ '..UserName..' ❫\n*---›*الايدي ❪ `'..UserID..'` ❫\n*---›* مو Dev من قبل يغالي')
end
redis:srem(max..':SUDO_BOT:',UserID)
return sendMsg(ChatID,MsgID,'*---›*العضو ❪ '..UserName..' ❫\n*---›*الايدي ❪ `'..UserID..'` ❫\n*---›* تم تنزيله من Dev') 
end

else
return sendMsg(ChatID,MsgID,"*---›* مافيه عضـو بهذا المعرف")
end 

end

function action_by_id(arg, data)

local cmd = arg.cmd
local ChatID = arg.msg.chat_id_
local MsgID = arg.msg.id_
if not data.id_ then 
sendMsg(ChatID,MsgID,"*---›* العضو لا يوجد") 
return false
end
local UserID = data.id_
local Resolv = ResolveUser(data)

if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)


if cmd == "tqeed" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تقييد البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد بابا ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد Dev ") 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المنشئ ") 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد الادمن ") 
end
Restrict(ChatID,UserID,1)
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..':tqeed:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---›  قييدته  ',17,USERCAR) 
end 
if cmd =="fktqeed" then
Restrict(ChatID,UserID,2)
redis:srem(max..':tqeed:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› الغيت تقييده  ',17,USERCAR) 
end
if cmd == "setwhitelist" then
if redis:sismember(max..'whitelist:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› عضو مميز️ من قبل يغالي',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'whitelist:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الترقية يغالي صار عضو مميز ️',17,USERCAR) 
end
if cmd == "setmnsha" then
if redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› منشئ من قبل يغالي',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..':MONSHA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الترقية يغالي صار منشىء ',17,USERCAR) 
end
if cmd == "remmnsha" then
if not redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مو منشىء️ من قبل يغالي',17,USERCAR) 
end
redis:srem(max..':MONSHA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم تنزيله من المنشىء ️',17,USERCAR) 
end
if cmd == "remwhitelist" then
if not redis:sismember(max..'whitelist:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مو عضو مميز من قبل يغالي',17,USERCAR) 
end
redis:srem(max..'whitelist:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم تنزيله من عضو مميز ️',17,USERCAR) 
end
if cmd == "setowner" then
if redis:sismember(max..'owners:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مدير من قبل يغالي ',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'owners:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تمت الترقية صار مدير ️',17,USERCAR) 
end
if cmd == "promote" then
if redis:sismember(max..'admins:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› ادمن️ من قبل يغالي',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'admins:'..ChatID,UserID) 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الترقية يغالي صار ادمن ️',17,USERCAR) 
end
if cmd == "remowner" then
if not redis:sismember(max..'owners:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مو مدير من قبل يغالي ️',17,USERCAR) 
end
redis:srem(max..'owners:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› لعضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم تنزيله من الاداره️',17,USERCAR) 
end
if cmd == "demote" then
if not redis:sismember(max..'admins:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› لعضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مو ادمن️ من قبل يغالي',17,USERCAR) 
end
redis:srem(max..'admins:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم تنزيله من الادمنيه️',17,USERCAR) 
end
if cmd == "whois" then
GetChatMember(ChatID,UserID,function(arg,data1)
local namei = data1.first_name_..' '..(data1.last_name_ or "")
if data1.username_ then useri = '@'..data1.username_ else useri = " لا يوجد " end
return SendMention(ChatID,UserID,MsgID,'---› الاسم » '..namei..'\n'
..'---› الايدي » { '..UserID..' } \n'
..'---› المعرف » '..useri..'\n'
..'---› الرتبه » '..Getrtba(UserID,ChatID)..'\n'
..'---› نوع الكشف » بالايدي',13,utf8.len(namei))
end)
end

if cmd == "up_sudo" then
if redis:sismember(max..':SUDO_BOT:',UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› Dev من قبل يغالي️',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..':SUDO_BOT:',UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الترقية يغالي صار Dev️',17,USERCAR) 
end

if cmd == "dn_sudo" then
if not redis:sismember(max..':SUDO_BOT:',UserID) then return sendMsg(ChatID,MsgID,'*---›*العضو » '..USERNAME..' \n*---›* الايدي » (`'..UserID..'`)\n*---›*مو Dev من قبل يغالي') end
redis:srem(max..':SUDO_BOT:',UserID) 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم تنزيله من Dev️',17,USERCAR) 
end

if cmd == "ban" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›*مايمديك تحظر البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›*مايمديك تحظر بابا ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›*مايمديك تحظر Dev ") 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر المنشئ ") 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›*مايمديك تحظر المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›*مايمديك تحظر المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›*مايمديك تحظر الادمن ") 
end
if Check_Banned(ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› محظور من قبل يغالي',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'banned:'..ChatID,UserID)
kick_user(UserID, ChatID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› حظرته ',17,USERCAR) 
end

if cmd == "kick" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد بابا ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد Dev ") 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المنشئ ") 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تطرد الادمن ") 
end
kick_user(UserID, ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'*---›* مايمديني اطرد العضو .\n*---›* لانه مشرف في المجموعه')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'*---›* لا يمكنني طرد العضو .\n*---›* ليس لدي صلاحيه الحظر او لست مشرف')    
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› طردته',17,USERCAR) 
end)
end

if cmd == "uban" then
if not Check_Banned(ChatID,UserID) then 
 SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› ملغيه حظره️ من قبل يغالي',17,USERCAR) 
else
 SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› الغيت حظره',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:srem(max..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return false
end

if cmd == "ktm" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم بابا ياورع ") 
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم Dev ") 
elseif redis:sismember(max..':KARA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم المنشئ ") 
elseif redis:sismember(max..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم المنشئ ") 
elseif redis:sismember(max..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم المدير ") 
elseif redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تكتم الادمن ") 
end
if redis:sismember(max..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"*---›* لا يمكنك كتم المدراء او الادمنيه ") 
end
if MuteUser(ChatID, UserID) then
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› مكتوم من قبل يغالي',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'is_silent_users:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› كتمته  ️',17,USERCAR) 
end

if cmd == "unktm" then
if not MuteUser(ChatID, UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› ملغيه كتمه من قبل يغالي️',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:srem(max..'is_silent_users:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› الغيت كتمه️',17,USERCAR) 
end

if cmd == "bandall" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر البوت ") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر بابا ")
elseif redis:sismember(max..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"*---›* مايمديك تحظر Dev ") 
end
if GeneralBanned(UserID) then 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم  حظره عام️',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:sadd(max..'gban_users',UserID)
kick_user(UserID,ChatID) 
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم حظره عام️',17,USERCAR) 
end

if cmd == "unbandall" then
if not GeneralBanned(UserID) then
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم  الغاء حظره العام️',17,USERCAR) 
end
redis:hset(max..'username:'..UserID, 'username', Resolv)
redis:srem(max..'gban_users',UserID)
StatusLeft(ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'---› العضو ❪ '..USERNAME..' ❫\n---› الايدي ❪ '..UserID..' ❫\n---› تم الغاء حظره العام️',17,USERCAR) 
end

end

function settingsall(msg)
if redis:get(max..'welcome:get'..msg.chat_id_) then welcomex = "❪ مفعل ❫" else welcomex = "❪ معطل ❫" end
if redis:get(max..'lock_id'..msg.chat_id_) then lock_idx = "❪ مفعل ❫" else lock_idx = "❪ معطل ❫" end
if redis:get(max..'replay'..msg.chat_id_)  then replayx  = "❪ مفعل ❫" else replayx  = "❪ معطل ❫" end
if redis:get(max..'lock_woring'..msg.chat_id_) then lock_woringx = "❪ مفعل ❫" else lock_woringx  = "❪ معطل ❫" end
list_settings = "*⌯‌‌‏* اعدادات المجموعه : \n"
.."\n---›‌‌‏ التعديل ↢ "..(redis:get(max..'lock_edit'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ الروابط ↢ "..(redis:get(max..'lock_link'..msg.chat_id_) or 'false')
.."\n⃣---›‌‌‏ التاق ↢ "..(redis:get(max..'lock_tag'..msg.chat_id_) or 'false')
.."\n---› المعرفات ↢ "..(redis:get(max..'lock_username'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ التكرار ↢ "..(redis:get(max..'lock_flood'..msg.chat_id_) or 'false')
.."\n---› الكلايش ↢ "..(redis:get(max..'lock_spam'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ الويب ↢ "..(redis:get(max..'lock_webpage'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ الماركدوان ↢ "..(redis:get(max..'lock_markdown'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ بالطرد البوتات ↢ "..(redis:get(max..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ البوتات ↢ "..(redis:get(max..'lock_bots'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ عدد التكرار ↢ "..(redis:get(max..'num_msg_max'..msg.chat_id_) or 'false')
.."\n\nـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ\n⌯‌‌‏ اعدادات الوسائط :\n"
.."\n*---›‌‌‏*المتحركه ↢ "..(redis:get(max..'mute_gif'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ لدردشه ↢ "..(redis:get(max..'mute_text'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ الانلاين ↢ "..(redis:get(max..'mute_inline'..msg.chat_id_) or 'false')
.."\n---› الالعاب ↢ "..(redis:get(max..'mute_game'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ الصور ↢ "..(redis:get(max..'mute_photo'..msg.chat_id_) or 'false')
.."\n---› الفيديو ↢ "..(redis:get(max..'mute_video'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ لبصمات ↢ "..(redis:get(max..'mute_audio'..msg.chat_id_) or 'false')
.."\n---› الصوت ↢ "..(redis:get(max..'mute_voice'..msg.chat_id_) or 'false')
.."\n---› الملصقات ↢ "..(redis:get(max..'mute_sticker'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ الجهات ↢ "..(redis:get(max..'mute_contact'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ التوجيه ↢ "..(redis:get(max..'mute_forward'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ الموقع ↢ "..(redis:get(max..'mute_location'..msg.chat_id_) or 'false')
.."\n---›‌‌‏ الملفات ↢ "..(redis:get(max..'mute_document'..msg.chat_id_) or 'false')
.."\n---› الاشعارات ↢ "..(redis:get(max..'mute_tgservice'..msg.chat_id_) or 'false')
.."\n---› الكيبورد ↢ "..(redis:get(max..'mute_keyboard'..msg.chat_id_) or 'false')
.."\n\nـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ\n*---›‌‌‏* اعدادات اخرى : "
.."\n\n*---›‌‌‏* الترحيب ↢ "..welcomex
.."\n*---›‌‌‏* الردود ↢ "..replayx
.."\n*---›‌‌‏* التحذير ↢ "..lock_woringx
.."\n*---›‌‌‏* الايدي ↢ "..lock_idx
list_settings = list_settings:gsub('true', '❬ مقفول ❭')
list_settings = list_settings:gsub('false', '❬ مفتوح ❭')
return sendMsg(msg.chat_id_,1,'➖\n'..list_settings..'\n')
end

function settings(msg)
list_settings = "-‌‌‏ اعدادات المجموعه : "
.."\n\n*⃣-* التاق ↢ "..(redis:get(max..'lock_tag'..msg.chat_id_) or 'false')
.."\n*-* المعرفات ↢ "..(redis:get(max..'lock_username'..msg.chat_id_) or 'false')
.."\n*-* التعديل ↢ "..(redis:get(max..'lock_edit'..msg.chat_id_) or 'false')
.."\n*-* الروابط ↢ "..(redis:get(max..'lock_link'..msg.chat_id_) or 'false')
.."\n*-* التكرار ↢ "..(redis:get(max..'lock_flood'..msg.chat_id_) or 'false')
.."\n*---›‌‌* الكلايش ↢ "..(redis:get(max..'lock_spam'..msg.chat_id_) or 'false')
.."\n*-* الويب ↢ "..(redis:get(max..'lock_webpage'..msg.chat_id_) or 'false')
.."\n*-* الماركدوان ↢ "..(redis:get(max..'lock_markdown'..msg.chat_id_) or 'false')
.."\n*-* البوتات بالطرد ↢ "..(redis:get(max..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\n*-* البوتات ↢ "..(redis:get(max..'lock_bots'..msg.chat_id_) or 'false')
.."\n*-* عدد التكرار ↢ "..(redis:get(max..'num_msg_max'..msg.chat_id_) or 'false')
.."\n┄─┅═ـ═┅─┄\n*-* اعدادات التقـييد :\n"
.."\n*-* التقييد بالتوجيه ↢ "..(redis:get(max..':tqeed_fwd:'..msg.chat_id_) or 'false')
.."\n*-* التقييد بالصور ↢ "..(redis:get(max..':tqeed_photo:'..msg.chat_id_) or 'false')
.."\n*-* التقييد بالروابط ↢ "..(redis:get(max..':tqeed_link:'..msg.chat_id_) or 'false')
.."\n*-* التقييد بالمتحركه ↢ "..(redis:get(max..':tqeed_gif:'..msg.chat_id_) or 'false')
.."\n*-‌‌‏* التقييد الفيديو ↢ "..(redis:get(max..':tqeed_video:'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '❬ مقفول ❭')
list_settings = list_settings:gsub('false', '❬ مفتوح ❭')
return sendMsg(msg.chat_id_, msg.id_,'➖\n'..list_settings..'\n')
end

function media(msg)
list_settings = "*---›‌‌‏* اعدادات الوسائط:\n"
.."\n*-* المتحركه ↢ "..(redis:get(max..'mute_gif'..msg.chat_id_) or 'false')
.."\n*-* الدردشه ↢ "..(redis:get(max..'mute_text'..msg.chat_id_) or 'false')
.."\n*-* الانلاين ↢ "..(redis:get(max..'mute_inline'..msg.chat_id_) or 'false')
.."\n*-‌‌‏* الالعاب ↢ "..(redis:get(max..'mute_game'..msg.chat_id_) or 'false')
.."\n*-‌‌‏* الصور ↢ "..(redis:get(max..'mute_photo'..msg.chat_id_) or 'false')
.."\n*-* الفيديو ↢ "..(redis:get(max..'mute_video'..msg.chat_id_) or 'false')
.."\n*-* البصمات ↢ "..(redis:get(max..'mute_audio'..msg.chat_id_) or 'false')
.."\n*-* الصوت ↢ "..(redis:get(max..'mute_voice'..msg.chat_id_) or 'false')
.."\n*-‌‌‏* الملصقات ↢ "..(redis:get(max..'mute_sticker'..msg.chat_id_) or 'false')
.."\n*-* الجهات ↢ "..(redis:get(max..'mute_contact'..msg.chat_id_) or 'false')
.."\n*-* التوجيه ↢ "..(redis:get(max..'mute_forward'..msg.chat_id_) or 'false')
.."\n*-‌‌‏* الموقع ↢ "..(redis:get(max..'mute_location'..msg.chat_id_) or 'false')
.."\n*-‌‌* الملفات ↢ "..(redis:get(max..'mute_document'..msg.chat_id_) or 'false')
.."\n*-‌‌‏* الاشعارات ↢ "..(redis:get(max..'mute_tgservice'..msg.chat_id_) or 'false')
.."\n*-* الكيبورد ↢ "..(redis:get(max..'mute_keyboard'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '❬ مقفول ❭')
list_settings = list_settings:gsub('false', '❬ مفتوح ❭')
return sendMsg(msg.chat_id_,msg.id_,'➖\n'..list_settings..'\n')
end
