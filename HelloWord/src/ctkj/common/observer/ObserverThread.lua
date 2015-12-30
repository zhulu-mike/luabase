--
local ObserverThread = class("ObserverThread");
cc.exports.ObserverThread = ObserverThread;

    
function ObserverThread:ctor()
    self.s_observerMap = { };
end
    
function ObserverThread:clear()
    self.s_observerMap = { };
end
    
function ObserverThread:registerObserver(__name , __observer )
    if self.s_observerMap[__name] ~= nil
    then
        local index = 1;
        local _arr = self.s_observerMap[__name];
	    local obj;
	    local len = #_arr;
        while index <= len 
        do
            obj = _arr[index];
            if obj:compareNotifyContext(__observer.notifyContext)
		    then
			    return;
		    end
            index = index+1;
        end
        table.insert(self.s_observerMap[__name],__observer);
    else 
        self.s_observerMap[__name] = {__observer};
    end
end

function ObserverThread:removeObserver(__name , __context )
    if self.s_observerMap[__name] ~= nil
    then
        local index = 1;
        local _arr = self.s_observerMap[__name];
	    local obj = nil;
        local len = #_arr;
        while index <= len
        do
                obj = _arr[index] ;
            if obj:compareNotifyContext(__context)
			    then
				    _arr.splice(index, 1);
				    break;
                end
            index = index+1;
        end
        if #_arr == 0
        then
            self.s_observerMap[__name] = nil
        end
    end
end

function ObserverThread:notifyObservers(__notification )
    local _temp = nil;
    local _observer  = nil;
    local index  = 1;
    local observerArr = self.s_observerMap[__notification.name];
    if observerArr ~= nil
    then
        _temp = {};
        local len = #observerArr;
        while index <= len
        do
            _observer = observerArr[index];
            table.insert(_temp,_observer);
            index = index +1;
        end
        index = 1;
        len = #_temp
        while index <= len
        do
            _observer = _temp[index];
            _observer:notifyObserver(__notification);
            index = index +1;
        end
    end
end

return ObserverThread
