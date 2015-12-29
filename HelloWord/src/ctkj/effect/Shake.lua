local Shake = class("Shake")

function Shake:ctor(target,delay,count,maxDis)
    if target.isShake then
        target:stopAction(target.action);
        target:setPosition(target.init_x,target.init_y);
    end
    
    target.isShake = true;
    target.init_x,target.init_y = target:getPosition();
    self.index = 0;
    local function func()
        if self.index + 1 <= count then
            local _mdx = math.random(1,maxDis);
            _mdx = CustomMath:AndOr( math.random()>0.5,_mdx,-_mdx);
            local _tx = target.init_x +_mdx;
            local _mdy = math.random(1,maxDis);
            _mdy = CustomMath:AndOr( math.random()>0.5,_mdy,-_mdy);
            local _ty = target.init_y +_mdy;
            target:setPosition(_tx,_ty);
            local moveTo = cc.MoveTo:create(delay-0.05,cc.p(target.init_x,target.init_y));
            target:runAction(moveTo);
            self.index = self.index + 1;
        else
            target:stopAction(target.action);
            target:setPosition(target.init_x,target.init_y);
            target.isShake = false;
        end
    end
    target.action = schedule(target,func,delay)
end

return Shake