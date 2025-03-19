local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"
local Bitmap = require "lib.lua-bitmap"
local TextureRegistry = require "textureRegistry"

local Map = class({
    Location = {
        beachNorth = 1,
        beachSouth = 2,
        forest = 3,
        volcano = 4
    },

    tileSize = 32,
    pillarPos = Vector(-1000, -1000)
})

function Map.bmpPixelToTile(location, bmp, x, y)
    local r, g, b, _ = bmp:get_pixel(x, y)

    -- walkable tile
    if r == 255 and g == 255 and b == 255 then
        if location == Map.Location.beachNorth then
            return { walkable = true, image = TextureRegistry.sand[love.math.random(#TextureRegistry.sand)] }
        end
    end

    if r == 0 and g == 0 and b == 255 then return     { walkable = false, image = TextureRegistry.water } end
    if r == 0 and g == 255 and b == 0 then return     { walkable = false, image = TextureRegistry.forest} end
    if r == 127 and g == 127 and b == 127 then return { walkable = false, image = TextureRegistry.rock } end

    return { walkable = true, image = TextureRegistry.ohno}
end

function Map:init(filename, location)
    local bmp, err = Bitmap.from_file(filename)
    if bmp == nil then
        error("failed to load map " .. filename .. " " .. err)
    end

    self.width = bmp.width
    self.height = bmp.height
    self.extent = Vector(self.width * self.tileSize, self.height * self.tileSize)

    self.tiles = {}
    for y = 0, bmp.height - 1, 1 do
        local line = {}
        for x = 0, bmp.width - 1, 1 do
            table.insert(line, Map.bmpPixelToTile(location, bmp, x, y))
        end
        table.insert(self.tiles, line)
    end

    if location == Map.Location.beachNorth then
        self.pillarPos = Vector(25, 32)
    end
end

function Map:draw()
    for y, line in ipairs(self.tiles) do
        for x, tile in ipairs(line) do
            love.graphics.draw(
                tile.image,
                (x - 1) * self.tileSize,
                (y - 1) * self.tileSize,
                0,
                self.tileSize / tile.image:getWidth(),
                self.tileSize / tile.image:getHeight()
            )
        end
    end
end

function Map:worldPosToMapCoords(pos)
    return Vector(math.ceil(pos.x / self.tileSize), math.ceil(pos.y / self.tileSize))
end

return Map
