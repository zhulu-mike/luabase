require "ctkj.common.observer.Notification"
require "ctkj.managers.PipeManager"
require "ctkj.event.PipeEvent"
require "ctkj.utils.LogUtil"

local PipeTest = class("PipeTest")
cc.exports.PipeTest = PipeTest

function PipeTest:ctor()
    PipeManager.registerMsg(PipeEvent.PIPE_TEST, self.handlePipeEvent, self)
    LogUtil.log("--发送测试消息--");
    PipeManager.sendMsg(PipeEvent.PIPE_TEST, "回家吃饭啦");
    LogUtil.log("--测试移除监听功能--");
    PipeManager.removeMsg(PipeEvent.PIPE_TEST,self)
    LogUtil.log("--再次发送测试消息--");
    PipeManager.sendMsg(PipeEvent.PIPE_TEST, "回家吃饭啦");
    
    LogUtil.log("--测试批量监听功能--");
    PipeManager.registerMsgs({PipeEvent.PIPE_TEST3,PipeEvent.PIPE_TEST2}, self.handleBatchPipeEvent, self)
    LogUtil.log("--发送测试消息2--");
    PipeManager.sendMsg(PipeEvent.PIPE_TEST2, "再次回家吃饭啦");
    LogUtil.log("--发送测试消息3--");
    PipeManager.sendMsg(PipeEvent.PIPE_TEST3, "再再次回家吃饭啦");
    LogUtil.log("--测试批量移除监听功能--");
    PipeManager.removeMsgs({PipeEvent.PIPE_TEST2, PipeEvent.PIPE_TEST3},self)
    LogUtil.log("--再次发送测试消息2--");
    PipeManager.sendMsg(PipeEvent.PIPE_TEST2, "再次回家吃饭啦");
end

function PipeTest:handlePipeEvent(noti)
    LogUtil.log("收到消息："..noti.name .. "，消息内容："..noti.body);
end

function PipeTest:handleBatchPipeEvent(noti)
    LogUtil.log("收到批量消息："..noti.name .. "，消息内容："..noti.body);
end

return PipeTest