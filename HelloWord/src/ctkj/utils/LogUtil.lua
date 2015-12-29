cc.exports.LogUtil = {}

function LogUtil.log(value)
    if (DEBUG ~= 0) then
        release_print("info:"..value);
    end
end

function LogUtil.warn(value)
    if (DEBUG ~= 0) then
        release_print("warn:"..value);
    end
end

function LogUtil.error(value)
    if (DEBUG ~= 0) then
        release_print("error:"..value);
    end
end

return LogUtil