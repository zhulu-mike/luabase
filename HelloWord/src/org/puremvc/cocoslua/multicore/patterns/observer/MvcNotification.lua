--@author mike-wjl
local M = class("MvcNotification")
cc.exports.MvcNotification = M

function M:ctor(name,... ) 
	self.name = name
	self.body,self.type = ...
end

function M:getName()
	return self.name
end
		
function M:setBody( body )
	self.body = body
end

function M:getBody()
	return self.body
end

function M:setType( type )
	self.type = type
end


function M:getType()
	return self.type
end

function M:tostring()
	local msg = "Notification Name: " .. self:getName()
	msg = msg .. "\nType:" .. (self.type or "")
	return msg
end
		
return M