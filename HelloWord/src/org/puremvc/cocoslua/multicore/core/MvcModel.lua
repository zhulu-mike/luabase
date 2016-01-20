--@author mike-wjl

local MvcModel = class("MvcModel")
cc.exports.MvcModel = MvcModel
MvcModel.instanceMap = {}
MvcModel.MULTITON_MSG = "Model instance for this Multiton key already constructed!"
function MvcModel:ctor(key)
    if MvcModel.instanceMap[key] then 
		error( MvcModel.MULTITON_MSG)
	end
	self.multitonKey = key
    MvcModel.instanceMap[self.multitonKey] = self
    self.proxyMap = {}
	self:initializeModel()
end

function MvcModel:initializeModel(  )  
end

function MvcModel.getInstance( key )
    if not MvcModel.instanceMap[key] then
        MvcModel.instanceMap[key] = MvcModel:create(key)
    end
    return MvcModel.instanceMap[key]
end

function MvcModel:registerProxy( proxy )
	proxy:initializeNotifier( self.multitonKey )
    self.proxyMap[proxy:getProxyName()] = proxy
	proxy:onRegister()
end

function MvcModel:retrieveProxy( proxyName )
    return self.proxyMap[proxyName]
end

function MvcModel:hasProxy( proxyName )
    return self.proxyMap[proxyName] ~= nil
end

function MvcModel:removeProxy( proxyName )
    local proxy = self.proxyMap[proxyName]
	if  proxy ~= nil then
		self.proxyMap[proxyName] = nil
		proxy:onRemove()
	end
	return proxy
end

function MvcModel.removeModel( key )
    MvcModel.instanceMap[key] = nil
end

return MvcModel