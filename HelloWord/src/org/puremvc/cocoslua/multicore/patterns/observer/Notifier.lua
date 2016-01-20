--@author mike-wjl

require "org.puremvc.cocoslua.multicore.patterns.facade.MvcFacade"

local Notifier = class("Notifier")
cc.exports.Notifier = Notifier


function Notifier:ctor()
    self.multitonKey = nil 
end


function Notifier:sendNotification(notificationName, ... ) 
    if self.getFacade() ~= nil then
	   local body,type = ...
	   self:getFacade():sendNotification( notificationName, body, type )
	end
end

function Notifier:initializeNotifier(key )
	self.multitonKey = key
end

function Notifier:getFacade()
	if self.multitonKey == nil  then
	   error(Notifier.MULTITON_MSG)
    end
    if self.facade == nil then
    	self.facade = MvcFacade.getInstance( self.multitonKey )
    end
    return self.facade
end

Notifier.MULTITON_MSG = "multitonKey for this Notifier not yet initialized!"

return Notifier
	
