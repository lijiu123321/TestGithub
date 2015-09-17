--
-- Author: lijiu
-- Date: 2015-09-15 20:08:49
--

local Player = class("Player", function()
	return display.newSprite("bird0_0.png")
end)

function Player:ctor()
	self:addStateMachine()
end

function Player:doEvent(event)
	if self.fsm:canDoEvent(event) then
		self.fsm:doEvent(event)
	end
end

function Player:addStateMachine()
	--创建状态机组件
	-- self.fsm={}
	-- cc.GameObject.extend(self.fsm):addComponent("components.behavior.StateMachine"):exportMethods()
	StateMachine = require("framework.cc.components.behavior.StateMachine")
	self.fsm = StateMachine.new()

	--初始化状态机（设置状态逻辑）
	self.fsm:setupState({
		initial = "none",--状态机的初始状态
		events = {--状态机转变时对应的事件
			{name = "move",from = {"idle","jump","none"},to = "walk"},
			{name = "attack",from = {"idle","walk","none"},to = "jump"},
			{name = "normal",from = {"walk","jump","none"},to = "idle"},
			{name = "stop",from = {"walk","jump","idle"},to = "none"}
		},

		--发生转变时的回调函数
		callbacks = {
		--normal 
		onenteridle = function()
				self:stopAllActions()
				local scale = cc.ScaleBy:create(0.2,1.2)
				self:runAction(cc.Repeat:create(transition.sequence({scale,scale:reverse()}),2))
				self.fsm:doEvent("stop")	
		end,

		--move
		onenterwalk = function()
				self:stopAllActions()
				local move = cc.MoveBy:create(0.2, cc.p(100, 0))
				self:runAction(cc.Repeat:create(transition.sequence({move,move:reverse()}), 2))
				self.fsm:doEvent("stop")	
		end,

		--attack
		-- onbeforattack = function()
		-- 	self:stopAllActions()
		-- end,
		onenterjump = function()
			self:stopAllActions()
			local jump = cc.JumpBy:create(0.5, cc.p(0, 0), 100, 2)
			self:runAction(jump)
			self.fsm:doEvent("stop")
		end,

		onenternone = function()
		end
		}
		})
end

return Player