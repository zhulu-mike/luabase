require("ctkj/utils/LogUtil")
require("ctkj/common/observer/Notification")
require("ctkj/event/PipeEvent")
require("ctkj/utils/TableUtil")
require "ctkj.event.EventListener"
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

MainScene.RESOURCE_FILENAME = "MainScene.csb"
MainScene.RESOURCE_BINDING = {
cat = {["varname"]="cat"},
Default = {["varname"]="bgimg"}
}

function MainScene:onCreate()
    self.bgimg:setVisible(false);
    LogUtil.log("resource node = %s", tostring(self:getResourceNode()));
    local noti = Notification:create(PipeEvent.ROLE_DIE,{1});
    LogUtil.log(noti.name);
    LogUtil.log(noti.yy);
    local noti2 = Notification:create(PipeEvent.SHOW_RESULT,{1});
    LogUtil.log(noti2.name);
    LogUtil.log(noti:getYY());
    EventListener.addEventListener(nil,"test",self.test);
    EventListener.dispatchEvent("test",2222);
end

function MainScene.test(parameters)
    LogUtil.log(parameters:getEventName());
    LogUtil.log(parameters.data);
end

return MainScene
