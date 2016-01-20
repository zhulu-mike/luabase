--@author mike-wjl
local MvcProxy = class("MvcProxy",require "org/puremvc/cocoslua/multicore/patterns/observer/Notifier.lua")
cc.exports.MvcProxy = MvcProxy
MvcProxy.NAME = 'Proxy'
function MvcProxy:ctor(...) 
	MvcProxy.super.ctor(self)
	local proxyName,data = ...
    self.proxyName = proxyName or MvcProxy.NAME
	if data ~= nil then
	  self:setData(data)
	end
end
function MvcProxy:getProxyName() 
	return self.proxyName
end	

function MvcProxy:setData( data ) 
	self.data = data
end

function MvcProxy:getData() 
	return self.data
end	

function MvcProxy:onRegister( )
end

function MvcProxy:onRemove( )
end
	
return MvcProxy