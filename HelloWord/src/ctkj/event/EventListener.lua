cc.exports.EventListener = {}

--事件侦听 node==nil时表示全局侦听
function EventListener.addEventListener(node,customEventName,fun)
    if node ~= nil then
        local eventDispatcher = node:getEventDispatcher();
        local listener = cc.EventListenerCustom:create(customEventName,  fun);
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener,node);
    else
        local eventDispatcher = cc.Director:getInstance():getEventDispatcher();
        local listener = cc.EventListenerCustom:create(customEventName,fun);
        eventDispatcher:addEventListenerWithFixedPriority(listener,1);
    end
end

function EventListener.removeCustomEventListeners(node,customEventName)
    local eventDispatcher = nil;
    if node ~= nil then
        eventDispatcher = node:getEventDispatcher();
    else
        eventDispatcher = cc.Director:getInstance():getEventDispatcher();
    end
    eventDispatcher:removeCustomEventListeners(customEventName);
end

function EventListener.removeEventListener(node,listener)
    local eventDispatcher = nil;
    if node ~= nil then
        eventDispatcher = node:getEventDispatcher();
    else
        eventDispatcher = cc.Director:getInstance():getEventDispatcher();
    end
    eventDispatcher:removeEventListener(listener)
end

function EventListener.removeAllEventListeners(node,listener)
    local eventDispatcher = node:getEventDispatcher();
    eventDispatcher:removeAllEventListeners();
end

function EventListener.dispatchEvent(eventType,data)
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher();
    local event = cc.EventCustom:new(eventType)
    if data ~= nil then
        event.data = data;
    end
    eventDispatcher:dispatchEvent(event);
end

return EventListener