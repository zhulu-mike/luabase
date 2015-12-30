--管道信息工具，用于模块分支与主干之间通信

require "ctkj.common.observer.ObserverThread"
require "ctkj.common.observer.Observer"
require "ctkj.common.observer.Notification"

local M = {};
cc.exports.PipeManager = M;

local _msgObserverThread = ObserverThread:create();

--发送一个消息
--@param seventname string 消息名
--@param data table 消息内容，可以为nil
--@return void
function M.sendMsg(eventname, data)
    local noti = Notification:create(eventname, data);
    _msgObserverThread:notifyObservers(noti);
end
--注册监听一个消息
--@param seventname 消息名
--@return void
function M.registerMsg(eventname, method, context)
	local obs = Observer:create(method, context);
    _msgObserverThread:registerObserver(eventname, obs);
end

--注册监听一组消息
--@param seventnames table 消息名列表 
--@return void
function M.registerMsgs(eventnames, method, context)
    for key, var in pairs(eventnames) do
        M.registerMsg(var, method, context);
    end
end

--移除一个消息
--@param seventname string 消息名
--@return void
function M.removeMsg(eventname, context)
    _msgObserverThread:removeObserver(eventname, context);
end
--移除N个消息
--@param seventnames table 消息名
--@return void
function M.removeMsgs(eventnames, context)
    for key, var in pairs(eventnames) do
        M.removeMsg(var, context);
    end
end

