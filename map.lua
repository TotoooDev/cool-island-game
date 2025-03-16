local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"
local Bitmap = require "lib.lua-bitmap"
local TileType = require "tile"

local Map = class({
    tileSize = 32.0,
    tiles = {}
})

function Map:init(filename)
    local bmp = Bitmap.from_file(filename)
    if bmp == nil then
        error("failed to read map " .. filename)
    end

    self.tiles = {}
    for y = 0, bmp.height - 1, 1 do
        local line = {}
        for x = 0, bmp.width - 1, 1 do
            local r, g, b, _ = bmp:get_pixel(x, y)
            table.insert(line, TileType.getTile(r, g, b))
        end
        table.insert(self.tiles, line)
    end

    self.pos = Vector(#self.tiles / 2 * self.tileSize, #self.tiles / 2 * self.tileSize)
end

function Map:draw()
    for y, tiles in ipairs(self.tiles) do
        for x, tile in ipairs(tiles) do
            love.graphics.setColor(TileType[tile].bmpColor[1] / 255, TileType[tile].bmpColor[2] / 255, TileType[tile].bmpColor[3] / 255)
            love.graphics.rectangle("fill", (x - 1) * self.tileSize - self.pos.x, (y - 1) * self.tileSize - self.pos.y, self.tileSize, self.tileSize)
            love.graphics.setColor(1.0, 1.0, 1.0)

            -- love.graphics.draw(
            --     TileType[tile].image,
            --     (x - 1) * self.tileSize,
            --     (y - 1) * self.tileSize,
            --     self.tileSize / TileType[tile].image:getWidth(),
            --     self.tileSize / TileType[tile].image:getHeight()
            -- )
        end
    end
end

function Map:worldPosToMapCoords(pos)
    local x = math.ceil((pos.x + self.pos.x) / self.tileSize)
    local y = math.ceil((pos.y + self.pos.y) / self.tileSize)
    return Vector(x, y)
end

return Map
