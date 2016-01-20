--@author mike-wjl

local MvcObserver = class("MvcObserver")
cc.exports.MvcObserver = MvcObserver

function MvcObserver:ctor(notifyMethod, notifyContext ) 
    self.notify = nil
    self.context = nil
	self:setNotifyMethod( notifyMethod )
    self:setNotifyContext( notifyContext )
end


function MvcObserver:setNotifyMethod( notifyMethod )
    self.notify = notifyMethod
end


function MvcObserver:setNotifyContext( notifyContext )
    self.context = notifyContext
end


function MvcObserver:notifyObserver( mvcnotification )
	local method = self.notify
	method(self.context,mvcnotification)
end

 function MvcObserver:compareNotifyContext( object )
	return object == self.context
 end
	
return MvcObserver