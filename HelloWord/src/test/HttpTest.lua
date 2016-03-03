
require "ctkj.utils.LogUtil"
require "ctkj.net.http.HttpWork"

local M = class("HttpTest")
cc.exports.HttpTest = M

function M:ctor()
    LogUtil.log("HttpTest create")
    HttpWork.sendGet("http://192.168.6.72:8088/colorswitch/door.php","loginUser",{deviceid="test6",account="", name="大哥"},handler(self,self.callback))
end

function M:callback(ret)
    LogUtil.log(table.serialize(ret))
end

return M