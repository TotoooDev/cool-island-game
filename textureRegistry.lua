local TextureRegistry = {
    ohno = nil,
    plan = nil,
    npcs = {},
    sand = {},
    player = {
        annie = nil
    },
    water = nil,
    forest = nil,
    rock = nil,
}

function TextureRegistry.loadImages()
    TextureRegistry.ohno = love.graphics.newImage("assets/images/ohno.png")
    TextureRegistry.plan = love.graphics.newImage("assets/images/plan.png")

    table.insert(TextureRegistry.player, love.graphics.newImage("assets/images/player/player.png"))
    table.insert(TextureRegistry.player, love.graphics.newImage("assets/images/player/player1.png"))
    table.insert(TextureRegistry.player, love.graphics.newImage("assets/images/player/player2.png"))

    table.insert(TextureRegistry.sand, love.graphics.newImage("assets/images/sand/sand1.png"))
    table.insert(TextureRegistry.sand, love.graphics.newImage("assets/images/sand/sand2.png"))
    table.insert(TextureRegistry.sand, love.graphics.newImage("assets/images/sand/sand3.png"))
    table.insert(TextureRegistry.sand, love.graphics.newImage("assets/images/sand/sand4.png"))
    table.insert(TextureRegistry.sand, love.graphics.newImage("assets/images/sand/sand5.png"))
    table.insert(TextureRegistry.sand, love.graphics.newImage("assets/images/sand/sand6.png"))

    TextureRegistry.npcs.annie = love.graphics.newImage("assets/images/npcs/annie.png")

    TextureRegistry.water = love.graphics.newImage("assets/images/water.png")
    TextureRegistry.forest = love.graphics.newImage("assets/images/forest.png")
    TextureRegistry.rock = love.graphics.newImage("assets/images/rock.png")
end

return TextureRegistry
