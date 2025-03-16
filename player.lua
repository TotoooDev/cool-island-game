local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"
local Sprite = require "sprite"
local Input = require "input"

local Player = class({
    __includes = Sprite,
    speed = 300.0,
    canMove = true,
    isMoving = false,
    time = 0
})

function Player:init(map)
    Sprite.init(self, Vector(0.0, 0.0), Vector(64.0, 64.0), love.graphics.newImage("assets/images/player.png"))
    self.map = map
end

function Player:update(dt)
    if not self.canMove then
        return
    end

    self.isMoving = Input.up or Input.down or Input.left or Input.right
    if self.isMoving then
        self.size.y = math.sin(self.time * 15) * 5 + 59
    else
        self.size.y = 64.0
    end
    self.time = self.time + dt

    local nextPos = self.pos:clone()
    if Input.up    then nextPos.y = self.pos.y - self.speed * dt end
    if Input.down  then nextPos.y = self.pos.y + self.speed * dt end
    if Input.left  then nextPos.x = self.pos.x - self.speed * dt end
    if Input.right then nextPos.x = self.pos.x + self.speed * dt end

    local mapX = self.map:worldPosToMapCoords(nextPos).x
    local mapY = self.map:worldPosToMapCoords(nextPos).y
    if self.map.tiles[mapY] and self.map.tiles[mapY][mapX] and self.map.tiles[mapY][mapX] >= 4 then
        return
    end

    self.pos = nextPos
end

return Player
