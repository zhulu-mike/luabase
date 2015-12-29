
cc.exports.CustomMath = class("CustomMath")

-- 自定义数学公式类
function CustomMath:ctor(  )
	
end

-- C++的三元表达式 如果condition为true 返回param1 否则返回param2
function CustomMath:AndOr( condition, param1, param2 )

	if condition then
		return param1
	else
		return param2
	end
end

return CustomMath