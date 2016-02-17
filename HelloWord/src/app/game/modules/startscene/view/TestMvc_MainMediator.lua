require "ctkj.utils.LogUtil"
local M = class("TestMvc_MainMediator",require "org.puremvc.cocoslua.multicore.patterns.mediator.MvcMediator")


M.NAME = "TestMvc_MainMediator"

function M:ctor(view)
	M.super.ctor(self, M.NAME, view)
	--�ṩһ��view���õ���д
    self.vc = self.viewComponent
end

--ģ����ͨ����Ϣ�б�
function M:listNotificationInterests()
    return { TestMvc_Facade.SHOW_MAINUI,TestMvc_Facade.CLOSE_SELF}
end

--ģ������Ϣ������
function M:handleNotification(mvcntf)
    local data = mvcntf.body
    local ntfname = mvcntf.name
    if ntfname == TestMvc_Facade.SHOW_MAINUI then
        self:showMainUI(data)
    elseif ntfname == TestMvc_Facade.CLOSE_SELF then
        self:closeSelf(data)
    end
end
--��ʾmainui
function M:showMainUI(data)
    LogUtil.log("showMainUI:" .. M.NAME)
end
--���ٱ������������������и���mediator��ص�
function M:closeSelf(data)
    LogUtil.log("closeSelf:" .. M.NAME)
end

return M


