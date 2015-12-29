--ÏûÏ¢·â×°
local Notification = class("Notification");
cc.exports.Notification = Notification;
Notification.yy = 1;
function Notification:ctor(_name, _body)
    self.name = _name;
    self.body = _body;
    Notification.yy = Notification.yy + 1;
end

function Notification:getYY()
    return self.yy;
end
return Notification



