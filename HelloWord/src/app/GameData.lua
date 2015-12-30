local M = class("GameData",require("ctkj/common/binds/Data"));
cc.exports.GameData = M;

function GameData:ctor()
end
function GameData:getName()
    return self.name;
end

function GameData:setName(value)
    self:valueChanged("name", "name", value);
end

function GameData:setProperty(key, value)
    self[key] = value
end

function GameData:getProperty(key)
    return self[key]
end
return GameData
