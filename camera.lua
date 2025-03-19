local class = require "lib.hump.class"
local HumpCamera = require "lib.hump.camera"
local Vector = require "lib.hump.vector"

local Camera = class({
    deadzone = 32,
    smoothFunction = HumpCamera.smooth.damped(10.0)
})

function Camera:init(target, map)
    self.target = target
    self.map = map
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

    local topLeftCoords = self:toWorldCoords(Vector(0, 0))
    local bottomRightCoords = self:toWorldCoords(Vector(windowWidth, windowHeight))

    if topLeftCoords.x < 0.0 then
        local _, y = self.camera:position()
        self.camera:lookAt(windowWidth / 2, y)
    end
    if topLeftCoords.y < 0.0 then
        local x, _ = self.camera:position()
        self.camera:lookAt(x, windowHeight / 2)
    end
    if bottomRightCoords.x > self.map.extent.x then
        local _, y = self.camera:position()
        self.camera:lookAt(self.map.extent.x - windowWidth / 2, y)
    end
    if bottomRightCoords.y > self.map.extent.y then
        local x, _ = self.camera:position()
        self.camera:lookAt(x, self.map.extent.y - windowHeight / 2)
    end
end

function Camera:attach()
    self.camera:attach()
end

function Camera:detach()
    self.camera:detach()
end

function Camera:toWorldCoords(vec)
    local x, y = self.camera:worldCoords(vec.x, vec.y)
    return Vector(x, y)
end

function Camera:toLocalCoords(vec)
    local x, y = self.camera:cameraCoords(vec.x, vec.y)
    return Vector(x, y)
end

return Camera
