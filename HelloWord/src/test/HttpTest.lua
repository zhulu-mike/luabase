
require "ctkj.utils.LogUtil"
require "ctkj.net.http.HttpWork"

local M = class("HttpTest")
cc.exports.HttpTest = M

function M:ctor()
    LogUtil.log("HttpTest create")
    HttpWork.sendGet("http://127.0.0.1:8088/colorswitch/door.php","updatescore",{userid=1,score=10},handler(self,self.callback))
end

function M:callback(ret)
    LogUtil.log(table.serialize(ret))
end

return M