--�����ݸı��£��ɷ����¼�
local DataChangeEvent = class("DataChangeEvent");
cc.exports.DataChangeEvent = DataChangeEvent;

DataChangeEvent.CHANGE = "change";

function DataChangeEvent:ctor(l_valueName, l_oldValue , l_newValue) 
	self.valueName = l_valueName;
	self.oldValue = l_oldValue;
	self.newValue = l_newValue;
end
return DataChangeEvent