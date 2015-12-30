require "ctkj.common.observer.Notification"
require "ctkj.managers.PipeManager"
require "ctkj.event.PipeEvent"
require "ctkj.utils.LogUtil"

local PipeTest = class("PipeTest")
cc.exports.PipeTest = PipeTest

function PipeTest:ctor()
    PipeManager.registerMsg(PipeEvent.PIPE_TEST, self.handlePipeEvent, self)
    PipeManager.sendMsg(PipeEvent.PIPE_TEST, "回家吃饭啦")
end

function PipeTest:handlePipeEvent(noti)
    LogUtil.log("收到消息："..noti.name .. "，消息内容："..noti.body);
end

return PipeTest