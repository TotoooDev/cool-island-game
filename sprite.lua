local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"

local Sprite = class({
    flipImageHorizontally = false,
    flipImageVertically = false,
})

function Sprite:init(pos, size, image)
    self.pos = pos:clone()
    self.size = size:clone()
    self.image = image or love.graphics.newImage("assets/images/ohno.png")
end

function Sprite:draw()
    local flipperHorizontal = 1
    local offsetX = 0
    local flipperVertical = 1
    local offsetY = 0

    if self.flipImageHorizontally then
        flipperHorizontal = -1
        offsetX = self.image:getWidth()
    end
    if self.flipImageVertically then
        flipperVertical = -1
        offsetY = self.image:getHeight()
    end

    love.graphics.draw(
        self.image,
        self.pos.x - self.size.x / 2,
        self.pos.y - self.size.y / 2,
        0.0,
        self.size.x / self.image:getWidth() * flipperHorizontal,
        self.size.y / self.image:getHeight() * flipperVertical,
        offsetX,
        offsetY
    )
end

return Sprite
