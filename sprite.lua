local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"

local Sprite = class({
    color = { 1.0, 1.0, 1.0, 1.0 } -- TEMPORARY
})

function Sprite:init(pos, size, image)
    self.pos = pos:clone()
    self.size = size:clone()
    self.image = image or love.graphics.newImage("assets/images/ohno.png")
end

function Sprite:draw()
    love.graphics.draw(
        self.image,
        self.pos.x - self.size.x / 2,
        self.pos.y - self.size.y / 2,
        0.0,
        self.size.x / self.image:getWidth(),
        self.size.y / self.image:getHeight()
    )
end

return Sprite
