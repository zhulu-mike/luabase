--��Ϣ��װ
local Observer = class("Observer");
cc.exports.Observer = Observer;

    
function Observer:ctor(__method , __context )
    self.s_notifyMethod = __method;
    self.s_notifyContext = __context;
end
    
function Observer.notifyObserver(__notification)
    self.s_notifyMethod(self.s_notifyContext,__notification);
end
    
--�ȽϺ�����������
--@param __nontext ��������
--@return bool
function Observer.compareNotifyContext(__nontext)
    return __nontext == self.s_notifyContext;
end
return Observer