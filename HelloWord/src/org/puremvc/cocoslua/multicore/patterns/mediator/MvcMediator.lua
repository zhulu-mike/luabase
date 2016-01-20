--@author mike-wjl

local MvcMediator = class("MvcMediator",require "org/puremvc/cocoslua/multicore/patterns/observer/Notifier.lua")
cc.exports.MvcMediator = MvcMediator

MvcMediator.NAME = 'Mediator'

function MvcMediator:ctor(...) 
	MvcMediator.super.ctor(self)
	local mediatorName, viewComponent = ...
    self.mediatorName = mediatorName or MvcMediator.NAME
	self.viewComponent = viewComponent	
end	
function MvcMediator:getMediatorName() 
	return self.mediatorName
end

function MvcMediator:setViewComponent( viewComponent ) 
	self.viewComponent = viewComponent
end

function MvcMediator:getViewComponent()
	return self.viewComponent
end

function MvcMediator:listNotificationInterests()
	return {}
end

function MvcMediator:handleNotification( mvcnotification )
end

function MvcMediator:onRegister( )
end

function MvcMediator:onRemove( ) 
end
return MvcMediator	
