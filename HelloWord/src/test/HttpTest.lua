
require "ctkj.utils.LogUtil"
require "ctkj.net.http.HttpWork"

local M = class("HttpTest")
cc.exports.HttpTest = M

function M:ctor()
    LogUtil.log("HttpTest create")
    HttpWork.sendGet("http://192.168.6.72:8088/colorswitch/door.php","loginUser",{deviceid="test88",account="", name="88"},handler(self,self.callback))
end

function M:callback(ret)
    release_print(1)
    HttpWork.sendGet("http://192.168.6.72:8088/colorswitch/door.php","updatescore",{userid=ret.user.id,score=4, lk=ret.user.loginkey})
end

return M