require "ctkj.utils.LogUtil"
local MyApp = class("MyApp", cc.load("mvc").AppBase)

function MyApp:onCreate()
    LogUtil.log("app create");
    math.randomseed(os.time())
end

return MyApp
