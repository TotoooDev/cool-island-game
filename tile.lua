local TileType = {
    { name = "sand",  bmpColor = { 255, 255, 0   }, image = love.graphics.newImage("assets/images/ohno.png") },
    { name = "grass", bmpColor = { 0,   255, 0   }, image = love.graphics.newImage("assets/images/ohno.png") },
    { name = "rock",  bmpColor = { 127, 127, 127 }, image = love.graphics.newImage("assets/images/ohno.png") },
    { name = "wall",  bmpColor = { 0  , 0  , 0   }, image = love.graphics.newImage("assets/images/ohno.png") },
    { name = "water", bmpColor = { 0  , 0  , 255 }, image = love.graphics.newImage("assets/images/ohno.png") },
}

function TileType.getTile(r, g, b)
    for i, tile in ipairs(TileType) do
        if r == tile.bmpColor[1] and
            g == tile.bmpColor[2] and
            b == tile.bmpColor[3]
        then
            return i
        end
    end

    return nil
end

return TileType
