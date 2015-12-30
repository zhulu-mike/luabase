require "ctkj.event.EventListener"
require "ctkj.common.binds.BindUtils"
require "app/GameData.lua"

local M = class("BindUtilTest")
cc.exports.BindUtilTest = M

function M:ctor()
    local gd = GameData:create();
    --设置初始值
    gd:setName("firstname");
    LogUtil.log(gd:getName());
    --绑定name属性，当name改变时，调用test2函数。
    BindUtils.bindSetter(handler(self,self.test2),gd,"name",true);
    --绑定name属性，当name改变时，更新本实例的hname属性
    BindUtils.bindProperty(self, "hname", gd, "name", true);
    --改变gd实例的name属性，以验证是否会触发相应的绑定事件
    gd:setName("secondname");
    LogUtil.log("My hname："..self.hname)
end

function M:test2(value)
    LogUtil.log("我监听到属性改变了，新的值是："..value)
end

return BindUtilTest