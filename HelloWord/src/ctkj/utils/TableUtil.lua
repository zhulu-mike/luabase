cc.exports.TableUtil = {}

-- 检查table里是否存在
function TableUtil.IsInTable(tbl,value)
    for k,v in ipairs(tbl) do
        if v == value then
            return true;
        end
    end
    return false;
end

-- 遍历数组
function TableUtil.getn(tb)
    local cnt = 0;
    for k,v in pairs(tb) do
        cnt = cnt + 1;
    end
    return cnt;
end

function TableUtil.indexOf(t,v)
    local index = -1;
    for i,_v in ipairs(t) do
        if _v == v then
            index = i;
        end
    end
    return index;
end

function TableUtil.copyTab(st)
    if not st then return nil end
    local tab = {}
    for k, v in pairs(st or {}) do
        if type(v) ~= "table" then
            tab[k] = v
        else
            tab[k] = TableUtil.copyTab(v)
        end
    end
    return tab
end

function TableUtil.serialize(obj)
    local lua = ""  
    local t = type(obj)  
    if t == "number" then  
        lua = lua .. obj  
    elseif t == "boolean" then  
        lua = lua .. tostring(obj)  
    elseif t == "string" then  
        lua = lua .. string.format("%q", obj)  
    elseif t == "table" then  
        lua = lua .. "{\n"  
        for k, v in pairs(obj) do  
            lua = lua .. "[" .. TableUtil.serialize(k) .. "]=" .. TableUtil.serialize(v) .. ",\n"  
        end  
        local metatable = getmetatable(obj)  
        if metatable ~= nil and type(metatable.__index) == "table" then  
            for k, v in pairs(metatable.__index) do  
                lua = lua .. "[" .. TableUtil.serialize(k) .. "]=" .. TableUtil.serialize(v) .. ",\n"  
            end  
        end  
        lua = lua .. "}"  
    elseif t == "nil" then  
        return nil  
    else  
--        error("can not serialize a " .. t .. " type.")  
        return "";
    end  
    return lua  
end  

return TableUtil