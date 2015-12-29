cc.exports.ObjectPool = class("ObjectPool")

local map = {};

local function createObject(name)
    local obj = cc.Sprite:createWithSpriteFrameName(name);
    obj.name = name;
--    print("create object: "..name)
    return obj;
end

function ObjectPool:getObject(name)
    local obj;
    if map[name] == nil then
        map[name] = {};
    end
    if #map[name] < 1 then
        obj = createObject(name);
    else
        obj = table.remove(map[name],#map[name]);
    end
    obj.x,obj.y = 0,0;
    return obj;
end

function ObjectPool:pushObject(obj)
    if obj.name ~= nil then
        if map[obj.name] == nil then
            map[obj.name] = {};
        end
        map[obj.name][#map[obj.name]+1] = obj;
    end
end

return ObjectPool