local class = require "lib.hump.class"
local Timer = require "lib.hump.timer"
local Vector = require "lib.hump.vector"
local TextureRegistry = require "textureRegistry"
local Input = require "input"

local Plan = class({
    easeDuration = 0.3,
    hidden = true,
    mustShow = false,
    mustHide = false,
    isShowing = false,
    isHiding = false
})

function Plan:init(player)
    local windowHeight = love.graphics.getHeight()
    self.pos = Vector(0.0, windowHeight)
    self.player = player
    self.mapImage = TextureRegistry.plan;
end

function Plan:show()
    Timer.tween(
        self.easeDuration,
        self,
        { pos = { y = 0.0 } },
        "out-back",
        function ()
            self.isShowing = false
            self.hidden = false
        end
    )
end

function Plan:hide()
    local windowHeight = love.graphics.getHeight()
    Timer.tween(
        self.easeDuration,
        self,
        { pos = { y = windowHeight } },
        "in-back",
        function ()
            self.isHiding = false
            self.hidden = true
        end
    )
end

function Plan:update(dt)

    if Input.plan and not self.isShowing then
        self.mustShow = true
    end
    if not Input.plan and not self.isHiding and not self.hidden then
        self.mustHide = true
    end

    if self.mustShow then
        self.isShowing = true
        self:show()
        self.mustShow = false
    end

    if self.mustHide then
        self.isHiding = true
        self:hide()
        self.mustHide = false
    end
end

function Plan:draw()
    if not self.isShowing and not self.isHiding then
        return
    end

    love.graphics.setColor({ 1.0, 1.0, 1.0 })

    love.graphics.draw(
        self.mapImage,
        self.pos.x,
        self.pos.y,
        0,
        love.graphics.getWidth() / self.mapImage:getWidth(),
        love.graphics.getHeight() / self.mapImage:getHeight()
    )

    -- love.graphics.draw(
    --     self.player.image,
    --     self.player.pos.x + self.pos.x,
    --     self.player.pos.y + self.pos.y,
    --     0,
    --     4 / self.player.size.x,
    --     4 / self.player.size.y
    -- )
end

return Plan
