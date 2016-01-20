
require "org/puremvc/cocoslua/multicore/patterns/facade/MvcFacade.lua"
require "ctkj.managers.PipeManager"
require "org/puremvc/cocoslua/type.lua"
require "ctkj.utils.LogUtil"

local M = class("FacadeManager")
cc.exports.FacadeManager = M
LogUtil.log("import FacadeManager")
function M:ctor()
    
end

function M.showModule(modulename, eventname, data)
    local hasFacade = M.hasFacade(modulename)
    if hasFacade then
        PipeManager.sendMsg(eventname, data)
    else
        M.startupFacade(modulename, { eventname=eventname, data=data })
    end
end

function M.startupFacade(facadeName, data)
    local hasFacade = M.hasFacade(facadeName);
    if hasFacade then

    else
        --加载模块资源
        M.getFacade(facadeName)
        PipeManager.sendMsg(facadeName, null)
        PipeManager.sendMsg(data.eventname, data.data)
    end
end

function M.getFacade(facadeName)
    if MvcFacade.instanceMap[facadeName] == nil then
        Type.createInstance(facadeName, facadeName)
    end
    return MvcFacade.instanceMap[facadeName]
end

function M.killFacade(facadeName)
    local facade = M.getFacade(facadeName)
    if facade ~= nil then
        facade:dispose()
    end
end

function M.hasFacade(facadeName)
    return MvcFacade.instanceMap[facadeName] ~= nil
end


return M