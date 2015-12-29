--管道信息工具，用于模块分支与主干之间通信
local M = {};
cc.exports.PipeManager = M;

--发送一个消息
--@param seventname string 消息名
--@param data table 消息内容，可以为nil
--@return void
function M.sendMsg(eventname, data)
	
end
--注册监听一个消息
--@param seventname 消息名
--@return void
function M.registerMsg(eventname)
	
end

--注册监听一组消息
--@param seventnames table 消息名列表 
--@return void
function M.registerMsgs(eventnames)

end

--注册监听一个消息
--@param seventname string 消息名
--@return void
function M.unRegisterMsg(eventname)

end


