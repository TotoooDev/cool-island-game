local class = require "lib.hump.class"
local Vector = require "lib.hump.vector"
local TextureRegistry = require "textureRegistry"
local Map = require "map"
local NPC = require "npcs.npc"
local Script = require "scripts.shovelknight"

local ShovelKnightNPC = class({ __includes = NPC })

function ShovelKnightNPC:init(player)
    self.player = player
    NPC.init(self,
        Vector(412.0, 777.0),
        Vector(64.0, 64.0),
        Map.Location.beachNorth
    )

    self.flipImageHorizontally = true
end

function ShovelKnightNPC:getScript()
    return Script(self.player)
end

return ShovelKnightNPC
