

require "org/puremvc/cocoslua/multicore/core/MvcController.lua"
require "org/puremvc/cocoslua/multicore/core/MvcModel.lua"
require "org/puremvc/cocoslua/multicore/core/MvcView.lua"
require "org/puremvc/cocoslua/multicore/patterns/observer/MvcNotification.lua"

--@author mike-wjl
local MvcFacade = class("MvcFacade")
cc.exports.MvcFacade = MvcFacade

MvcFacade.instanceMap = {}
MvcFacade.MULTITON_MSG = "Facade instance for this Multiton key already constructed!"

function MvcFacade:ctor(key) 
    if MvcFacade.instanceMap[key] ~= nil then
        error(self.MULTITON_MSG)
    end
    self.multitonKey = key
	self:initializeNotifier(key)
    MvcFacade.instanceMap[self.multitonKey] = self
    self:initializeFacade()
end
function MvcFacade:initializeFacade(  )
    self:initializeModel()
    self:initializeController()
    self:initializeView() 
end

function MvcFacade.getInstance( key )
    if MvcFacade.instanceMap[key] == nil then
        MvcFacade.instanceMap[key] = MvcFacade:create(key)
    end
    return MvcFacade.instanceMap[key]
end

function MvcFacade:initializeController( )
    if self.controller ~= nil then
        return
    end
    self.controller = MvcController.getInstance(self.multitonKey )
end

function MvcFacade:initializeModel( )
    if self.model ~= nil then
        return
    end
    self.model = MvcModel.getInstance(self.multitonKey )
end

function MvcFacade:initializeView( )
    if self.view ~= nil then 
        return
    end
    self.view = MvcView.getInstance(self.multitonKey )
end

function MvcFacade:registerCommand( notificationName, commandClassRef )
    self.controller:registerCommand( notificationName, commandClassRef )
end

function MvcFacade:removeCommand( notificationName )
    self.controller:removeCommand( notificationName )
end

function MvcFacade:hasCommand( notificationName )
    return self.controller:hasCommand(notificationName)
end

function MvcFacade:registerProxy ( proxy )
    self.model:registerProxy ( proxy )
end
		
function MvcFacade:retrieveProxy ( proxyName ) 
    return self.model:retrieveProxy ( proxyName )
end

function MvcFacade:removeProxy ( proxyName ) 
    local proxy = nil
    if self.model ~= nil then
        proxy = self.modelL:removeProxy ( proxyName )
    end	
    return proxy
end

function MvcFacade:hasProxy( proxyName )
    return self.model:hasProxy( proxyName )
end

function MvcFacade:registerMediator( mediator ) 
    if self.view ~= nil then 
        self.view:registerMediator( mediator )
    end
end

function MvcFacade:retrieveMediator( mediatorName ) 
    return self.view:retrieveMediator( mediatorName )
end

function MvcFacade:removeMediator( mediatorName ) 
	local mediator=nil
    if self.view ~= nil then
        mediator = self.view:removeMediator( mediatorName )
    end		
	return mediator
end

function MvcFacade:hasMediator( mediatorName )
    return self.view:hasMediator( mediatorName )
end

function MvcFacade:sendNotification( notificationName,...) 
    self:notifyObservers( MvcNotification:create( notificationName, ... ) )
end

function MvcFacade:notifyObservers ( notification )
    if self.view ~= nil then
        self.view:notifyObservers( notification )
    end
end

function MvcFacade:initializeNotifier( key )
    self.multitonKey = key
end

function MvcFacade.hasCore( key )
    return MvcFacade.instanceMap[key] ~= nil
end

function MvcFacade.removeCore( key )
	if not MvcFacade.instanceMap[key] then 
      return
    end
	MvcModel.removeModel( key )
	MvcView.removeView( key )
	MvcController.removeController( key )
	MvcFacade.instanceMap[key] = nil
end

--Ïú»Ù±¾Ä£¿é
function MvcFacade:dispose()
	MvcFacade.removeCore(key)
end

return MvcFacade