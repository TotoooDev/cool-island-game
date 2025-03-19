local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"
local TextureRegistry = require "textureRegistry"
local Sprite = require "sprite"
local Input = require "input"
local Shovel = require "shovel"

local Player = class({
    __includes = Sprite,
    shovel = Shovel(),
    speed = 300.0,
    canMove = true,
    isMoving = false,
    digStartTime = 0.0,
    finishedDigging = false,
    time = 0,
    printPos = false,
    noClip = false
})

function Player:init(map)
    Sprite.init(self, Vector(800.0, 1024.0), Vector(64.0, 64.0), TextureRegistry.player[1])
    self.map = map

    if self.noClip ~= nil then
        print("HANK! HANK YOU'VE FORGOTTEN TO REMOVE THE NOCLIP STUFF! HAAAAAAAANK!")
    end
end

function Player:update(dt)
    self.time = self.time + dt

    local isDigging = false
    if self.time - self.digStartTime <= 1.2 and self.digStartTime ~= 0.0 then
        isDigging = true
        self.canMove = false
        self.pos.x = self.pos.x + math.sin(self.time * 50)

        if self.time - self.digStartTime > 1.0 then
            local mapCoords = self.map:worldPosToMapCoords(self.pos)
            self.shovel.foundSomething = self.map.pillarPos == mapCoords
            self.shovel:interact()
        end
    else
        self.finishedDigging = true
        self.canMove = true
    end

    if not self.canMove then
        return
    end

    self.isMoving = Input.up or Input.down or Input.left or Input.right
    if self.isMoving then
        self.size.y = math.sin(self.time * 20) * 5 + 59
    else
        self.size.y = 64.0
    end

    local nextPos = self.pos:clone()

    if isDigging then
        nextPos.x = nextPos.x + math.sin(self.time * 50)
    end

    if Input.up    then nextPos.y = self.pos.y - self.speed * dt end
    if Input.down  then nextPos.y = self.pos.y + self.speed * dt end
    if Input.left  then nextPos.x = self.pos.x - self.speed * dt end
    if Input.right then nextPos.x = self.pos.x + self.speed * dt end

    if nextPos.x < self.pos.x then self.flipImageHorizontally = false end
    if nextPos.x > self.pos.x then self.flipImageHorizontally = true end

    if not self.noClip then
        local mapCoords = self.map:worldPosToMapCoords(nextPos)
        if self.map.tiles[mapCoords.y] and self.map.tiles[mapCoords.y][mapCoords.x] and not self.map.tiles[mapCoords.y][mapCoords.x].walkable then
            nextPos = self.pos
        end
    end

    self.pos = nextPos
end

function Player:draw()
    if self.isMoving then
        if math.sin(self.time * 20) > 0.0 then
            self.image = TextureRegistry.player[2]
        else
            self.image = TextureRegistry.player[3]
        end
    else
        self.image = TextureRegistry.player[1]
    end

    Sprite.draw(self)
end

function Player:tryDig()
    if self.shovel then
        self.digStartTime = self.time
    end
end

return Player
