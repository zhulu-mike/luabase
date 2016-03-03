--[[
@example
require "ctkj.net.http.HttpWork"
require("json")

HttpWork.sendGet("http://127.0.0.1:8088/php/colorswitch/door.php","updatescore",{userid=1,score=10},handler(self,self.callback))

function M:callback(ret)
    LogUtil.log(json.encode(ret))
end
]]--
local M = class("HttpWork")
cc.exports.HttpWork = M
require("json")
local md5 = require "ctkj.utils.md5"
local secret = "fs$#%#$^TGDf#%345"

function M.sendGet(url, commandname, data, callbackhandler)
	local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    local rdata = {funcname = commandname, value = data, token = M.encrypt(data)}
    url = url .. "?" .. M.encodeHttpParam(rdata)
    xhr:open("GET", url)
    release_print("cc.XMLHTTPREQUEST_RESPONSE_JSON:"..cc.XMLHTTPREQUEST_RESPONSE_JSON)
    release_print("http sendget:" .. url)
    local function onReadyStateChange()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
--            local statusString = "Http Status Code:"..xhr.statusText
--            print(xhr.response)
            release_print("http sendget back:" .. xhr.response)
            local backdata = json.decode(xhr.response,1)
            if callbackhandler ~= nil then
                callbackhandler(backdata.data)
            end
        else
            release_print("http sendget back wrong:" .. xhr.response .. " status:" .. xhr.status .. " readyState:" .. xhr.readyState)
        end
    end

    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send()
end

function M.sendPost(url, commandname, data, callbackhandler)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    xhr:open("POST", url)
    local function onReadyStateChange()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            local backdata = json.decode(xhr.response,1)
            if callbackhandler ~= nil then
                callbackhandler(backdata.data)
            end
        else
            print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
    end
    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send()
end
--[[
     把object数据编码成key=value&key2=value2这样的格式
  @param data object
  @returns {string}
 ]]--
function M.encodeHttpParam(data)
    local url = ""
    local flag = false
    for key in pairs(data) do 
        if type(data[key]) == "table" then
            url = url .. (key .. "=" .. string.urlencode(json.encode(data[key])) .. "&")
        else
            url = url .. (key .. "=" .. string.urlencode(data[key]) .. "&")
        end
        flag = true
    end
    if flag then
        url = string.sub(url, 1,#url-1)
    end
    return url
end


function M.encrypt(data)
    local keys = {}
    local i = 1
	for key in pairs(data) do 
	   keys[i] = key
	   i = i + 1
	end
	table.sort(keys)
	local sign = ""
    for key, val in ipairs(keys) do
		sign = sign .. (val .. "=" .. data[val] .. "&")
	end
    sign = sign .. ("key=" .. "sdf#@%#fsd3@%")
    local signdata = md5.sumhexa(sign, string.len(sign))
    --md5(sign)
    signdata = string.upper(signdata)
    return signdata
end



return M

