cc.exports.TimeUtil = {}

function TimeUtil.getMS(time)
    local m = math.floor(time/60);
    local s = math.floor(time%60);
    m = CustomMath:AndOr( m<10, "0"..m, m );
    s = CustomMath:AndOr( s<10, "0"..s, s );
    return m,s
end

return TimeUtil