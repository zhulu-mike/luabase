
require "ctkj/managers/PipeManager.lua"
require "ctkj/event/PipeEvent.lua"
require "ctkj.utils.LogUtil"
local TestMvc_StartupCommand = require "app.game.modules.startscene.controller.TestMvc_StartupCommand"

local TestMvc_Facade = class("TestMvc_Facade",require "org.puremvc.cocoslua.multicore.patterns.facade.MvcFacade")
cc.exports.TestMvc_Facade = TestMvc_Facade
local M = TestMvc_Facade

M.NAME = "TestMvc_Facade";
M.STARTUP = "STARTUP";
M.SHOW_MAINUI = "SHOW_MAINUI"
M.CLOSE_SELF = "CLOSE_SELF"
--监听的模块外部消息列表
M.registerMsgs = {PipeEvent.SHOW_TEST ,PipeEvent.STARTUP_TESTMVC}

function M:ctor(name)
	TestMvc_Facade.super.ctor(self, name);
    PipeManager.registerMsgs(M.registerMsgs, self.handlePipeMessage, self)
end

function M:initializeController()
    TestMvc_Facade.super.initializeController(self)
    self:registerCommand(M.STARTUP, TestMvc_StartupCommand)
end

function M:handlePipeMessage(mvcntf)
	local data = mvcntf.body
	local ntfname = mvcntf.name
    if ntfname == PipeEvent.STARTUP_TESTMVC then
        self:startup() 
    elseif ntfname == PipeEvent.SHOW_TEST then
        self:sendNotification(M.SHOW_MAINUI, data)
    end
end

function M:startup()
    LogUtil.log("TestMvc_Facade startup")
    self:sendNotification(M.STARTUP)
end

function M:dispose()
    --移除模块外部的消息列表监听
    PipeManager.removeMsgs(M.registerMsgs, self);
    --通过模块内部其他组件销毁自身
    self:sendNotification(M.CLOSE_SELF)
    TestMvc_Facade.super.dispose(self)
end

return M



