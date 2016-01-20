require("ctkj/utils/LogUtil")
require("ctkj/common/observer/Notification")
require("ctkj/event/PipeEvent")
require("ctkj/utils/TableUtil")
require "ctkj.event.EventListener"
require "test.BindUtilTest"
require "test.PipeTest"
require "test.MvcModuleTest"


local MainScene = class("MainScene", cc.load("mvc").ViewBase)

MainScene.RESOURCE_FILENAME = "MainScene.csb"
MainScene.RESOURCE_BINDING = {
cat = {["varname"]="cat"},
Default = {["varname"]="bgimg"}
}

function MainScene:onCreate()
    self.bgimg:setVisible(false)
    LogUtil.log("resource node = %s", tostring(self:getResourceNode()))
    local noti = Notification:create(PipeEvent.PIPE_TEST,{1})
    LogUtil.log(noti.name)
    LogUtil.log(noti.yy)
    local noti2 = Notification:create(PipeEvent.PIPE_TEST2,{1})
    LogUtil.log(noti2.name)
    LogUtil.log(noti:getYY())
    LogUtil.log(noti2:getYY())
    EventListener.addEventListener(nil,"test",self.test);
    EventListener.dispatchEvent("test",2222)
    --绑定工具测试用例
    self.testBindUtil()
    --PipeManager测试用例
    self.testPipe()
    self.testMvc()
end

function MainScene.testBindUtil(value)
    BindUtilTest:create()
end

function MainScene.testPipe(value)
    PipeTest:create()
end

function MainScene.test(parameters)
    LogUtil.log(parameters:getEventName());
    LogUtil.log(parameters.data);
end

function MainScene.testMvc()
    MvcModuleTest:create()
end


return MainScene
