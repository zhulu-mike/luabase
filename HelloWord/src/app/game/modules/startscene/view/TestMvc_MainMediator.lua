require "ctkj.utils.LogUtil"
local M = class("TestMvc_MainMediator",require "org.puremvc.cocoslua.multicore.patterns.mediator.MvcMediator")


M.NAME = "TestMvc_MainMediator"

function M:ctor(view)
	M.super.ctor(self, M.NAME, view)
	--提供一个view引用的缩写
    self.vc = self.viewComponent
end

--模块内通信消息列表
function M:listNotificationInterests()
    return { TestMvc_Facade.SHOW_MAINUI,TestMvc_Facade.CLOSE_SELF}
end

--模块内消息处理器
function M:handleNotification(mvcntf)
    local data = mvcntf.body
    local ntfname = mvcntf.name
    if ntfname == TestMvc_Facade.SHOW_MAINUI then
        self:showMainUI(data)
    elseif ntfname == TestMvc_Facade.CLOSE_SELF then
        self:closeSelf(data)
    end
end
--显示mainui
function M:showMainUI(data)
    LogUtil.log("showMainUI:" .. M.NAME)
end
--销毁本身，在这里销毁所有跟本mediator相关的
function M:closeSelf(data)
    LogUtil.log("closeSelf:" .. M.NAME)
end

return M



