local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"
local TextureRegistry = require "textureRegistry"
local Map = require "map"
local NPC = require "npcs.npc"
local Script = require "scripts.annie"

local AnnieNPC = class({ __includes = NPC })

function AnnieNPC:init()
    NPC.init(self,
        Vector(312.0, 777.0),
        Vector(64.0, 64.0),
        Map.Location.beachNorth,
        TextureRegistry.npcs.annie
    )

    self.flipImageHorizontally = true
end

function AnnieNPC:getScript()
    return Script()
end

return AnnieNPC
