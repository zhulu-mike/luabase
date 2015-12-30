--消息封装
local Observer = class("Observer");
cc.exports.Observer = Observer;

    
function Observer:ctor(__method , __context )
    self.s_notifyMethod = __method;
    self.s_notifyContext = __context;
end
    
function Observer:notifyObserver(__notification)
    self.s_notifyMethod(self.s_notifyContext,__notification);
end
    
--比较函数上下文域
--@param __nontext 上下文域
--@return bool
function Observer:compareNotifyContext(__nontext)
    return __nontext == self.s_notifyContext;
end
return Observer