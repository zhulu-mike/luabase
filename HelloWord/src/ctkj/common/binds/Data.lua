require("ctkj/common/binds/DataChangeEvent")
require("ctkj/event/EventListener")

--[[
@example
require("ctkj/common/binds/Data")
	
local GameData = class("GameData",Data) 
cc.exports.GameData = GameData;

function GameData.:ctor()
end

function get name()
	return _name;
end

function set name(value)
	valueChanged("name", "_name", value);
end

function setProperty($name, $value)
	this[$name] = $value;
	return;
end

function getProperty($name)
	return this[$name];
end
return GameData
]]--
local Data = class("Data")

cc.exports.Data = Data

function Data:ctor() 
end
	
function Data:valueChanged(eventName, propName, value)
    local _data = self:getProperty(propName);
    self:setProperty(propName, value);
	if value ~= _data
	then
        EventListener.dispatchEvent(DataChangeEvent.CHANGE, {valueName=eventName, oldValue=_data, newValue=value})
	end
end

function Data:getProperty(name)
	return self[name];
end

function Data:setProperty(name, value)
	self[name] = value;
end

return Data