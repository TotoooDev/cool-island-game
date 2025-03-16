local class = require "lib.hump.class"
local HumpCamera = require "lib.hump.camera"

local Camera = class({
    deadzone = 32,
    smoothFunction = HumpCamera.smooth.damped(10.0)
})

function Camera:init(target)
    self.target = target
    self.camera = HumpCamera(self.target.x, self.target.y)
end

function Camera:update(dt)
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()

    self.camera:lockWindow(
        self.target.x,
        self.target.y,
        windowWidth / 2 - self.deadzone,
        windowWidth / 2 + self.deadzone,
        windowHeight / 2 - self.deadzone,
        windowHeight / 2 + self.deadzone,
        self.smoothFunction
    )
end

function Camera:attach()
    self.camera:attach()
end

function Camera:detach()
    self.camera:detach()
end

return Camera
