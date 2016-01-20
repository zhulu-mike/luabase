--@author mike-wjl
 
local Controller = class("MvcController")
cc.exports.MvcController = Controller
require "org/puremvc/cocoslua/type.lua"
require "org/puremvc/cocoslua/multicore/patterns/observer/MvcObserver.lua"
require "org.puremvc.cocoslua.multicore.core.MvcView"
	
--Singleton instance
Controller.instanceMap = {}
Controller.MULTITON_MSG = "Controller instance for this Multiton key already constructed!";
--Mapping of Notification names to Command Class references

function Controller:ctor( key )
	if Controller.instanceMap[key] then
        error(self.MULTITON_MSG)
    end
    self.view = nil
    self.commandMap = {}
	self.multitonKey = key
    Controller.instanceMap[key] = self
	self:initializeController()
end


function Controller:initializeController(  ) 
    self.view = MvcView.getInstance( self.multitonKey )
end

--获取一个key对应的Controller实例
--@params key string 
--@return instance of Controller
function Controller.getInstance( key )
    if not Controller.instanceMap[key] then
        Controller.instanceMap[key] = Controller:create( key )
    end
    return Controller.instanceMap[key]
end


function Controller:executeCommand( mvcnotifi )
	local commandClassRef = self.commandMap[mvcnotifi:getName()]
	if commandClassRef == nil or commandClassRef == "" then
		return
    end
    local commandInstance = Type.createInstance(commandClassRef)
	commandInstance:initializeNotifier( self.multitonKey )
	commandInstance:execute( mvcnotifi )
end
--注册一个command
function Controller:registerCommand(notificationName, commandClassRef )
	if not self.commandMap[notificationName] then 
		self.view:registerObserver( notificationName, MvcObserver:create(self.executeCommand, self ))
	end
	self.commandMap[notificationName] = commandClassRef
end

--查询一个command是否已经注册了
--@return bool

function Controller:hasCommand(notificationName )
	return self.commandMap[notificationName] ~= nil
end

--移除一个command
function Controller:removeCommand(notificationName )
	--if the Command is registered...
	if  self:hasCommand( notificationName )  then
		-- remove the observer
		self.view:removeObserver( notificationName, self )
					
		-- remove the command
		self.commandMap:remove( notificationName )
	end
end


function Controller.removeController(key)
    Controller.instanceMap[key] = nil
end
	
return Controller