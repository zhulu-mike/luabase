


--@author michael wang

--[[
@example
	BindUtils.bindSetter(say, testVO, "name");
	BindUtils.bindProperty(temp, "name", testVO, "name", true);
	testVO.name = "jiang" ;
	
	trace("temp.name:",temp.name);
 	
	private say(value:* = nil ):Void{
		trace("say hi",value);
	}
]]--
require("ctkj/common/binds/DataChangeEvent")
require("ctkj/event/EventListener")

local BindUtils = class("BindUtils");
cc.exports.BindUtils = BindUtils;

local s_index = 0;
local s_hosts = {};
		
	function BindUtils:ctor(l_index, l_sProp, l_setter, l_tProp) 
		self.index_ = l_index;
        self.sProp_ = l_sProp;
        self.setter_ = l_setter;
        self.tProp_ = l_tProp;
        self:bind();
	end
	
function BindUtils:bind()
    EventListener.addEventListener(nil,DataChangeEvent.CHANGE,self:dataChangeHander)
end

function BindUtils:dataChangeHander(event)
    local edata = event.data;
    if (edata.valueName == self.sProp_ and edata.newValue ~= edata.oldValue)
	then
        if self.setter_ ~= nil
		then
            self.setter_.excute([edata.newValue]);
		end
        if self.tHost_ ~= nil
		then
            self.tHost_[self.tProp_] = edata.newValue;
		end
	}
	end
end

function BindUtils:clear()
	self:unbind();
    self.setter_ = nil;
    s_hosts[self.index_] = nil;
end

function BindUtils:unbind()
    EventListener.removeEventListener(nil,self:dataChangeHander);
end

--��һ������ example BindUtils.bindProperty(_page, "currentPage", _pageData, "currentPage", true);
--@param l_tHost ����󶨵� l_sProp �����Ե� Object�� 
--@param l_tProp ��Ҫ�󶨵� site Object �ж���Ĺ������Ե����ơ��� chain ֵ����ʱ�������Խ����� chain �ĵ�ǰֵ��
--@param l_sHost ���ڳ���Ҫ���ӵ����Ի��������Ķ��� 
--@param l_sProp ����ָ��Ҫ���ӵ����Ի���������ֵ��
--@param l_immediately �Ƿ�����ִ��
--@return void
function BindUtils.bindProperty(l_tHost, l_tProp, l_sHost, l_sProp, l_immediately)
    l_immediately = l_immediately or false;
	if l_immediately
	then
		l_tHost[l_tProp] = l_sHost[l_sProp];
	end
    BindUtils.s_index = BindUtils.s_index + 1;
    local _bind = BindUtils:create(BindUtils.s_index, l_sProp, nil, l_tProp);
    BindUtils.s_hosts[BindUtils.s_index] = _bind;
	return _bind
end

function BindUtils.allUnbind()
	local _temp = nil;
	local allutils = BindUtils.s_hosts;
    for _temp in pairs(allutils)
    do
		allutils[_temp]:clear();
	end
	BindUtils.s_index = 0;
    BindUtils.s_hosts = {};
	return;
end
	
--example BindUtils.bindSetter(setListFun, _pageData, "showList");
 --@param l_setter ���Ըı�ʱ�����¼�
 --@param l_sHost  ���ڳ���Ҫ���ӵ����Ի��������Ķ���
 --@param l_tProp  ����ָ��Ҫ���ӵ����Ի���������ֵ��
 --@param l_immediately �Ƿ�����ִ��
 --@return void
function BindUtils.bindSetter(l_setter, l_sHost, l_tProp, l_immediately)
    l_immediately = l_immediately or false;
    if l_immediately
    then
        l_setter.excute([l_sHost[l_tProp]]);
    end
    BindUtils.s_index = BindUtils.s_index + 1;
    local _bind = BindUtils:create(BindUtils.s_index, l_sHost, l_tProp, l_setter);
    BindUtils.s_hosts[BindUtils.s_index] = _bind;
    return _bind
end

return BindUtils