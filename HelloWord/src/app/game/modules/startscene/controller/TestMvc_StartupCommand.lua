
local TestMvc_MainMediator = require "app/game/modules/startscene/view/TestMvc_MainMediator.lua"
local M = class("TestMvc_StartupCommand",require "org.puremvc.cocoslua.multicore.patterns.command.SimpleCommand")

function M:ctor()
	M.super.ctor(self)
end

--一般在此处注册meditor，proxy等初始化操作
function M:execute(mvcntf)
    self:getFacade():registerMediator( TestMvc_MainMediator:create(nil) )
end

return M