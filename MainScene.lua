local Player = require("app.scenes.Player")
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local player = Player.new()
    player:setPosition(300, 300)
    self:addChild(player)
--别人修改东西
    local function click(event)
        local seq = cc.Sequence:create(cc.DelayTime:create(5),cc.CallFunc:create(function()
                event.target:setTouchEnabled(true)
            end))
    	if event.target:getTag() == 1 then
    		player:doEvent("normal")
            event.target:setTouchEnabled(false)
            self:runAction(seq)
    	elseif event.target:getTag() == 2 then
    		player:doEvent("move")
            event.target:setTouchEnabled(false)
            self:runAction(seq)
    	elseif event.target:getTag() == 3 then
    		player:doEvent("attack")
            event.target:setTouchEnabled(false)
            self:runAction(seq)
    	end
    end

    local normalButton = cc.ui.UIPushButton.new({normal = "bird0_0.png"},{scale9 = true})
    normalButton:onButtonClicked(click)
    normalButton:pos(100, 80)
    normalButton:setTag(1)
    self:addChild(normalButton)

    local moveButton = cc.ui.UIPushButton.new({normal = "bird0_0.png"},{scale9 = true})
    moveButton:onButtonClicked(click)
    moveButton:pos(150, 80)
    moveButton:setTag(2)
    self:addChild(moveButton)

    local attackButton = cc.ui.UIPushButton.new({normal = "bird0_0.png"},{scale9 = true})
    attackButton:onButtonClicked(click)
    attackButton:pos(200, 80)
    attackButton:setTag(3)
    self:addChild(attackButton)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
