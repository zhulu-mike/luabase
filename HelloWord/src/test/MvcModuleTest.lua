
require "ctkj.managers.FacadeManager"
require "ctkj.event.PipeEvent"
require "ctkj.utils.LogUtil"

local M = class("MvcModuleTest")
cc.exports.MvcModuleTest = M

function M:ctor()
    LogUtil.log("MvcModuleTest create")
    FacadeManager.showModule(PipeEvent.STARTUP_TESTMVC, PipeEvent.SHOW_TEST, {})
end


return M