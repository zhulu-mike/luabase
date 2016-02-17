
local Type = class("Type")
cc.exports.Type = Type


--����һ��ʵ��
--@params classname string ��������
--@params ... �ɱ����
function Type.createInstance(classname, ...)
    local cl = classname
    if type(classname) == "string" then
        local status, cls = xpcall(function ()
            return import( classname)
        end,function (msg)
            release_print("Type.createInstance " .. classname .. " not found, detail info " .. msg)
        end)
        if not status then
            return 
        end
        cl = cls
    end
    if ... == nil or #... == 0 then
        return cl.new()
    end
    return cl.new(...)
end
    
    
return Type
    

