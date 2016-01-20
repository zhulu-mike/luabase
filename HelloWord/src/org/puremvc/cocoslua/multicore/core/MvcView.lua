--@author mike-wjl

local MvcView = class("MvcView")
cc.exports.MvcView = MvcView

require "org/puremvc/cocoslua/multicore/patterns/observer/MvcObserver.lua"
MvcView.instanceMap = {}
MvcView.MULTITON_MSG = "View instance for this Multiton key already constructed!"

function MvcView:ctor(key) 
    if MvcView.instanceMap[key] then 
        error(MvcView.MULTITON_MSG)
    end
    self.multitonKey = key
    MvcView.instanceMap[self.multitonKey] = self
    self.mediatorMap = {}
    self.observerMap = {}
	self:initializeView()
end

function MvcView:initializeView(  ) 
end

function MvcView.getInstance( key ) 
    if not MvcView.instanceMap[key] then
        MvcView.instanceMap[key] = MvcView:create( key )
    end
    return MvcView.instanceMap[key]
end
	
--注册一个消息
function MvcView:registerObserver ( notificationName, mvcobserver )
    if self.observerMap[notificationName] then 
        table.insert(self.observerMap[notificationName], mvcobserver)
    else
        self.observerMap[notificationName] = { mvcobserver }	
    end
end


function MvcView:notifyObservers( mvcnotification )
    if self.observerMap[mvcnotification:getName()] then
        local observers_ref = self.observerMap[mvcnotification:getName()]
    	local observers = {}
    	local observer = nil
    	local len = #observers_ref
        local i = 1
    	while i<=len do 
    		observer = observers_ref[ i ]
    		table.insert(observers,observer )
            i = i + 1
    	end
    	
    	len = #observers
        i = 1
        while i<=len do
    		observer = observers[ i ]
    		observer:notifyObserver( mvcnotification )
            i = i + 1
    	end
    end
end						

function MvcView:removeObserver( notificationName, notifyContext )
    -- the observer list for the notification under inspection
    local observers = self.observerMap[notificationName]
    -- find the observer for the notifyContext
    local len = #observers
    local i = 1
    while i<=len do
    	if observers[i]:compareNotifyContext( notifyContext ) == true then
    		observers[i] = nil
    		break
    	end
        i = i + 1
    end
    
    if #observers == 0 then
        self.observerMap[ notificationName ] = nil	
    end 
end


function MvcView:registerMediator( mediator )
    if self.mediatorMap[mediator:getMediatorName()] then
    	return
    end
    mediator:initializeNotifier(self.multitonKey )
    self.mediatorMap[mediator:getMediatorName()] = mediator
    local interests = mediator:listNotificationInterests()
    if #interests > 0 then
    	local observer = MvcObserver:create( mediator.handleNotification, mediator )
    
    	local len = #interests
        local i = 1
        while i<=len do
            self:registerObserver( interests[i],  observer )
            i = i + 1 
    	end
    end
    mediator:onRegister()
end

function MvcView:retrieveMediator( mediatorName )
    return self.mediatorMap[mediatorName]
end

function MvcView:removeMediator( mediatorName )
    local mediator = self.mediatorMa[ mediatorName ]
    if mediator ~= nil then
    	local interests = mediator:listNotificationInterests()
    	local len = #interests
        local i = 1
        while i<= len do
            self:removeObserver( interests[i], mediator )
            i = i + 1
    	end
        self.mediatorMap[mediatorName] = nil
    	mediator:onRemove()
    end
    return mediator
end
					
function MvcView:hasMediator( mediatorName )
	return self.mediatorMap[mediatorName] ~= nil
end
	
function MvcView.removeView( key )
    MvcView.instanceMap[key] = nil
end
return MvcView